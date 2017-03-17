require_relative 'entry'

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
end
