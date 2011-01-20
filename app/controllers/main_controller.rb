class MainController < ApplicationController
	before_filter :authenticate

	def index
		@title = 'Pomar!'
		session[:projects] = Project.all

		unless session[:projects].blank? or session[:projects].empty?
			if session[:project].blank? or !session[:projects].include?(session[:project])
				session[:project] = session[:projects][0]
			end
		end

		@projects = session[:projects]
		@project = session[:project]
	end

	def project
		session[:project] = Project.find(params[:id])
		@projects = session[:projects]
		@project = session[:project]

		respond_to do |format|
			format.html { render :action => "index" }
		end
	end
end
