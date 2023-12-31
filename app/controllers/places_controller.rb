class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherApi.get_weather_in(params[:city])
    session[:city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end

  def show
    id = params[:id]
    @city = session[:city]
    bar_data = Rails.cache.read @city

    bar = bar_data.find { |bar_obj| bar_obj.id == id }

    return unless bar

    @name = bar.name
    @status = bar.status
    @street = bar.street
    @city = bar.city
    @zip = bar.zip
  end
end
