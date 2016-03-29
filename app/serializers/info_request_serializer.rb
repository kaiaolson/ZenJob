class InfoRequestSerializer < ActiveModel::Serializer
  attributes :id

  has_one :submission

end
