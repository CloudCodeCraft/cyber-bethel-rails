module Api
  module V1
    module Users
  class UsersController < ApplicationController
    def create
      user = CreationService.new(**create_params_hash).execute!

      render json: user.attributes.except("password_digest")
    end

    private

    def create_params_hash
      create_params.to_h.symbolize_keys
    end

    def create_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
  end
    end
  end
end
