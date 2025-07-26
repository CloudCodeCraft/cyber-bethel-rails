class SessionCreationService < ApplicationService
  def initialize(username, password)
    @username = username
    @password = password
  end

  def run!
    session = Session.create!(user: @user)
    SessionToken.create(session.id.to_s)
  end

  def validate
    @validation_errors = []
    @validation_errors.push("username is missing") if @username.blank?
    @validation_errors.push("password is missing") if @password.blank?

    @user = User.find_by(username: @username)
    @validation_errors.push("username or password is not correct") if @user.blank?
    @validation_errors.push("username or password is not correct") if @user.bcrypt_password != @password
  end
end