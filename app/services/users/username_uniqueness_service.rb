module Users
  class UsernameUniquenessService < ApplicationService
    def initialize(username:)
      @username = username
    end

    private

    def run!
      raise UsernameNotUniqueError if User.where(username: @username).first.present?
      true
    end
  end
end
