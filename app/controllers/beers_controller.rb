class BeersController < ApplicationController
  include Pagy::Backend

  URI = 'https://api.punkapi.com/v2/beers'

  def index
    response = RestClient.get(URI)
    parsed_response = JSON.parse(response.body).first(6)
    @beers = parsed_response
  end

  def show
    response = RestClient.get(URI+"/#{params[:id]}")
    @beer = JSON.parse(response.body).first
  end

  def search_beer
    @search_beer = params[:query]
    if @search_beer.ascii_only? && !@search_beer.empty?
      response = RestClient.get(URI+"?beer_name=#{@search_beer}&per_page=80") unless
      parsed_response = JSON.parse(response.body)
      @pagy, @search_result = pagy_array(parsed_response, items: 10)
    else
      message = "No beers found for '#{@search_beer}'"
      redirect_to root_path, notice: message
    end
  end
end
