class BaseBankService
  protected

  def self.amount_available?(account, amount)
    target = account.balance.to_money - amount.to_money
    return false if target.negative?
    true
  end

  def self.amount_valid?(amount)
    return true if amount.to_money.positive?
    false
  end
end
