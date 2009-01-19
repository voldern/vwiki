# This file holds the default class for creating, editing and viewing a page 
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
		# Returns false when it cannot save
		def save
			validate { return false }
			store
		end

		# Raises an exception when it cannot save
		# TODO: Remove the duplication in this and the save function
		def save!
			validate { |name| raise ArgumentError, "#{name} cannot be empty" }
			store
		end

		private

		# Executes block in case of failiure
		def validate
			# Check if any of the require fields are empty
			[ :date, :name, :author, :body ].each do |name|
				name_content = self.send(name)
				if name_content.nil? || name_content.empty?
					yield(name)
				end
			end
		end

		# Stores the page
		def store
			@store["pages/#{@page_name}.yml"] = { 'date' => self.date,
				'name' => self.name, 'author' => self.author, 'body' => self.body }
		end
	end
end
