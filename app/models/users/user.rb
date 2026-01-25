module Users
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :username, type: String
    field :password_digest, type: String

    has_many :sessions, dependent: :destroy
  end
end
