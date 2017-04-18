require 'rails_helper'
RSpec.describe Contact, type: :model do
  user = User.first_or_create(email: 'test@yopmail.com', password: '12345678')
  it 'user contact create' do
    contact = user.contacts.new(name: 'Test', email: 'test@gmail.com', phone: '123456789')
    contact.valid?
    if contact.save
    else
      contact.errors
    end
  end

  it 'should require name' do
    contact = user.contacts.new(name: '', email: 'test@gmail.com', phone: '12345678')
    contact.valid?
    contact.errors.should have_key(:name)
  end

  it 'should require email' do
    contact = user.contacts.new(name: 'Test', email: '', phone: '12345678')
    contact.valid?
    contact.errors.should have_key(:email)
  end

  it 'should require phone number' do
    contact = user.contacts.new(name: 'Test', email: 'test@gmail.com', phone: '')
    contact.valid?
    contact.errors.should have_key(:phone)
  end
end
