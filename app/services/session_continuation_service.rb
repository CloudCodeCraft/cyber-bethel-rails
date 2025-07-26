class SessionContinuationService < ApplicationService
  def initialize(encrypted_token)
    @encrypted_token = encrypted_token
  end

  def run!
    session = SessionByTokenQuery.new(@encrypted_token).execute
    session.update!(last_seen_at: Time.now)
    session
  end

  def validate

  end
end