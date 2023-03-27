class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    end

    def show
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipes_params)
        @recipe.chef = current_chef
        if @recipe.save
            flash[:success] = "recipe created successfully!"
            redirect_to recipe_path(@recipe)
        else
            render 'new', status: 300
        end
    end

    def edit
    end

    def update
        if @recipe.update(recipes_params)
            flash[:success] = "recipe updated successfully!"
            redirect_to recipe_path(@recipe)
        else
            render 'edit', status: 300
        end
    end

    def destroy
        Recipe.find(params[:id]).destroy
        flash[:success] = "recipe deleted successfully!"
        redirect_to recipes_path
    end

    private

        def find_recipe
            @recipe = Recipe.find(params[:id])
        end

        def recipes_params
            params.require(:recipe).permit(:name, :description)
        end

        def require_same_user
            if current_chef != @recipe.chef and !current_chef.admin?
                flash[:danger] = "You can only edit destroy to your own recipes."
                redirect_to recipes_path
            end
        end

end