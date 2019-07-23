class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance

  def balance
    object.balance.format
  end
end
