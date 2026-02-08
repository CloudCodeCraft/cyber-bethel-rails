module UserValidations
  extend ActiveSupport::Concern

  included do
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :password_digest, presence: true
  end
end
