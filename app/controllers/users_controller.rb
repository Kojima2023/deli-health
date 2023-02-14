class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end

    def show_good
        @user = User.find(params[:id])
    end
end
