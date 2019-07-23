require 'rails_helper'

describe AccountsController, type: :controller do
  let!(:user) { create :user }

  before do
    token = "Bearer #{user.api_token}"
    request.headers.merge!({"Authorization" => token})
  end

  describe "POST #create" do
    context 'when params are valid' do
      let(:params) { { account: { balance: "500,00" } } }

      it 'returns http created status' do
        post :create, params: params, as: :json

        expect(response).to have_http_status(:created)
      end

      it 'returns account object' do
        post :create, params: params, as: :json

        result = JSON.parse(response.body)

        expect(result['balance']).to eq 'R$500,00'
      end
    end

    context 'when params are not valid' do
      let(:params) { { account: { balance: "-2.000,00" } } }

      it 'returns http error status' do
        post :create, params: params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#POST transfer' do
    let!(:source) { create :account, user: user, balance: "3.500,00" }
    let!(:destination) { create :account, balance: "30,00" }

    context 'when source account have enough money' do
      let(:params) { { source_account_id: source.id, destination_account_id: destination.id, amount: "500,00" } }

      it 'returns http status for success' do
        post :transfer, params: params, as: :json

        expect(response).to have_http_status(:success)
      end

      it 'show message for success action' do
        post :transfer, params: params, as: :json

        result = JSON.parse(response.body)

        expect(result).to include('message')
      end
    end

    context 'when source account does not have enough money' do
      let(:params) { { source_account_id: source.id, destination_account_id: destination.id, amount: "4.500,00" } }

      it 'returns http status for success' do
        post :transfer, params: params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'show message for success action' do
        post :transfer, params: params, as: :json

        result = JSON.parse(response.body)

        expect(result).to include('error')
      end
    end
  end

  describe "#GET balance" do
    context 'when account is found' do
      let!(:account) { create :account, user: user, balance: "209,25" }

      it 'gets the balance fot given account' do
        get :balance, params: { account_id: account.id }, as: :json

        result = JSON.parse(response.body)

        expect(result['balance']).to eq("R$209,25")
      end

      it 'render a ok status' do
        get :balance, params: { account_id: account.id }, as: :json

        expect(response).to have_http_status(:ok)
      end
    end


    context 'when account is not found' do
      it 'returns an error message' do
        get :balance, params: { account_id: 11 }, as: :json

        result = JSON.parse(response.body)

        expect(result).to include("error")
      end
    end
  end
end
