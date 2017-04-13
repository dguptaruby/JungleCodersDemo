json.extract! contact, :id, :name, :email, :phone, :address, :organization, :birthday, :created_at, :updated_at
json.url contact_url(contact, format: :json)
