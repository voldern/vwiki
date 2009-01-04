# TODO
# This should be a thor/rake task
# It should check for folder existance and repo existance
puts "Creating store folder"
`mkdir store`
puts "Creating git repository"
`cd store && git init`
