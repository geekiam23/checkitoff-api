class UserSerializer < ActiveModel::Serializer
  attributes :id, :provider, :uid, :created_at, :name, :email, :tokens

  # def full_name
  #   object.full_name
  # end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
