module Users
  class Session
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :user
    field :user_agent, type: String
    field :token_hash, type: String
    field :refresh_dates, type: Array
  end
end
