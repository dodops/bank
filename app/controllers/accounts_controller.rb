class AccountsController < ApplicationController
  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def balance
    @account = current_user.accounts.find(params[:account_id])

    render json: { balance: @account.balance.format }, status: :ok
  end

  def transfer
    @source_account = current_user.accounts.find(params[:source_account_id])
    @destination_account = Account.find(params[:destination_account_id])

    transfered = TransferService.call(@source_account, @destination_account, params[:amount])

    if transfered
      render json: { message: "Transferencia realizada com sucesso. Saldo restante: #{@source_account.balance}" }, status: :ok
    else
      render json: { error: 'Conta não possui saldo suficiente.' }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:balance)
  end
end
