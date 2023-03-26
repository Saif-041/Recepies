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
            flash[:success] = "recipe created successfully!"
            redirect_to recipe_path(@recipe)
        else
            render 'new', status: 300
        end
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
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
        def recipes_params
            params.require(:recipe).permit(:name, :description)
        end

end