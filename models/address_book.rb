require_relative 'entry'
require "csv"

class AddressBook
   attr_reader :entries

   def initialize
     @entries = []
   end

   def add_entry(name, phone_number, email)
    #  store insertion index
     index = 0
     entries.each do |entry|
      #  compare name with current entry
       if name < entry.name
         break
       end
       index += 1
     end
    #  insert a new entry to entries using the index
     entries.insert(index, Entry.new(name, phone_number, email))
   end

   def import_from_csv(file_name)
    #  read and parse the file
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # #8
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
   end
end
