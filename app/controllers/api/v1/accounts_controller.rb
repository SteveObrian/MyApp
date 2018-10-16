module Api
  module V1
    class AccountsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def new_transaction
        amount            = params[:amount].try(:to_f)
        transaction_type  = params[:transaction_type]
        purpose           = params[:purpose]
        account_id        = params[:account_id]

        errors = Accounts::ValidateNewTransaction.new(
          amount: amount,
          transaction_type: transaction_type,
          account_id: account_id,
          purpose: purpose
        ).execute!

        if errors.any?
          render json: { errors: errors }, status: 402
        else
          account = Accounts::PerformTransaction.new(
            amount: amount,
            transaction_type: transaction_type,
            account_id: account_id,
            purpose: purpose
          ).execute!

          render json: { balance: account.balance }
        end
      end
    end
  end
end
