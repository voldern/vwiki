require 'fileutils'
require 'grit'
require 'git_store'

require '../wiki'

module Fixtures
	Data = { 'date' => '2008-12-10', 'name' => 'Test', 'author' => 'voldern',
		'body' => 'Lorem ipsum' }

	def self.generate_page(data = nil)
		data = Data.clone if data.nil?

		page = Wiki::Page.new('test')
		data.each do |name, data|
			page.method("#{name}=").call(data)
		end

		page
	end

	def self.generate_page_without(name, data = nil)
		data = Data.clone if data.nil?
		data.delete(name.to_s)

		generate_page(data)
	end
end

describe Wiki, ' a new wiki page' do
	before(:each) do
		# Create the test directory
		Dir.mkdir('test_git')
		`cd test_git && git init`
	end

	it "should be possible to save a valid page" do
		page = Fixtures::generate_page

		page.save.should eql(Fixtures::Data)
	end

	it "should not be able to save with empty date" do
		page = Fixtures::generate_page_without :date

		page.save.should eql(false)
	end

	it "should not be able to save with empty name" do
		page = Fixtures::generate_page_without :name

		page.save.should eql(false)
	end

	it "should not be able to save with empty author" do
		page = Fixtures::generate_page_without :author

		page.save.should eql(false)
	end

	it "should not be able to save with empty body" do
		page = Fixtures::generate_page_without :body

		page.save.should eql(false)
	end

	after(:each) do
		# Clean up
		FileUtils.rm_rf('test_git')
	end
end
