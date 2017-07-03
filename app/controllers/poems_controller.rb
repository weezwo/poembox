class PoemsController < ApplicationController

  get "/poems" do
      @poem = Poem.find_by_id(rand(Poem.all.size) + 1) unless Poem.all.empty?
      erb :"/poems/poems"
  end

  get "/poems/top" do
    @top_poems = Rating.group('poem_id').average(:value).sort.reverse
    erb :"/poems/top"
  end

  get "/poems/:id" do
    @poem = Poem.find_by_id(params[:id])
    if @poem
      erb :"/poems/show"
    else
      redirect back
    end
  end
end
