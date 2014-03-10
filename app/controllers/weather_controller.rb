class WeatherController < ApplicationController
	def index

		# INSTAGRAM
		# set these to correspond with your desired location
		random = rand(10000)
		lat = "35.6#{random}"
		lng = "139.6#{random}"
		@tokyo_media = Instagram.media_search(lat, lng)


		# WEATHER
		weather_client = Weatherman::Client.new
		response = weather_client.lookup_by_woeid 1118370

		Time.zone = "Tokyo"
		@tokyo_time = Time.zone.now.strftime("%I:%M %p")

		# Convert to 24 hour time for sunrise/sunset icon selection
		tokyo_time_ampm = Time.zone.now.strftime("%p")
		if tokyo_time_ampm == "PM" && @tokyo_time.to_i != 12
			@tokyo_time_24 = @tokyo_time.to_i + 12
		else
			@tokyo_time_24 = @tokyo_time.to_i
		end

		@city = response.location['city']
		@country = response.location['country']

		condition = response.condition
		@text_condition = condition["text"]
		@temperature = condition["temp"]

		astronomy = response.astronomy
		@sunrise = astronomy["sunrise"]
		@sunset = astronomy["sunset"]
		# Check if it's before or after sunset, change icon accordingly
		if @tokyo_time_24 >= @sunrise.to_i && @tokyo_time_24 < (@sunset.to_i+12)
			@astro_icon = "sun-low.svg"
		else
			@astro_icon = "moon.svg"
		end

		wind = response.wind
		@wind_speed = wind["speed"]
	end
end
