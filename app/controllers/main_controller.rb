class MainController < ApplicationController
	before_filter :authenticate

	def index
		@title = 'Pomar!'
		session[:projects] = Project.all
		#@todos = session[:TODOs]
		@todos = Task.TODOs

		unless session[:projects].blank? or session[:projects].empty?
			if session[:project].blank? or !session[:projects].include?(session[:project])
				session[:project] = session[:projects][0]
			end
		end

		#session[:TODOs] = Task.TODOs

		#@projects = session[:projects]
		#@project = session[:project]
		#@todos = session[:TODOs]
	end

	def project
		session[:project] = Project.find(params[:id])
		#@projects = session[:projects]
		#@project = session[:project]
		#session[:TODOs] = Task.TODOs
		#@todos = session[:TODOs]
		@todos = Task.TODOs

		respond_to do |format|
			format.html { render :action => "index" }
		end
	end
end
