class UsersController < ApplicationController

    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            session[:user_id] = user.id
            # byebug
            render json: user, status: 200
        else
            render json: { errors: user.errors.full_messages }, status: 422
        end
    end

    def show
        return render json: { error: "Not authorized" }, status: 401 unless session.include? :user_id
        user = User.find_by(id: session[:user_id])
        render json: user, status: 200
    end


    private
    
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
