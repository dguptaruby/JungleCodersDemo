class Contact < ApplicationRecord

	belongs_to :user
	default_scope {where(:archived => false)}
	validates :email, :name, :phone, presence: true

end
