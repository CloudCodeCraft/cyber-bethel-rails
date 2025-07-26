class PrayerRequestsByUserQuery
  def initialize(user, keep_anon = true)
    @user = user
    @keep_anon = keep_anon
  end

  def execute
    requesters = PrayerRequest::Requester.find_by(user: @user)
    requests = PrayerRequest::Request.where(requester: requesters)
    return requests if @keep_anon

    requests.map { |request| request.as_json.merge(user.as_json) }
  end
end