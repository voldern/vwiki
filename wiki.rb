# This module holds the default class for creating, editing and viewing a page 
# and some methods for getting wiki pages

module Wiki
	class Page
		attr_accessor :date, :name, :author, :body

		# Initialize a page with name "name" and store it in folder "repo"
		# repo defaults to 'store'
		def initialize(name, repo = 'store')
			@page_name = name 
			@store = GitStore.new(repo)
		end

		# List all the previous commits, the default limit is 10 commits 
		def history(limit = 10)
		end

		# Load a specific revision
		def load(rev)
		end

		# Commit the data
		def save
			# Check if any of the require fields are empty
			[ :date, :name, :author, :body ].each do |name|
				if self.send(name).nil? || self.send(name).empty?
					return false
				end
			end

			@store["pages/#{@page_name}.yml"] = { 'date' => self.date,
				'name' => self.name, 'author' => self.author, 'body' => self.body }
		end

	end

	# List the n latest created pages. The default limit is 5
	def self.last(limit = 5)
	end

	# List n random pages. The default limit is 5
	def self.rand(limit = 5)
	end
end
