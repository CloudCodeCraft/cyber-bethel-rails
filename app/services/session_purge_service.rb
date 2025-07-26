class SessionPurgeService < ApplicationService
  def initialize(user)
    @user = user
  end

  def run!
    @user.sessions.each do |session|
      session.destroy!
    end
    true
  end

  def validate

  end
end