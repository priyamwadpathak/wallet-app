class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate_request
    attr_reader :current_user
    
    private

    def authenticate_request
        auth_request = AuthorizeRequest.new(request.headers)
        @current_user = auth_request.call
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end
