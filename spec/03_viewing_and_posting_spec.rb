require 'spec_helper'

describe ApplicationController do
  describe "Viewing Poems" do
    it "displays random poems at '/poems'" do
      user = User.create(username: "Bill", password: "xyz")
      poem = Poem.create(title: "Cool Poem", content: "A tree. It be.", user_id: 1)
      get '/poems'
      expect(last_response.body).to include(poem.content)
    end

    it "displays individual poems at '/poems/view/:id'" do
      user = User.create(username: "Bill", password: "xyz")
      poem = Poem.create(title: "Cool Poem", content: "A tree. It be.", user_id: 1)
      get '/poems/view/1'
      expect(last_response.body).to include(poem.content)
    end

    xit "displays top ten rated poems at '/poems/top'" do

    end
  end

  describe "Viewing Users" do
    it "displays a user's poems at '/users/view/:slug'" do
      user = User.create(username: "Bill", password: "xyz")
      poem = Poem.create(title: "Cool Poem", content: "A tree. It be.", user_id: 1)
      get '/users/view/bill'
      expect(last_response.body).to include(user.username)
    end
  end

  describe "Posting Poems" do
    it "can post a poem via post '/poems'" do
      user = User.create(:username => "becky567", :password => "kittens")

      visit '/login'

      fill_in(:username, :with => "becky567")
      fill_in(:password, :with => "kittens")
      click_button 'submit'

      visit '/poems/new'
      fill_in(:title, :with => "A Poem")
      fill_in(:content, :with => "poetry!")
      click_button 'submit'

      user = User.find_by(:username => "becky567")
      poem = Poem.find_by(:content => "poetry!")
      expect(poem).to be_instance_of(Poem)
      expect(poem.user_id).to eq(user.id)
      expect(page.status_code).to eq(200)
    end

    xit "validates poems via captcha" do

    end
  end

  describe "Editing Poems" do
    it "allows user to edit their own poem" do
      user = User.create(:username => "becky567", :password => "kittens")
       poem = Poem.create(:title => "Wow", :content => "a poem!", :user_id => 1)
       visit '/login'

       fill_in(:username, :with => "becky567")
       fill_in(:password, :with => "kittens")
       click_button 'submit'
       visit '/poems/1/edit'

       fill_in(:title, :with => "Title")
       fill_in(:content, :with => "This is my poem")

       click_button 'submit'
       expect(Poem.find_by(:content => "This is my poem")).to be_instance_of(Poem)
       expect(Poem.find_by(:content => "a poem!")).to eq(nil)
       expect(page.status_code).to eq(200)
    end

    it "does not allow another user to edit that poem" do
      user = User.create(:username => "becky567", :password => "kittens")
      user2 = User.create(:username => "skittle", :password => "123")
       poem = Poem.create(:title => "Wow", :content => "a poem!", :user_id => 1)
       visit '/login'

       fill_in(:username, :with => "skittle")
       fill_in(:password, :with => "123")
       click_button 'submit'
       visit '/poems/1/edit'
       expect(last_response.location).not_to include("/edit")
    end
  end
end
