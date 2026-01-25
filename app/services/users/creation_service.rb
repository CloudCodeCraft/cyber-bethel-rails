module Users
  class CreationService < ApplicationService
    def initialize(username:, password:, password_confirmation:)
      @username = username
      @password = password
      @password_confirmation = password_confirmation
    end

    private

    def run!
      UsernameUniquenessService.new(username: @username).execute!

      password_digest_service = PasswordDigestGenerationService.new(
        password: @password,
        password_confirmation: @password_confirmation
      )
      password_digest = password_digest_service.execute!
      User.create!(username: @username, password_digest: password_digest)
    end
  end
end
