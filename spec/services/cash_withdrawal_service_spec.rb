require 'rails_helper'

RSpec.describe CashWithdrawalService, type: :service do
  describe '#call' do
    let!(:account) { create(:account, balance: "10,00") }

    context 'when withdrawn value is valid' do
      it 'returns true' do
        withdrawn = described_class.call(account, "5,20")

        expect(withdrawn).to eq true
      end
    end

    context 'when withdrawn value is invalid' do
      it 'returns falsy' do
        withdrawn = described_class.call(account, 0)
        expect(withdrawn).to eq false
      end
    end

    context 'when account does not have enough balance' do
      let!(:account) { create(:account, balance: "1.234,30") }

      it 'returns falsy' do
        withdrawn = described_class.call(account, "2.000,00")

        expect(withdrawn).to be false
      end

      it 'keeps the balance value unchanged' do
        described_class.call(account, "2.215,00")

        expect(account.balance.format(symbol: false)).to eq "1.234,30"
      end
    end

    context 'when account have money' do
      let(:account) { create(:account, balance: "123,00") }

      it 'returns true' do
        described_class.call(account, "50,00")
      end

      it 'withdraw from account' do
        expect{
          described_class.call(account, "50,00")
        }.to change{ account.balance.format(symbol: false) }.from("123,00").to("73,00")
      end
    end
  end
end
