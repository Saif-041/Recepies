class RecipesController < ApplicationController

    def index
        @recipes = Recipe.all
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipes_params)
        @recipe.chef = Chef.first
        if @recipe.save
            flash[:success] = "recipe created successfully"
            redirect_to recipe_path(@recipe)
        else
            render 'new', status: 300
        end
    end

    private
        def recipes_params
            params.require(:recipe).permit(:name, :description)
        end

end