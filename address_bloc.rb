require_relative 'controllers/menu_controller'
# create new menu controller
menu = MenuController.new
# clear cmd line
system "clear"
puts "Welcome to Address Bloc"
# display main_menu
menu.main_menu
