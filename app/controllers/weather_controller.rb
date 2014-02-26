class WeatherController < ApplicationController
	def index
		client = Weatherman::Client.new
		response = client.lookup_by_woeid 1118370

		@city = response.location['city']
		@country = response.location['country']

		condition = response.condition
		@text_condition = condition["text"]
		@temperature = condition["temp"]

		@description_image = response.description_image
		@description_text = response.parsed_description

		astronomy = response.astronomy
		@sunrise = astronomy["sunrise"]
		@sunset = astronomy["sunset"]
	end
end
