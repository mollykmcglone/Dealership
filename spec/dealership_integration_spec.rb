require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view vehicles from index path', {:type => :feature}) do
  it ("allows a user to view a list of vehicles.") do
    visit('/')
    click_link("See Vehicle List")
    expect(page).to have_content("Here are the vehicles on this lot:")
  end
end

describe('create new Vehicle from index path', {:type => :feature}) do
  it ("allows a user to enter a new vehicle's make, model, and year and add the new vehicle to the list of saved vehicles.") do
    visit('/')
    click_link("Add New Vehicle")
    fill_in("make", :with => "Ford")
    fill_in("model", :with => "Focus")
    fill_in("year", :with => "2003")
    fill_in("color", :with => "red")
    fill_in("engine_size", :with => "4L")
    fill_in("number_of_doors", :with => "4")
    click_button("add_vehicle")
    expect(page).to have_content("Success!")
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
