module Users
  class TokenHashGeneratorService < ApplicationService
    def initialize(token: nil)
      @token = token
    end

    private

    def run!
      if @token.blank?
        @token = SecureRandom.hex(32)
      end
      Digest::SHA256.hexdigest(token)
    end
  end
end
