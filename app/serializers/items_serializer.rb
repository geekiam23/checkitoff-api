class ItemsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :done
end
