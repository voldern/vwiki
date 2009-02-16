# This file is part of VWiki.
# Copyright (C) 2009 Espen Volden

# VWiki is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# VWiki is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with VWiki.  If not, see <http://www.gnu.org/licenses/>.

require 'rubygems'
require 'ramaze'
require 'rdiscount' # Markdown
require 'lib/wiki'
require 'compass'

class MainController < Ramaze::Controller
  engine :Haml
  layout :layout

  def index
    redirect Rs(:show, 'Index')
  end

  def new(name = nil)
    if request.post?
      @page = Wiki::Page.new(request[:name], :name => request[:name],
                             :date => Time.now,
                             :author => request[:author],
                             :body => request[:body])
      if @page.save!
        redirect Rs(:show, @page.name)
      else
        @error = "Could not save page!"
      end
    else
      @name = (name.nil? ? '' : name)
    end
  end

  def edit(page)
    @page = Wiki::Page.new(page)
    redirect Rs(:new, page) unless @page.loaded?

    if request.post?
      @page.author = request[:author]
      @page.body = request[:body]
      @page.date = Time.now
      @page.save!

      redirect Rs(:show, @page.name)
    end
  end

  def show(page)
    @page = Wiki::Page.new(page)
    redirect Rs(:new, page) unless @page.loaded?
  end

end

class StatsController < Ramaze::Controller
  engine :Haml
  layout :layout
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
