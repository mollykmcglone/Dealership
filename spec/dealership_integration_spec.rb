require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view dealerships from index path', {:type => :feature}) do
  it ("allows a user to view a list of dealerships.") do
    visit('/')
    click_link("See Dealership List")
    expect(page).to have_content("Here are all the Dealerships in our area:")
  end
end

describe('create new Dealership from index path', {:type => :feature}) do
  it ("allows a user to enter a new dealership's name and add the new dealership to the list of saved dealerships.") do
    visit('/')
    click_link("add_new")
    fill_in("dealership_name", :with => "Molly's Motors")
    click_button("add_dealership")
    expect(page).to have_content("Molly's Motors")
  end
end

describe('view vehicles from success.erb path', {:type => :feature}) do
  it ("allows a user to add a new vehicle to the list and then view the full list of vehicles") do
    visit('/')
    click_link("Add New Vehicle")
    fill_in("make", :with => "Honda")
    fill_in("model", :with => "Civic")
    fill_in("year", :with => "2000")
    click_button("add_vehicle")
    expect(page).to have_content("Success!")
    click_link("See Vehicle List")
    expect(page).to have_content("Civic")
  end
end

describe('create new vehicle from vehicles.erb path', {:type => :feature}) do
  it ("allows a user to view the list of vehicles and then click on one vehicle and view its details") do
    visit('/')
    click_link("Add New Vehicle")
    fill_in("make", :with => "Mazda")
    fill_in("model", :with => "Mazda5")
    fill_in("year", :with => "2014")
    click_button("add_vehicle")
    expect(page).to have_content("Success!")
    click_link("See Vehicle List")
    expect(page).to have_content("Mazda5")
    click_link("Mazda5")
    expect(page).to have_content("2014")
  end
end
