class PoemsController < ApplicationController

  get "/poems" do
    @poem = Poem.find_by_id(rand(Poem.all.size) + 1)
    @author = @poem.user
    erb :"/poems/poems"
  end

  get "/poems/:id" do
    @poem = Poem.find_by_id(params[:id])
    @author = @poem.user
    erb :"/poems/show"
  end
end
