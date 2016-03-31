class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :info_requests, :submissions

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
