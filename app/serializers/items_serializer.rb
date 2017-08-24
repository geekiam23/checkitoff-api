class ItemsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :done, :list_id
end
