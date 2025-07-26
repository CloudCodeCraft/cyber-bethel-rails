class User
  include ApplicationModel

  field :username, type: String
  field :password_digest, type: BCrypt::Password

  index({ username: 1 }, { unique: true })

  has_many :sessions

  def bcrypt_password
    BCrypt::Password.new(password_digest)
  end
end
