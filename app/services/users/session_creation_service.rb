module Users
  class SessionCreationService < ApplicationService
    include BCrypt

    def initialize(username:, password:, user_agent:)
      @username = username
      @password = password
      @user_agent = user_agent
    end

    private

    def run!
      user = User.where(username: @username).first
      raise SessionCreationError if user.blank?
      raise SessionCreationError unless Password.new(user.password_digest) == @password

      token_hash = TokenHashGeneratorService.new.execute!
      session = Session.create!(user_id: user.id, user_agent: @user_agent, token_hash: token_hash)
      { token: token, user_id: session.user.id, user_agent: session.user_agent }
    end
  end
end
