require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should require email' do
    user = User.create(email: '')
    user.valid?
    user.errors.should have_key(:email)
  end
  it 'should require password' do
    user = User.create(password: '')
    user.valid?
    user.errors.should have_key(:password)
  end
end
