require 'rails_helper'
include Helpers

describe "Beers page" do
  describe "Creating new beer" do
    before :each do
      FactoryBot.create :user
      FactoryBot.create(:brewery, name: "Brewery", year: 1888)
      FactoryBot.create(:style)
      sign_in(username: "Pekka", password: "Foobar1")
      visit new_beer_path
    end

    it "Beer is added into db with valid values" do 
      fill_in('beer_name', with: 'Beer')
      select('IPA', from: 'beer_style_id')
      select("Brewery", from: 'beer_brewery_id')
         
      expect{
        click_button('Create beer')
      }.to change{Beer.count}.by(1)
    end

    it "Beer is NOT added into db with valid values" do
      fill_in('beer_name', with: '')
      select('IPA', from: 'beer_style_id')
      select("Brewery", from: 'beer_brewery_id')
      click_button('Create beer')

    #  save_and_open_page
      expect(page).to have_content "Name can't be blank"
      expect(Beer.count).to eq(0)
    end
  end
end