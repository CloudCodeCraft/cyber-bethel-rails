module Users
  class PasswordTooShortError < StandardError
    def initialize(msg = "Passwords must be 8 characters or longer")
      super
    end
  end
end
