class PrayerRequest
  include ApplicationModel

  belongs_to :user
  field :title, type: String
  field :body, type: String


  index(:user_id)
end