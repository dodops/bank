require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'Validations' do
    it 'does not allow negative balance' do
      account = Account.new(balance: "-200,00")

      expect(account).to be_invalid
    end
  end
end
