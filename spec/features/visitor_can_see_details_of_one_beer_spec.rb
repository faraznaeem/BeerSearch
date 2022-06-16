require 'rails_helper'

RSpec.feature "VisitorCanSeeDetailsOfOneBeers", type: :feature do
  before do
    body = file_fixture('show.json').read
    request = stub_request(:get, "https://api.punkapi.com/v2/beers/1").to_return(status: 200, body: body, headers: {})
    @parsed_response = JSON.parse(request.response.body).first
  end

  scenario "Visitor can see beer on show page" do
    visit(beer_path(@parsed_response["id"]))
    expect(current_path).to eq(beer_path(@parsed_response["id"]))
    expect(page).to have_content(@parsed_response["name"])
    expect(page).to have_content("#{@parsed_response["abv"]}% alcohol")
    expect(page).to have_content(@parsed_response["description"])

    expect(page).to have_content("#{@parsed_response["name"]} is excellent to pair with the following dishes")
    foods = @parsed_response["food_pairing"]

    foods.each do |food|
      expect(page).to have_content(food)
    end
  end

  scenario "Visitor can navigate to beer from index page" do
    body = file_fixture('index.json').read
    stub_request(:get, "https://api.punkapi.com/v2/beers").to_return(status: 200, body: body, headers: {})
    visit(root_path)
    find_link(@parsed_response["name"]).click
    expect(page).to have_content(@parsed_response["name"])
    expect(page).to have_content("#{@parsed_response["abv"]}% alcohol")
    expect(page).to have_content(@parsed_response["description"])

    expect(page).to have_content("#{@parsed_response["name"]} is excellent to pair with the following dishes")
    foods = @parsed_response["food_pairing"]

    foods.each do |food|
      expect(page).to have_content(food)
    end
  end
end
