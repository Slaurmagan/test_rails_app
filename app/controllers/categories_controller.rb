class CategoriesController < ApplicationController
    before_action :require_admin,only: [:new,:create]
    def index

        @categories = Category.paginate(page:params[:page],per_page:3)
    end

    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles.paginate(page:params[:page],per_page:5)
    end

    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        
        if @category.save
            flash[:success] = "Category was successfully created"
            redirect_to categories_path
        else
            render 'new'

        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end
    def require_admin

        if !logged_in? || (logged_in? && !current_user.admin?)
            flash[:danger] = "Only admins can add category"
            redirect_to categories_path
        end

    end
    
    def require_login
        if !logged_in?
            flash[:danger] = "You must be logged in"
            redirect_to login_path

        end

    end
end