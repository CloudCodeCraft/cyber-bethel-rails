class PrayerRequestCreationService < ApplicationService
  def initialize(user, is_anon, title, body)
    @user = user
    @is_anon = is_anon
    @title = title
    @body = body
  end

  def run!
    requester = PrayerRequest::Requester.create!(user: @user)
    prayer = PrayerRequest::Request.create!(requester: requester, is_anonymous: @is_anon, title: @title, body: @body)
    prayer
  end

  def validate
    @validation_errors = []
    @validation_errors.push('is_anon should be a boolean') unless @is_anon.is_a?(TrueClass) || @is_anon.is_a?(FalseClass)
    @validation_errors.push('user should be an User') unless @is_anon.is_a?(User)
    @validation_errors
  end
end