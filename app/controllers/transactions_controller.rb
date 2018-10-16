class TransactionsController < ApplicationController
  before_action :set_account, only: [:new, :create]

  def new
    @transaction = @account.transactions.new
  end

  def create
    @transaction = @account.transactions.new(transaction_params)
    if @account.save
      redirect_to @account, notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :purpose)
  end
end
