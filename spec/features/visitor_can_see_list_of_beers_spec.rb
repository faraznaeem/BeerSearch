require 'rails_helper'

RSpec.feature "VisitorCanSeeListOfBeers", type: :feature do
  scenario "Visitor can see beer on index page" do
    body = file_fixture('index.json').read
    request = stub_request(:get, "https://api.punkapi.com/v2/beers").to_return(status: 200, body: body, headers: {})
    visit root_path
    expect(page).to have_content("Search for Beers")
    expect(page).to have_css(".card", count: 6)
    within(first(".card")) do
      parsed_response = JSON.parse(request.response.body).first
      expect(page).to have_content(parsed_response["name"])
      expect(page).to have_content("Alcohol content: #{parsed_response["abv"]}%")
      expect(page).to have_content(parsed_response["description"])
    end
  end
end