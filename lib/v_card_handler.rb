require 'multiple_vcard'
module VCardHandler

  def self.included(klass)
    klass.extend ClassMethods
    klass.send(:include, InstanceMethods)
  end

  module ClassMethods
  end

  module InstanceMethods
  	def v_card_multiple(contacts)
  		card = Vpim::Vcard::Maker.make2 do |maker|
        contacts.each do |c|
          if contacts.first != c          
          	maker.add_temp_begin
        	end      
        	maker.add_name {|name| name.given = c.name}
        	if c.address?
          	maker.add_addr do |addr|
            	addr.location = 'home'
            	addr.street = c.address
          	end
        	end
        	maker.add_tel(c.phone)
       		maker.add_email(c.email)
        	maker.org = c.organization if c.organization?
        	maker.birthday = c.birthday if c.birthday?
        	if contacts.last != c        
          	maker.add_temp_end
        	end
      	end
     	end
      send_data card.to_s, :filename => "contact.vcf"
  	end

		def v_card_single(contact)
  		card = Vpim::Vcard::Maker.make2 do |maker|
      	maker.add_name {|name| name.given = contact.name}
      	if contact.address?
        	maker.add_addr do |addr|
          	addr.location = 'home'
          	addr.street = contact.address
        	end
      	end
      	maker.add_tel(contact.phone)
     		maker.add_email(contact.email)
      	maker.org = contact.organization if contact.organization?
      	maker.birthday = contact.birthday if contact.birthday?
    	end
      send_data card.to_s, :filename => "contact.vcf"
  	end
  end
end
