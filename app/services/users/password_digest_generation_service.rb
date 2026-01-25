module Users
  class PasswordDigestGenerationService < ApplicationService
    include BCrypt

    def initialize(password:, password_confirmation:)
      @password = password
      @password_confirmation = password_confirmation
    end

    private
    def run!
      if @password != @password_confirmation
        raise PasswordsDoNotMatchError
      end

      if @password.length < 8
        raise PasswordTooShortError
      end

      Password.create(@password)
    end
  end
end
