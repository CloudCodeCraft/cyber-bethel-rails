module Users
  class UsernameNotUniqueError < StandardError
    def initialize(message = "Username is already taken")
      super
    end
  end
end
