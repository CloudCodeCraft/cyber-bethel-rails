  class UserCreationService < ApplicationService
    def initialize(username, password, password_confirmation)
      @username = username
      @password = password
      @password_confirmation = password_confirmation
    end

    def run!
      password_digest = BCrypt::Password.create(@password)
      User.create!(username: @username, password_digest: password_digest)
    end

    def validate
      @validation_errors = []
      @validation_errors.push("username is missing") if @username.blank?
      @validation_errors.push("password is missing") if @password.blank?
      @validation_errors.push("password_confirmation is missing") if @password_confirmation.blank?
      @validation_errors.push("password and password_confirmation do not match") if @password != @password_confirmation
      @validation_errors.push("password is too short") if @password.length < 8
    end
  end
