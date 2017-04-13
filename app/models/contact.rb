class Contact < ApplicationRecord

belongs_to :user

validates :email, :name, :phone, presence: true

end
