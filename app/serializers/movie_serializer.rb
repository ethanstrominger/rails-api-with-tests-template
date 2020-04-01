class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :director, :year
  has_one :user
end
