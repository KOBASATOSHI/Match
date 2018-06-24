class FavoritesController < ApplicationController
    def favoring
        @favorites = current_user.favoring
    end
    
    def favored
        @favorites = current_user.favored_matching
    end
    
    def matched
        @favorites = current_user.matched
    end
    
    def create
        @favorite = current_user.favorites.new(favored_id: params[:favored_id])
        if @favorite.save
            redirect_to user_path(User.find(params[:favored_id]))
        else
            redirect_to user_path(User.find(params[:favored_id]))
        end
    end
    
    def match
        @favorite = Favorite.find(params[:id])
        @favorite.update!(status: 2)
        redirect_to user_path(@favorite.favor)
    end
    
    def not_match
        @favorite = Favorite.find(params[:id])
        @favorite.update!(status: 1)
        redirect_to user_path(@favorite.favor)
    end
end
