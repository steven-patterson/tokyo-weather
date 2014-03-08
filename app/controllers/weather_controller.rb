class WeatherController < ApplicationController
	def index
		client = Weatherman::Client.new
		response = client.lookup_by_woeid 1118370

		Time.zone = "Tokyo"
		@tokyo_time = Time.zone.now.strftime("%I:%M %p")
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

		if @tokyo_time_24 >= @sunrise.to_i && @tokyo_time_24 < (@sunset.to_i+12)
			@astro_icon = "sun-lower.svg"
		else
			@astro_icon = "moon.svg"
		end

		wind = response.wind
		@wind_speed = wind["speed"]

	end
end
