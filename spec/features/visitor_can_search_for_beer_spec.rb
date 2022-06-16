require 'rails_helper'

RSpec.feature "VisitorCanSearchForBeers", type: :feature do

  before do
    stub_request(:get, "https://api.punkapi.com/v2/beers").to_return(status: 200, body: file_fixture('index.json').read, headers: {})
  end

  context "Visitor successfully can search for beer" do
    scenario "Visitor can search for punk beer" do
      search_query = "punk"
      stub_request(:get, "https://api.punkapi.com/v2/beers?beer_name=#{search_query}&per_page=80").to_return(status: 200, body: file_fixture('punk_search.json').read, headers: {})

      visit(root_path)
      fill_in("Search for beer name", with: search_query)
      click_on("Search")
      expect(page).to have_content("Sunk Punk")
      expect(page).to have_css(".card", count: 6)
    end

    scenario "Visitor can search for brew and go through paginated results" do
      search_query = "brew"
      stub_request(:get, "https://api.punkapi.com/v2/beers?beer_name=#{search_query}&per_page=80").to_return(status: 200, body: file_fixture("#{search_query}_search.json").read, headers: {})

      visit(root_path)
      fill_in("Search for beer name", with: search_query)
      click_on("Search")
      expect(page).to have_css(".card", count: 10)
      expect(page).to have_content("Barley Wine - Russian Doll")
      click_on("Next")
      expect(page).to have_css(".card", count: 4)
      expect(page).to have_content("Crew Brew")
    end
  end

  context "Visitor can search for beer with no results" do
    scenario "Visitor searches for a beer that does not exist" do
      search_query = "punkpunkpunk"
      stub_request(:get, "https://api.punkapi.com/v2/beers?beer_name=#{search_query}&per_page=80").to_return(status: 200, body: file_fixture("empty.json").read, headers: {})

      visit(root_path)
      fill_in("Search for beer name", with: search_query)
      click_on("Search")
      expect(page).to have_content("No beers found for '#{search_query}'")
      expect(current_path).to eq(root_path)
    end

    scenario "Visitor can search for empty string" do
      search_query = ""
      stub_request(:get, "https://api.punkapi.com/v2/beers?beer_name=#{search_query}&per_page=80").to_return(status: 200, body: file_fixture("empty.json").read, headers: {})

      visit(root_path)
      fill_in("Search for beer name", with: search_query)
      click_on("Search")
      expect(page).to have_content("No beers found for '#{search_query}'")
      expect(current_path).to eq(root_path)
    end

    scenario "Visitor can search for non ASICC character" do
      search_query = "åå"
      stub_request(:get, "https://api.punkapi.com/v2/beers?beer_name=#{search_query}&per_page=80").to_return(status: 200, body: file_fixture("empty.json").read, headers: {})

      visit(root_path)
      fill_in("Search for beer name", with: search_query)
      click_on("Search")
      expect(page).to have_content("No beers found for '#{search_query}'")
      expect(current_path).to eq(root_path)
    end
  end
end
