class WeatherController < ApplicationController
	def index
		client = Weatherman::Client.new
		response = client.lookup_by_woeid 1118370

		@city = response.location['city']
		@country = response.location['country']

		condition = response.condition
		@text_condition = condition["text"]
		@temperature = condition["temp"]

		astronomy = response.astronomy
		@sunrise = astronomy["sunrise"]
		@sunset = astronomy["sunset"]

		wind = response.wind
		@wind_speed = wind["speed"]
	end
end
