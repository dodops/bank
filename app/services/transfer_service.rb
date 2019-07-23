class TransferService < BaseBankService
  def self.call(source_account, destination_account, amount)
    return false unless amount_valid?(amount) && amount_available?(source_account, amount)

    Account.transaction do
      CashWithdrawalService.call(source_account, amount)

      destination_account.balance = (destination_account.balance += amount.to_money)
      destination_account.save!
      source_account
    end
  end
end
