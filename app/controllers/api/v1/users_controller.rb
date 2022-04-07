module Api
	module V1
		class UsersController < ApplicationController
			def init
				if params[:customer_xid].present? && !params[:customer_xid].blank?
					@user = User.where(uuid: params[:customer_xid]).first
					@user = User.new(uuid: params[:customer_xid], token: generate_token) unless @user
					if @user.save
						render json: {
							"data": {
								"token": @user.token
							},
							"status": "success"
						}
					end
				else
					render json: {
						"data": {
							"error": {
							  "customer_xid": [
								"Missing data for required field."
							  ]
							}
						},
						"status": "fail"
					}
				end
			end

			private

			def generate_token
				SecureRandom.hex(20)                
			end
		end
	end
end
