class MainController < ApplicationController
	before_filter :authenticate

	def index
		@title = 'Pomar!'
	end
end
