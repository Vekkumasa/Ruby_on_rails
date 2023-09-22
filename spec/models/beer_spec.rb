require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "Valid beer is saved in to db" do
    brewery = Brewery.create name: "Testipanimo", year: 1888
    style = Style.create name: "IPA", description: "Jep jep"
    beer = Beer.create name: "Testikalja", style_id: style.id , brewery_id: brewery.id

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "Invalid beer name is not saved in to db" do
    brewery = Brewery.create name: "Testipanimo", year: 1888
    style = Style.create name: "IPA", description: "Jep jep"
    beer = Beer.create name: "", style_id: style.id, brewery_id: brewery.id

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "Invalid beer style is not saved in to db" do
    brewery = Brewery.create name: "Testipanimo", year: 1888
    style = Style.create name: "IPA", description: "Jep jep"
    beer = Beer.create name: "Testikalja", style_id: style, brewery_id: brewery.id

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end