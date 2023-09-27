require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return({
        city: "kumpula",
        temperature: 21,
        wind_speed: 2.5,
        wind_direction: "SE",
        icons: ["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"]
    })

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Dirlandaa", id: 2 ) ]
    )

    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return({
      city: "kumpula",
      temperature: 21,
      wind_speed: 2.5,
      wind_direction: "SE",
      icons: ["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"]
  })

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Dirlandaa"
  end

  it "None is returned by the API" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return({})

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end