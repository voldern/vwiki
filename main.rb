require 'rubygems'
require 'ramaze'
require 'rdiscount' # Markdown
require 'lib/wiki'

class MainController < Ramaze::Controller
	def index
		"Hello World!"
	end
end

Ramaze.start
