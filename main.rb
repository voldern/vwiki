require 'rubygems'
require 'ramaze'
require 'rdiscount' # Markdown
require 'lib/wiki'
require 'compass'

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

class CSSController < Ramaze::Controller
	engine :Sass
	trait[:sass_options] = {:load_paths => Compass::Frameworks::ALL.map{|f| f.stylesheets_directory}}

	helper :aspect
	before_all do
		response['Content-Type'] = 'text/css'
		nil
	end

	define_method('main.css') do
	end

	#helper :cache
	#cache 'main.css'
end

Ramaze.start
