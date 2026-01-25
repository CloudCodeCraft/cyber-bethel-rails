module Users
  class SessionValidationService < ApplicationService
    def initialize(user_id:, token:)
      @user_id = user_id
      @token = token
    end

    private

    def run!
      session = Session.where(user_id: @user_id, token_hash: @token_hash).first
      raise SessionNotFoundError if session.blank?


    end
  end
end
