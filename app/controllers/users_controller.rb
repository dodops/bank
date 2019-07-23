class UsersController < ApplicationController
  def create
    @user = Users::CreateService.call(user_params)

    if @user
      render json: @user.api_token, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
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
