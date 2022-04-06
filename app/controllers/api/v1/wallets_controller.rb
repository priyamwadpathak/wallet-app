module Api
    module V1
        class WalletsController < ApplicationController
            def init
                @wallet = wallet
                if @wallet.present?
                    if @wallet.status && params[:is_disabled] == 'true'
                        disable_wallet
                    elsif !@wallet.status
                        @wallet.update(status: Wallet::STATUSES[:enabled], enabled_at: Time.now())
                        render json: {
                            "status": "success",
                            "data": data_hash
                        }
                    else
                        render json: {
                            "status": "fail",
                            "data": {
                                "error": "Already enabled"
                            }
                        }
                    end
                else
                    create_wallet
                end
            end

            def get_wallet
                @wallet = wallet
                if @wallet.present? && @wallet.status
                    render json: {
                        "status": "success",
                        "data": data_hash
                    }
                else
                    render json: {
                        "status": "fail",
                        "data": {
                          "error": "Disabled"
                        }
                    }
                end
            end

            def create_wallet
                @wallet = Wallet.new(user_id: @current_user.id, owned_by: @current_user.uuid, status: Wallet::STATUSES[:enabled], balance: 0, enabled_at: Time.now())
                @wallet.save
                render json: {
                    "status": "success",
                    "data": data_hash
                }
            end

            def disable_wallet
                @wallet.update(status: Wallet::STATUSES[:disabled], disabled_at: Time.now())
                render json: {
                    "status": "success",
                    "data": data_hash
                }
            end

            def data_hash
                {
                    "wallet": {
                      "id": @wallet.id,
                      "owned_by": @wallet.user.uuid,
                      "status": wallet_status,
                      "enabled_at": @wallet.enabled_at,
                      "balance": @wallet.balance
                    }
                }
            end

            def wallet
                @wallet = Wallet.where(owned_by: @current_user.uuid).first
            end

            def wallet_status
                @wallet.status == true ? 'enabled' : 'disabled'
            end

        end
    end
end
