class PoemsController < ApplicationController

  get "/poems" do
    erb :"/poems/poems"
  end
end
