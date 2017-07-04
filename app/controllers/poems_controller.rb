require 'net/http'
require 'json'
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
    res = Net::HTTP.post_form(
    URI.parse('http://www.google.com/recaptcha/api/verify'),
    {
      'privatekey' => '6Ldt5icUAAAAADMgPkDRpb5S3sZWvDoSH0Va7Dax',
      'remoteip'   => request.ip,
      'challenge'  => params[:recaptcha_challenge_field],
      'response'   => params[:recaptcha_response_field]
    }
    )

    success, error_key = res.body.lines.map(&:chomp)

    if success
      if !params["content"].empty?
        poem = Poem.create(title: params["title"], content: params["content"])
        poem.user = current_user
        if params[:title].empty?
          poem.title = "Untitled"
        end
        poem.save
        redirect("/poems/#{poem.id}")
      else
        redirect back
      end
    else
      redirect back
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
    poem.delete
    redirect("/users/#{current_user.slug}")
  end
end
