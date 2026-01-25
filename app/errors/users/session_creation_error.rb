module Users
  class SessionCreationError < StandardError
    def initialize(msg = "Username or password is invalid")
      super
    end
  end
end
