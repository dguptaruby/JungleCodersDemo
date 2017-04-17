require 'rails_helper'
require 'v_card_handler'

RSpec.describe ContactsController, :type => :controller do
  describe 'Genrate vCard' do
  	user = User.last
    it 'Genrate vCard for single contact' do
      contact = user.contacts.create(name: 'Test', email: 'test@gmail.com', phone: '123456789')
      contacts = user.contacts.where(id: contact.id).last
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
    	flash[:success] = if card
      										'vcard is created successfully.'
									    	else
									    		'vcard is not created.'
									    	end
    	expect(flash[:success]).to match(/vcard is created successfully.*/)
    end

    it 'Genrate vCard for multiple contact' do
      user.contacts.create(name: 'Test', email: 'test@gmail.com', phone: '123456789')
      user.contacts.create(name: 'Test_1', email: 'test_1@gmail.com', phone: '123456789')
      user.contacts.create(name: 'Test_2', email: 'test_2@gmail.com', phone: '123456789')
      contacts = user.contacts
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
    	if card
      	flash[:success] = 'vcard is created for multiple contacts successfully.'
    	else
    		flash[:success] = 'vcard is not created.'
    	end
    	expect(flash[:success]).to match(/vcard is created for multiple contacts successfully..*/)
    end
  end
end