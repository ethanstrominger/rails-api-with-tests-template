class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :director, :year
  # template instructions: maybe remove has_one?
  has_one :user

  # template instructions: add this code if you generate using scaffold
  def editable
    scope == object.user
  end
end
