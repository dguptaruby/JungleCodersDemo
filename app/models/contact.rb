class Contact < ApplicationRecord

belongs_to :user, dependent: :destroy

validates :email, :name, :phone, prescence: true

end
