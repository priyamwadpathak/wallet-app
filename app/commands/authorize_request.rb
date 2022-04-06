class AuthorizeRequest
    def initialize(headers = {})
        @headers = headers
    end
  
    def call
        user
    end
  
    private
  
    attr_reader :headers, :errors
  
    def user
      token = http_auth_header
      return if token == 'Invalid token'
      @user ||= User.where(token: http_auth_header).first
    end
  
    def http_auth_header
      if headers['Authorization'].present? && headers['Authorization'].include?('Token')
        return headers['Authorization'].split(' ').last
      else
        return 'Invalid token'
      end
      nil
    end
end
