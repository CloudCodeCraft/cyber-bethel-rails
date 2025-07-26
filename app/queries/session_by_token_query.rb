class SessionByTokenQuery
  def initialize(encrypted_token)
    @encrypted_token = encrypted_token
  end

  def execute
    return nil if @encrypted_token.blank?

    session_id = SessionToken.convert_to_id(@encrypted_token)
    return nil if session_id.blank?

    Session.find_by(id: session_id)
  end
end