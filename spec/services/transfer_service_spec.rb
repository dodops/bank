require 'rails_helper'

RSpec.describe TransferService, type: :service do
  describe '#transfer' do
    context 'the source account does have enough money' do
      let(:source_account) { create(:account, balance: "5.000,00") }
      let(:destination_account) { create(:account, balance: "40,00") }

      it 'move quantity from one to another' do
        described_class.call(source_account, destination_account, "60,00")

        expect(source_account.plain_balance).to eq "4.940,00"
        expect(destination_account.plain_balance).to eq "100,00"
      end

      it 'returns true' do
        transferency = described_class.call(source_account, destination_account, "60,00")

        expect(transferency).to be_truthy
      end
    end

    context 'when the source account does not have enough money' do
      let(:source_account) { create(:account, balance: "90,00") }
      let(:destination_account) { create(:account, balance: "40,00") }

      it 'prevent transfer action' do
        described_class.call(source_account, destination_account, "160,00")

        expect(source_account.plain_balance).to eq "90,00"
        expect(destination_account.plain_balance).to eq "40,00"
      end

      it 'returns false' do
        transferency = described_class.call(source_account, destination_account, "91,00")

        expect(transferency).to be false
      end
    end
  end
end
