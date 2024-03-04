class UserAccountsController < ApplicationController
  def index
    @user_accounts = UserAccount.all
    render json: @user_accounts
  end

  def show
    @user_account = UserAccount.find(params[:id])
    render json: @user_account
  end

  def search
    id_number = params[:id_number]
    full_name = params[:full_name]
    role = params[:role]

    @user_accounts = UserAccount.all

    if id_number.present?
      @user_accounts = @user_accounts.where('id_number LIKE ?', "#{UserAccount.sanitize_sql_like(id_number)}%")
    end

    if full_name.present?
      @user_accounts = @user_accounts.where('full_name LIKE ?', "#{UserAccount.sanitize_sql_like(full_name)}%")
    end

    if role.present?
      @user_accounts = @user_accounts.where('role = ?', role)
    end

    render json: @user_accounts
  end

  def create
    @user_account = UserAccount.create(
      id_number: params[:id_number],
      full_name: params[:full_name],
      username: params[:username],
      password: params[:password],
      section: params[:section],
      role: params[:role]
    )
    render json: @user_account
  end

  def update
    @user_account = UserAccount.find(params[:id])
    @user_account.update(
      id_number: params[:id_number],
      full_name: params[:full_name],
      username: params[:username],
      password: params[:password],
      section: params[:section],
      role: params[:role]
    )
    render json: @user_account
  end

  def destroy
    @user_accounts = UserAccount.all
    @user_account = UserAccount.find(params[:id])
    @user_account.destroy
    render json: @user_accounts
  end
end
