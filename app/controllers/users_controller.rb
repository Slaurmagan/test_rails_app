class UsersController < ApplicationController
    before_action :set_user,only: [:edit,:update,:show]
    def index
        @users = User.paginate(page: params[:page],per_page: 15)
        if !logged_in?
            flash[:danger] = "You must be logged in"
            redirect_to login_path
        end
    end

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'         
        end
    end
    def edit
        if !logged_in?
            flash[:danger] = "You must be logged in"
            redirect_to login_path 
        elsif logged_in? && current_user != @user
            flash[:danger] = "You didn`t have access to this page"
            redirect_to user_path(current_user)


        end
    end
    def update
        if @user.update(user_params)
            flash[:success] = "Account data was successfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    def show
        @user_articles = @user.articles.paginate(page:params[:page],per_page: 15)
    end
    private
    def user_params
        params.require(:user).permit(:username,:email,:password)
    end
    def set_user
        @user = User.find(params[:id])
    end

end