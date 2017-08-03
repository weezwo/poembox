class PoemsController < ApplicationController

  get "/poems" do
    unless Poem.all.empty?
      while @poem.nil?
        @poem = Poem.find_by_id(rand(1..Poem.last.id))
      end
    end
      erb :"/poems/poems"
  end

  get "/poems/top" do
    @top_poems = Rating.group('poem_id').average(:value).sort_by{|arr| arr[1]}.reverse
    erb :"/poems/top"
  end

  get "/poems/new" do
    if signed_in?
      @poem = Poem.new
      erb :"/poems/new"
    else
      redirect("/poems")
    end
  end

  post "/poems" do
    @poem = current_user.poems.build(params[:poem])
    if Captcha.is_valid?(request.ip, params) && @poem.save
      redirect("/poems/#{@poem.id}")
    else
      erb :'/poems/new'
    end
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
    if poem.user == current_user && !params["content"].empty?
      poem.update(params)
      if params[:title].empty?
        poem.title = "Untitled"
      end
      poem.save
    end
    redirect "/poems/#{params[:id]}"
  end

  delete "/poems/:id/delete" do
    poem = Poem.find_by_id(params[:id])
    ratings = Rating.where(poem_id: poem.id)
    poem.delete
    ratings.each {|rating| rating.delete}
    redirect("/users/#{current_user.slug}")
  end
end
