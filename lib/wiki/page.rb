# This file holds the default class for creating, editing and viewing a page 
module Wiki
	class Page
		attr_accessor :date, :name, :author, :body

		# Initialize a page with name "name" and store it in folder "repo"
		# repo defaults to 'store'
		def initialize(name, repo = 'store')
			@page_name = name 
			@store = GitStore.new(repo)
			
			# Check if this page exists. If it does load the data from it into the object
			page = @store["pages/#{@page_name}.yml"]
			load_data if not page.nil? and not page.empty?
		end

		# List all the previous commits, the default limit is 10 commits 
		def history(limit = 10)
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
		# Return a hash with the page content if save succeded.
		# If not it will return false
		def store(msg = nil)
			page = @store["pages/#{@page_name}.yml"] 
			page = { :date => self.date,
				:name => self.name, :author => self.author, :body => self.body }

			msg = "Updated by #{self.author}" if msg.nil?
			sha1 = @store.commit(msg)

			if sha1.nil? or sha1.empty?
				false
			else
				page
			end
		end

		# Load data into object
		def load_data
			puts "Loading data"
			page = @store["pages/#{@page_name}.yml"]
			[ :date, :name, :author, :body ].each do |name|
				self.send("#{name}=", page[name.to_s])
			end
		end

	end
end
