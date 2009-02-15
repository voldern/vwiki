# This file holds the default class for creating, editing and viewing a page
module Wiki
  class Page
    attr_accessor :date, :name, :author, :body

    # Initialize a page with name "name" and store it in folder "repo"
    # repo defaults to 'store'
    def initialize(name, args = {})
      # Loop over the args and set the attributes if they exist
      if not args.nil? and not args.empty?
        repo = (args[:repo].nil? ? 'store' : args[:repo])
        args.each do |key,val|
          self.send("#{key}=", val) if respond_to? "#{key}="
        end
      else
        repo = 'store'
      end

      @page_name = name
      @store = GitStore.new(repo)

      # Check if this page exists. If it does load the data from it
      # into the object
      @loaded = false
      page = @store["pages/#{@page_name}.yml"]
      load_data unless page.nil?
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

    def loaded?
      @loaded
    end

    private

    # Executes block in case of failiure
    def validate
      # Check if any of the require fields are empty
      [ :date, :name, :author, :body ].each do |name|
        name_content = self.send(name)
        if name_content.nil?
          yield(name)
        end
      end
    end

    # Stores the page
    # Return a hash with the page content if save succeded.
    # If not it will return false
    def store(msg = nil)
      author = self.author # No need to call self.author twice

      @store["pages/#{@page_name}.yml"] = { :date => self.date, :name => self.name,
        :author => author, :body => self.body }

      # Commit the changes
      msg = "Updated by #{author}" if msg.nil?
      sha1 = @store.commit(msg)

      if sha1.nil?
        false
      else
        @store["pages/#{@page_name}.yml"]
      end
    end

    # Load data into object
    def load_data
      puts "Loading data"
      page = @store["pages/#{@page_name}.yml"]
      [ :date, :name, :author, :body ].each do |name|
        self.send("#{name}=", page[name])
      end
      @loaded = true
    end

  end
end
