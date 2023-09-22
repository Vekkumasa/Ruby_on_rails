require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "Ratings are shown in users page" do
    user = User.first
    brewery = FactoryBot.create(:brewery, name: "Koff") 
    beer = FactoryBot.create(:beer, name: "Karhu", brewery: brewery)
    vilma = FactoryBot.create(:user, username: 'Vilma')
    rating = FactoryBot.create(:rating, score: 30, user: vilma, beer: beer)
    rating1 = FactoryBot.create(:rating, score: 20, user: user, beer: beer)

    visit user_path(user.id)

    expect(page).to have_content "Pekka has 1 rating with an average of 20"
    expect(page).not_to have_content "Karhu 30"
  end

  it "Ratings can be deleted" do
    sign_in(username: "Pekka", password: "Foobar1")
    user = User.find_by username: "Pekka"
    brewery = FactoryBot.create(:brewery, name: "Koff") 
    beer = FactoryBot.create(:beer, name: "Karhu", brewery: brewery)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    visit user_path(user.id)

    expect(Rating.count).to eq(2)
    page.all('button')[1].click
    expect(Rating.count).to eq(1)
  end

  it "User page shows favorite style" do
    sign_in(username: "Pekka", password: "Foobar1")
    user = User.find_by username: "Pekka"

    brewery = FactoryBot.create(:brewery, name: "Koff") 
    beer = FactoryBot.create(:beer, name: "Karhu", brewery: brewery)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    visit user_path(user.id)

    expect(page).to have_content "Pekka's favorite style: IPA"
  end

  it "User page shows favorite brewery" do
    sign_in(username: "Pekka", password: "Foobar1")
    user = User.find_by username: "Pekka"

    brewery = FactoryBot.create(:brewery, name: "Koff") 
    beer = FactoryBot.create(:beer, name: "Karhu", brewery: brewery)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    rating = FactoryBot.create(:rating, score: 20, user: user, beer: beer)
    visit user_path(user.id)

    expect(page).to have_content "Pekka's favorite brewery: Koff"
  end
end