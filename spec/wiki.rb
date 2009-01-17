require 'fileutils'
require 'grit'
require 'git_store'

require '../wiki'

module Fixtures
	Data = { 'date' => '2008-12-10', 'name' => 'Test', 'author' => 'voldern',
		'body' => 'Lorem ipsum' }

	def self.generate_page(data)
		page = Wiki::Page.new('test')
		data.each do |name, data|
			eval("page.#{name} = '#{data}'")
		end

		page
	end
end

describe Wiki, ' a new wiki page' do
	before(:each) do
		# Create the test directory
		Dir.mkdir('test_git')
		`cd test_git && git init`
	end

	it "should be possible to save a valid page" do
		page = Fixtures::generate_page(Fixtures::Data)

		page.save.should eql(Fixtures::Data)
	end

	it "should not be able to save with empty date" do
		data = Fixtures::Data
		data.delete('date')
		page = Fixtures::generate_page(data)

		page.save.should eql(false)
	end

	it "should not be able to save with empty name" do
		data = Fixtures::Data
		data.delete('name')
		page = Fixtures::generate_page(data)

		page.save.should eql(false)
	end
	
	it "should not be able to save with empty author" do
		data = Fixtures::Data
		data.delete('author')
		page = Fixtures::generate_page(data)

		page.save.should eql(false)
	end

	it "should not be able to save with empty body" do
		data = Fixtures::Data
		data.delete('body')
		page = Fixtures::generate_page(data)

		page.save.should eql(false)
	end

	after(:each) do
		# Clean up
		FileUtils.rm_rf('test_git')
	end
end
