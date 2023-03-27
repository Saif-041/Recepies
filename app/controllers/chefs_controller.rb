class ChefsController < ApplicationController
    before_action :find_chef, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @chefs = Chef.paginate(page: params[:page], per_page: 4)
    end

    def new
        @chef = Chef.new
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            session[:chef_id] = @chef.id
            flash[:success] = "Welcome #{@chef.chefname} to my-recipes App!"
            redirect_to chef_path(@chef)
        else
            render 'new', status: 300
        end
    end

    def show
        @chef_recipes =  @chef.recipes.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def update
        if @chef.update(chef_params)
            flash[:success] = "Your profile updated successfully."
            redirect_to @chef
        else
            render 'edit', status: 300
        end
    end

    def destroy
        @chef.destroy
        flash[:danger] = "Chef and all associate recipes deleted successfully."
        redirect_to chefs_path
    end

    private

        def find_chef
            @chef = Chef.find(params[:id])
        end

        def chef_params
            params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
        end

        def require_same_user
            if current_chef != @chef
                flash[:danger] = "You can only edit or delete your own account."
                redirect_to chefs_path
            end
        end

end