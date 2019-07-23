class CashWithdrawalService < BaseBankService
  def self.call(account, amount)
    return false unless amount_valid?(amount) && amount_available?(account, amount)

    account.balance = (account.balance -= amount.to_money)
    account.save!
  end
end
