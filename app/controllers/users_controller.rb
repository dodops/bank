class UsersController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    @user = Users::CreateService.call(user_params)

    if @user.save
      render json: { api_token: @user.api_token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find params[:id]

    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
