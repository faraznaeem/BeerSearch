class BeersController < ApplicationController
  include Pagy::Backend

  def index
    response = JSON.parse(RestClient.get('https://api.punkapi.com/v2/beers?per_page=80').body).first(6)
    @beers = response
    # @random_beer = RestClient.get('https://api.punkapi.com/v2/beers/random')
  end

  def show
    response = RestClient.get("https://api.punkapi.com/v2/beers/#{params[:id]}")
    @beer = JSON.parse(response.body).first
  end

  def search_beer
    @search_beer = params[:query]
    response = JSON.parse(RestClient.get("https://api.punkapi.com/v2/beers?beer_name=#{@search_beer}&per_page=80"))
    # binding.pry
    # @search_result = response
    @pagy, @search_result = pagy_array(response, items: 10)

    # Todo: Refactor this to use a loop to get all the pages
    # __________________________________
    # @search_beer_array = []
    # if response.count < 80
    # elsif response.count == 80
    #   page = JSON.parse(RestClient.get("https://api.punkapi.com/v2/beers?beer_name=#{search_beer}&page=#{2}&per_page=80"))
    #   @search_beer_array << response
    #   @search_beer_array << page
    # else
    #   return @search_result = "No results found"
    # end
    # __________________________________

  end
end
