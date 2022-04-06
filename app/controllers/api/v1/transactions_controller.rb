module Api
    module V1
        class TransactionsController < ApplicationController
            def deposit
                validate_request
                @wallet = wallet
                if wallet.present? && wallet.status
                    @transaction = Transaction.new(transaction_type: "deposit", wallet_id: @wallet.id, by_user: @current_user.uuid, transaction_at: Time.now(), amount: params[:amount], reference_id: params[:reference_id])
                    if @transaction.update(status: "success")
                        @wallet.update(balance: @wallet.balance + @transaction.amount)
                        render json: response_hash
                    end
                else
                    render json: disabled_wallet_response
                end
            end

            def withdrawals
                validate_request
                @wallet = wallet
                if wallet.present? && wallet.status
                    if @wallet.balance < params[:amount].to_i
                        render json: {
                            "status": "fail",
                            "data": {
                                "error": "Insufficient balance."
                            }
                        }
                    else
                        @transaction = Transaction.new(transaction_type: "withdrawal", wallet_id: @wallet.id, by_user: @current_user.uuid, transaction_at: Time.now(), amount: params[:amount], reference_id: params[:reference_id])
                        if @transaction.update(status: "success")
                            @wallet.update(balance: @wallet.balance - @transaction.amount)
                            render json: response_hash
                        end
                    end
                else
                    render json: disabled_wallet_response
                end
            end

            private

            def response_hash
                {
                    "status": "success",
                    "data": {
                      @transaction.transaction_type => {
                        "id": @transaction.id,
                        txn_by_key => @transaction.by_user,
                        "status": @transaction.status,
                        txn_at_key => @transaction.transaction_at,
                        "amount": @transaction.amount,
                        "reference_id": @transaction.reference_id
                      }
                    }
                }
            end

            def txn_by_key
                @transaction.transaction_type == "deposit" ? "deposited_by" : "withdrawn_by"
            end

            def txn_at_key
                @transaction.transaction_type == "deposit" ? "deposited_at" : "withdrawn_at"
            end

            def validate_request
                unless params[:amount].present? && params[:reference_id].present?
                    render json: {
                        "status": "fail",
                        "data": {
                            "error": 'Please pass valid amount and reference id.'
                        }
                    }
                end
            end

            def disabled_wallet_response
                {
                    "status": "fail",
                    "data": {
                        "error": "Disabled."
                    }
                }
            end

            def wallet
                @current_user.wallet
            end
        end
    end
end
