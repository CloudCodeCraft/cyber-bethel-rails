module Users
  class CreationService < ApplicationService
    def initialize(username:, password:, password_confirmation:)
      @username = username
      @password = password
      @password_confirmation = password_confirmation
    end

    private

    def run!
      password_digest_service = PasswordDigestGenerationService.new(
        password: @password,
        password_confirmation: @password_confirmation
      )
      password_digest = password_digest_service.execute!
      user = User.new(username: @username, password_digest: password_digest)
      unless user.valid?
        raise ActiveRecord::RecordInvalid, user.errors.full_messages.to_sentence
      end

      user.save!
    end
  end
end
