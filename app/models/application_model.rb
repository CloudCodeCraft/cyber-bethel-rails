module ApplicationModel
  extend ActiveSupport::Concern

  include Mongoid::Document
  include Mongoid::Timestamps
end