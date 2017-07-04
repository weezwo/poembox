class PoemsController < ApplicationController

  get "/poems" do
      @poem = Poem.find_by_id(rand(1..Poem.all.size)) unless Poem.all.empty?
      erb :"/poems/poems"
  end

  get "/poems/top" do
    @top_poems = Rating.group('poem_id').average(:value).sort.reverse
    erb :"/poems/top"
  end

  get "/poems/new" do
    if signed_in?
      erb :"/poems/new"
    else
      redirect("/poems")
    end
  end

  post "/poems" do
    poem = Poem.create(params)
    poem.user = current_user
    poem.save
    redirect("/poems/#{poem.id}")
  end

  get "/poems/:id" do
    @poem = Poem.find_by_id(params[:id])
    if @poem
      erb :"/poems/show"
    else
      redirect back
    end
  end

  get "/poems/:id/edit" do
    @poem = Poem.find_by_id(params[:id])
    if @poem.user == current_user
      erb :"/poems/edit"
    else
      redirect back
    end
  end

  post "/poems/:id" do
    poem = Poem.find_by_id(params[:id])
    if poem.user == current_user
      poem.update(params)
      poem.save
    end
    redirect "/poems/#{params[:id]}"
  end

  delete "/poems/:id/delete" do
    poem = Poem.find_by_id(params[:id])
    poem.delete
    redirect("/user/#{current_user.username.slug}")
  end
end
