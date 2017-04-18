# vpim
module Vpim
	# vcard class
  class Vcard::Maker
    def add_temp_begin
      @card << Vpim::DirectoryInfo::Field.create('BEGIN', 'VCARD')
    end

    def add_temp_end
      @card << Vpim::DirectoryInfo::Field.create('END', 'VCARD')
    end
  end
end
