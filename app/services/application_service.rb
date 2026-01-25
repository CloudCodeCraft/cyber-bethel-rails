class ApplicationService
  def execute!
    before_run
    result =
      begin
        run!
      rescue StandardError => e
        # TODO: add some logging here
        raise e
      end
    after_run
    result
  end

  def name
    self.class.name
  end

  def before_run
    @before_run_call_time = Time.now
    Rails.logger.info("#{name} before_run")
  end

  def after_run
    @after_run_call_time = Time.now
    Rails.logger.info("#{name} after_run")
  end

  private

  def run!
    raise NotImplementedError
  end
end
