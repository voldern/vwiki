require 'rubygems'
require 'ramaze'
require 'rdiscount' # Markdown
require 'lib/wiki'

class MainController < Ramaze::Controller
	engine :Haml

	def index
		@page = Wiki::Page.new('index')
	end

	def new
		page = Wiki::Page.new('index')
		page.date = Time.now
		page.name = 'Index'
		page.author = 'voldern'
		page.body = 'Velkommen'
		page.save!
	end

	def edit
	end

	def view(page)
	end

end

Ramaze.start
