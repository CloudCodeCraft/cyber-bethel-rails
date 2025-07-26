class Session
  include ApplicationModel

  field :user_id, type: BSON::ObjectId
  field :last_seen_at, type: Time

  index({ user_id: 1 })

  belongs_to :user
end