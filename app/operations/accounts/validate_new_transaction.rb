module Accounts
  class ValidateNewTransaction
    def initialize(amount:, transaction_type:, purpose:, account_id:)
      @amount           = amount
      @transaction_type = transaction_type
      @purpose          = purpose
      @account_id       = account_id
      @account          = Account.where(id: @account_id).first
      @errors           = []
    end

    def execute!
      validate_existence_of_account!
      if @transaction_type == 'withdraw' && @account.present?
        validate_withdrawal!
      end
      @errors
    end

    private

    def validate_existence_of_account!
      @errors << 'Account not found' if @account.blank?
    end

    def validate_withdrawal!
      @errors << 'Not enough funds' if @account.balance - @amount < 0.00
    end
  end
end
