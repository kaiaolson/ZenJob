class Category < ActiveRecord::Base
  has_many :info_requests, dependent: :nullify
end
