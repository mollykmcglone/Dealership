require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view list of dealerships from index path', {:type => :feature}) do
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

describe('view details about a specific dealership from dealership list path', {:type => :feature}) do
  it ("allows a user to click on the name of a dealership and view a list of all the cars available at that dealership.") do
    visit('/')
    click_link("add_new")
    fill_in("dealership_name", :with => "Val's Vehicles")
    click_button("add_dealership")
    expect(page).to have_content("Val's Vehicles")
    click_link("Val's Vehicles")
    expect(page).to have_content("Here are all the cars at this dealership:")
  end
end

describe('create new Dealership from dealership list path', {:type => :feature}) do
  it ("allows a user to enter a new dealership's name and add the new dealership to the list of saved dealerships.") do
    visit('/')
    click_link("See Dealership List")
    click_link("add_new")
    fill_in("dealership_name", :with => "Kathy's Kars")
    click_button("add_dealership")
    expect(page).to have_content("Kathy's Kars")
  end
end

describe("add car to a dealership's list of cars from dealership page", {:type => :feature}) do
  it ("allows a user to enter a new car's make, model, and other attributes and add that car to the list of vehicles available at a particular dealership.") do
    visit('/')
    click_link("add_new")
    fill_in("dealership_name", :with => "Victor's Vans")
    click_button("add_dealership")
    expect(page).to have_content("Victor's Vans")
    click_link("Victor's Vans")
    expect(page).to have_content("Here are all the cars at this dealership:")
    click_link("Add a new vehicle")
    expect(page).to have_content("Add a vehicle")
    fill_in("make", :with => "Mazda")
    fill_in("model", :with => "Mazda5")
    fill_in("year", :with => "2014")
    fill_in("color", :with => "navy")
    fill_in("engine_size", :with => "4L")
    fill_in("number_of_doors", :with => "4")
    click_button("add_vehicle")
    expect(page).to have_content("Success!")
  end
end

describe('go home from dealership page', {:type => :feature}) do
  it ("allows a user to return to the main index page from any particular dealership's page") do
    visit('/')
    click_link("add_new")
    fill_in("dealership_name", :with => "Austin's Autos")
    click_button("add_dealership")
    expect(page).to have_content("Austin's Autos")
    click_link("Austin's Autos")
    expect(page).to have_content("Here are all the cars at this dealership:")
    click_link("Return to Main Page")
    expect(page).to have_content("Welcome to Dealership Central")
  end
end
