module AccountsHelper
  def expenses_for_current_month_for(transactions)
    data = {}
    Transaction::PURPOSES.each do |purpose|
      expenses = transactions.expenses_for(purpose)
      sum = 0
      expenses.each do |amount|
        sum += amount.to_f
      end
      data[purpose.to_sym] = sum
    end
    data
  end

  def current_balance(account)
    data = {}
    data[:withdraws] = account.transactions.where(transaction_type: 'withdraw').pluck(:amount).sum.to_f
    data[:deposits] = account.transactions.where(transaction_type: 'deposit').pluck(:amount).sum.to_f
    data
  end
end
