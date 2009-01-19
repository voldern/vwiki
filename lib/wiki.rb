# and some methods for getting wiki pages
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'grit'
require 'git_store'
require 'wiki/page'
require 'wiki/stats'

module Wiki
end
