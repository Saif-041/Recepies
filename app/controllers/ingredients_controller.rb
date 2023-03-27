class IngredientsController < ApplicationController
    before_action :find_ingredient, only: [:edit, :update, :show]
    before_action :require_admin, except: [:index, :show]

    def new 
        @ingredient = Ingredient.new
    end

    def create
        @ingredient = Ingredient.new(ingredient_params)
        if @ingredient.save
            flash[:success] = "ingredient created successfully!"
            redirect_to ingredient_path(@ingredient)
        else
            render 'new', status: 300
        end
    end

    def edit

    end

    def update
        if @ingredient.update(ingredient_params)
            flash[:success] = "ingredient name was updated successfully!"
            redirect_to ingredient_path(@ingredient)
        else
            render 'edit', status: 300
        end
    end

    def show
        @ingredient_recipes =  @ingredient.recipes.paginate(page: params[:page], per_page: 5)
    end

    def index
        @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
    end

    private


        def ingredient_params
            params.require(:ingredient).permit(:name)
        end

        def find_ingredient
            @ingredient = Ingredient.find(params[:id])
        end

        def require_admin
            if !logged_in? || (logged_in? && !current_chef.admin?)
                flash[:danger] = "Only admin users can perform that action."
                redirect_to ingredients_path
            end
        end
end