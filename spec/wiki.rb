require 'rubygems'
require 'fileutils'
require 'grit'
require 'git_store'

$:.unshift(File.dirname(__FILE__) + '/../') 
require 'lib/wiki'

module Fixtures
	Data = { :date => '2008-12-10', :name => 'Test', :author => 'voldern',
		:body => 'Lorem ipsum' }

	def self.generate_page(data = nil)
		data = Data if data.nil?

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

		page.save.should == Fixtures::Data
		page.save!.should == Fixtures::Data
	end

	it "should not be able to save with empty date" do
		page = Fixtures::generate_page_without :date

		page.save.should eql(false)
		lambda { page.save! }.should raise_error(ArgumentError, /^date/)
	end

	it "should not be able to save with empty name" do
		page = Fixtures::generate_page_without :name

		page.save.should eql(false)
		lambda { page.save! }.should raise_error(ArgumentError, /^name/)
	end

	it "should not be able to save with empty author" do
		page = Fixtures::generate_page_without :author

		page.save.should eql(false)
		lambda { page.save! }.should raise_error(ArgumentError, /^author/)
	end

	it "should not be able to save with empty body" do
		page = Fixtures::generate_page_without :body

		page.save.should eql(false)
		lambda { page.save! }.should raise_error(ArgumentError, /^body/)
	end

	after(:each) do
		# Clean up
		FileUtils.rm_rf('test_git')
	end
end

describe Wiki, ' load and edit a wiki page' do
	before(:each) do
		# Create the test directory
		Dir.mkdir('test_git')
		`cd test_git && git init`
		page = Fixtures::generate_page
		page.save!
	end

	it "should be possible to load an existing page"
	it "should not be possible to load unexisting page"
	it "should be possible to edit one of the fields and save"
	it "should not be possible to save if we set one of the fields empty"

	after(:each) do
		# Clean up
		FileUtils.rm_rf('test_git')
	end
end
