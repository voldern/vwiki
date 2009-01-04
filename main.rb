require 'rubygems'
require 'ramaze'
require 'grit'
require 'git_store'

class MainController < Ramaze::Controller
	def index
		"Hello World"
	end
end

Ramaze.start
