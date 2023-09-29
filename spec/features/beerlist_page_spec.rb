require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end
  
    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    find('#beertable').first('.tablerow')
    expect(page).to have_content "Nikolai"
  end

  it "Default order is by name", :js => true do
    visit beerlist_path
    first = find('#beertable').first('.tablerow')
    
    all_rows = all('#beertable .tablerow')
    last_row = all_rows.last

    expect(first.text).to eq "Fastenbier Rauchbier Schlenkerla"
    expect(last_row.text).to eq "Nikolai Lager Koff"
  end

  it "Sort by style", :js => true do
    visit beerlist_path
    find('#style').click()
    first = find('#beertable').first('.tablerow')
    
    all_rows = all('#beertable .tablerow')
    last_row = all_rows.last

    expect(first.text).to eq "Nikolai Lager Koff"
    expect(last_row.text).to eq "Lechte Weisse Weizen Ayinger"
  end

  it "Sort by breweries", :js => true do
    visit beerlist_path

    find('#brewery').click()
    first = find('#beertable').first('.tablerow')
    
    all_rows = all('#beertable .tablerow')
    last_row = all_rows.last

    expect(first.text).to eq "Lechte Weisse Weizen Ayinger"
    expect(last_row.text).to eq "Fastenbier Rauchbier Schlenkerla"
  end
end