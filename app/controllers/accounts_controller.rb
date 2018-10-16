class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def show
    @transactions = @account.transactions.all

    @pieSize = {
      :height => 500,
      :width => 500
    }

    @pieData = [
          {
            value: 300,
            color:"#F7464A",
            highlight: "#FF5A5E",
            label: "Red"
          },
          {
            value: 50,
            color: "#46BFBD",
            highlight: "#5AD3D1",
            label: "Green"
          },
          {
            value: 100,
            color: "#FDB45C",
            highlight: "#FFC870",
            label: "Yellow"
          },
          {
            value: 40,
            color: "#949FB1",
            highlight: "#A8B3C5",
            label: "Grey"
          },
          {
            value: 120,
            color: "#4D5360",
            highlight: "#616774",
            label: "Dark Grey"
          }

        ].to_json
  end

  def new
    @account = current_user.accounts.new
  end

  def edit
  end

  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:account_name)
  end
end
