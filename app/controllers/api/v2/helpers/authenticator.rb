module Api
  module V2
    module Helpers
      module Authenticator

        def authenticate_api_user
          auth_type, auth_key = (request.headers.env.dig('HTTP_AUTHORIZATION') || '').split(' ')
          unless auth_type == 'Basic' && auth_key && base64_encoded?(auth_key)
            render json: {'reason': 'Bad Request', 'details': ''}, status: 400
            return
          end
          user_email, api_access_token = decoded_token(auth_key)
          user = User.find_by(email: user_email)
          if user && ActiveSupport::SecurityUtils.secure_compare(user.api_access_token, api_access_token)
            @current_user = user
          end
          unless @current_user
            render json: {'reason': 'Unauthorized', 'details': ''}, status: 401
          end
        end

        def decoded_token(auth_key)
          Base64.urlsafe_decode64(auth_key).split(':')
        rescue ArgumentError
          render json: {'reason': 'Bad Request', 'details': ''}, status: 400
          return
        end

        def base64_encoded?(string)
          (string =~ /[A-Za-z0-9+\/]+={0,3}/) && (string.length % 4 == 0)
        end
        
        def current_user
          @current_user
        end
      end
    end
  end
end
