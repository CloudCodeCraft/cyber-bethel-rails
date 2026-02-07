
module Api
  module V1
    module Users
      class SessionsController < ApplicationController
      end
    def create
      params_hash = create_params_hash.merge(
        {
          user_agent: request.user_agent
        }
      )
      render json: SessionCreationService.new(**params_hash).execute!
    end

    def validate_token
    end

    def refresh_token
    end

    private

    def create_params_hash
      create_params.to_h.symbolize_keys
    end

    def create_params
      params.require(:user).permit(:username, :password)
    end
    end
  end
end
