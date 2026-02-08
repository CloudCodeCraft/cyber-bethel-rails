class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class


  def persist!
    self.save!(validate: false)
  end
end
