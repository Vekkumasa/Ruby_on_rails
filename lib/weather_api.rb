class WeatherApi
  def self.get_weather_in(city)
    encoded_city = ERB::Util.url_encode(city.downcase)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query=#{encoded_city}"
    response = HTTParty.get url

    return {} if response.include?("success")

    current = response.parsed_response["current"]
    {
      city:,
      temperature: current["temperature"],
      wind_speed: current["wind_speed"],
      wind_direction: current["wind_dir"],
      icons: current["weather_icons"]
    }
  end

  def self.key
    return nil if Rails.env.test?

    raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?

    ENV.fetch('WEATHER_APIKEY')
  end
end
