class ChartsController < ApplicationController
  def transactions_of_all_time
    render json: Transaction.group(:amount).count
  end

  def transactions_of_this_month
    render json: Transaction.created_between(Date.today.beginning_of_month, Time.now).group(:purpose).count
  end
end
 
