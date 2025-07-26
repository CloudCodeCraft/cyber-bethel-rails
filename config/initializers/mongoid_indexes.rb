Rails.configuration.after_initialize do
  User.create_indexes
  Session.create_indexes
end