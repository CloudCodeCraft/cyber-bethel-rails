module Users
  class SessionNotFoundError < StandardError
    def initialize(msg = "Session not found for user and token hash")
    end
  end
end
