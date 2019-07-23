require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'Relationships' do
    it { is_expected.to belong_to(:user) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:user) }

    it 'does not allow negative balance' do
      account = Account.new(balance: "-200,00")

      expect(account).to be_invalid
    end
  end
end
