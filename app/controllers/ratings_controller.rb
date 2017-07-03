class RatingsController < ApplicationController
  post '/ratings/:poem_id' do
    if signed_in?
      rating = Rating.find_or_create_by(user_id: current_user.id, poem_id: params[:poem_id])
      case params[:rating]
      when "up"
        rating.value = 1
        rating.save
      when "down"
        rating.value = -1
        rating.save
      end
    end
    redirect back
  end
end
