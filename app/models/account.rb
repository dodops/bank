class Account < ApplicationRecord
  monetize :balance_cents

  validate :negative_amount

  def plain_balance
    balance.format(symbol: false)
  end

  private

  def negative_amount
    return unless balance.to_money.negative?

    errors.add(:balance, :negative)
  end
end
