module TransactionsHelper
  def translate_transaction_types
    Transaction::TRANSACTION_TYPES.map do |type|
      [t("transaction.transaction_types.#{type}"), type]
    end
  end

  def translate_purposes
    Transaction::PURPOSES.map do |purpose|
      [t("transaction.purposes.#{purpose}"), purpose]
    end
  end
end
