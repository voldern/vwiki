class VWiki < Thor
	
	desc 'init', 'Initialize Git "db"'
	method_options :force => :boolean
	def init

		# Check if store exists
		if File.exists? 'store' and !options.force?
			puts "Store already exists. Append --force to force creation"
			return 1
		elsif !File.exists? 'store'
			# If not create folder
			puts "Creating store folder"
			Dir.mkdir('store')
		end

		puts "Creating git repository"
		`cd store && git init`
	end

end
