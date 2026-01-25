module Users
  class PasswordsDoNotMatchError < StandardError
    def initialize(msg = "Passwords do not match")
      super
    end
  end
end
