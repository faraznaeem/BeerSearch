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

    if @search_beer.ascii_only?
      response = JSON.parse(RestClient.get(URI+"?beer_name=#{@search_beer}&per_page=80").body)
      message = "No beers found for #{@search_beer}"

      if response.empty?
        redirect_to root_path, notice: message
      else
        @pagy, @search_result = pagy_array(response, items: 10)
      end

    else
      redirect_to root_path, notice: message
    end
  end
end
