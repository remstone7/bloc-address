require_relative '../models/address_book.rb'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # display menu options to cmd line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a csv"
    puts "5 - Exit"
    puts "6 - View Entry Number n"
    puts "7 - delete everything"
    print "Enter your selection: "
    # retrieve user input w/ gets
    selection = gets.to_i
    # determine user response
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
        # terminate program
        exit(0)
      when 6
        system "clear"
        number_entry
        main_menu
      when 7
        system "clear"
        print "Are you sure you want to delete? "
        deleteYN = gets.chomp
        if deleteYN.upcase == "Y"
            @address_book.nuke
            print "Deleted everything"
            main_menu
        else
          puts "few, you didn't delete it"
          main_menu
        end

      else
        # catch invalid input
        system "clear"
        puts "Sorry, that is not a valid option"
        main_menu
    end
  end


    def number_entry
      print "Which entry number would you like to view? "
      number = gets.chomp.to_i
      if number < 0
        puts "#{number} is not a valid response"
        number_entry
      elsif number < @address_book.entries.count
        puts @address_book.entries[number]
        puts "Hit enter to return"
        gets.chomp
        system "clear"
        main_menu
      else
        puts "#{number} is not a valid response, type Exit to exit or search again "
        exitToMenu = gets.chomp.to_s
        if exitToMenu.upcase == "EXIT"
          main_menu
        end
        number_entry
      end
    end

    def view_all_entries
      # iterate through all entries
      @address_book.entries.each do |entry|
       system "clear"
       puts entry.to_s
     # display a submenu
       entry_submenu(entry)
     end

     system "clear"
     puts "End of entries"
    end

    def create_entry
      system "clear"
      puts "New AddressBloc Entry"
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp
      # create from address book
      @address_book.add_entry(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def delete_entry(entry)
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)

      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp
      # on entry only if valid attribute was read
      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"

      puts "Updated entry:"
      puts entry

    end


    def search_entries
      # get what user wants to search for
      print "Search by name: "
      name = gets.chomp
      # search on address_book return nil or match
      match = address_book.binary_search(name)
      system "clear"
      # if it returns the match
      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end
    end

    def search_submenu(entry)
      puts "\nd - delete this entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

      selection = gets.chomp

      case selection
        when "d"
          system "clear"
          delete_entry(entry)
          main_menu
        when "e"
          edit_entry(entry)
          system "clear"
          main_menu
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is not a valid input"
          puts entry.to_s
          search_submenu(entry)
        end

    end


    def read_csv

      print "Enter CSV file to import: "
      file_name = gets.chomp

      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      begin
        entry_count = address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end

    end


  # submenu
  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
      when "n"
      when "d"
        delete_entry(entry)
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end

end
