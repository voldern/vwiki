require 'rubygems'
require 'ramaze'
require 'grit'
require 'git_store'
require 'rdiscount' # Markdown
require 'wiki'

class MainController < Ramaze::Controller
	def index
		"Hello World"
	end
end

Ramaze.start
