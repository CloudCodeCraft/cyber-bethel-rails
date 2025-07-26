class SessionToken
  SESSION_ENCRYPTION_SALT = ENV["SESSION_ENCRYPTION_SALT"].freeze
  SESSION_ENCRYPTION_SECRET = ENV["SESSION_ENCRYPTION_SECRET"].freeze

  class << self
    def create(session_id)
      encryptor.encrypt_and_sign(session_id)
    end

    def convert_to_id(token)
      encryptor.decrypt_and_verify(token)
    rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveSupport::MessageEncryptor::InvalidMessage
      nil
    rescue StandardError => e
      Rails.logger.error "Error decrypting session id #{token} becaues of error #{e}"
      Rails.logger.error e.backtrace.join("\n")
    end

    def encryptor
      key = ActiveSupport::KeyGenerator.new(SESSION_ENCRYPTION_SECRET).generate_key(SESSION_ENCRYPTION_SALT, 32)
      ActiveSupport::MessageEncryptor.new(key, cipher: 'aes-256-gcm', url_safe: true)
    end
  end
end
