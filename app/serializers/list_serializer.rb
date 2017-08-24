class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id
end
