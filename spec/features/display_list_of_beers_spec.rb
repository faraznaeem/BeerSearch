require 'rails_helper'

RSpec.feature "DisplayListOfBeers", type: :feature do
  scenario "Visitor can see list of beers on index page" do
    visit root_path
    expect(page).to have_content("Search for Beers")
    expect(page).to have_css(".card", count: 6)
      within(first(".card")) do
        expect(page).to have_content("Buzz")
        expect(page).to have_content("Alcohol content: 4.5%")
        expect(page).to have_content("A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
      end
  end

  scenario "Visitor can see details of a beer on show page" do
    visit root_path
    click_on("Buzz")
    
  end
end
