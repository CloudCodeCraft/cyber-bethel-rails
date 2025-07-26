  class ApplicationService
    class Result
      STATUSES = [:success, :failure, :validation_error].freeze

      def initialize(execution_id, status_index, return_value, validation_errors, execution_error_message)
        @execution_id = execution_id
        @status = STATUSES[status_index]
        @return_value = return_value
        @validation_errors = validation_errors
        @execution_error_message = execution_error_message
      end

      def success?
        @status == :success
      end

      def value
        @return_value
      end

      # Define how this object should be represented as a hash for JSON serialization
      def as_json(options = {})
        {
          execution_id: @execution_id,
          status: @status,
          return_value: @return_value,
          validation_errors: @validation_errors,
          execution_error_message: @execution_error_message
        }
      end
    end

    def execute
      @execution_id = SecureRandom.uuid
      Rails.logger.info "[#{@execution_id}] Attempting to execute #{self.class}"
      if valid?
        return_value = run!
        Result.new(@execution_id, 0, return_value, @validation_errors, nil)
      else
        Rails.logger.error "[#{@execution_id}] Skipping run for #{self.class} because of validation errors"
        Result.new(@execution_id, 2, nil, @validation_errors, nil)
      end
    rescue StandardError => e
      Rails.logger.error "[#{@execution_id}] Run caused errors for #{self.class}"
      Rails.logger.error e.message
      @execution_error_message = e.message
      Result.new(@execution_id, 1, nil, @validation_errors, @execution_error_message)
    end

    def run!
      raise NotImplementedError, "#run must be implemented in subclasses"
    end

    def validate
      raise NotImplementedError, "#validate! must be implemented in subclasses"
    end

    def valid?
      Rails.logger.info "[#{@execution_id}] Validating for service #{self.class}"
      validate
      @validation_errors.blank?
    rescue StandardError => e
      Rails.logger.error "[#{@execution_id}] Validation for service #{self.class} failed"
      false
    end

    def self.inherited(subclass)
      # Wrap existing instance methods (public, protected, private)
      subclass.instance_methods(false).each do |method_name|
        wrap_instance_method(subclass, method_name)
      end

      # Define method_added in subclass to catch future instance methods
      subclass.class_eval do
        def self.method_added(method_name)
          return if @_wrapping_method

          @_wrapping_method = true
          ApplicationService.wrap_instance_method(self, method_name) if [:run!, :validate ].include?(method_name)
          @_wrapping_method = false
        end
      end
    end

    def self.wrap_instance_method(klass, method_name)
      original = klass.instance_method(method_name)

      klass.define_method(method_name) do |*args, &block|
        result = original.bind(self).call(*args, &block)
        result
      end

      # Preserve original visibility
      visibility =
        if klass.private_method_defined?(method_name)
          :private
        elsif klass.protected_method_defined?(method_name)
          :protected
        else
          :public
        end

      klass.send(visibility, method_name)
    end
  end
