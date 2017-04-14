
Rails version 5.0

===Installation

- Install ruby-2.3.1 and run rvm use 2.3.1
- Install {Bundler}[http://bundler.io/] if you haven't already
- Database
  - Ensure there is a postgres user in your pg database, or edit the database.yml configuration accordingly
- +$ bundle install+
- +$  rake db:create && rake db:migrate 
- +$ rails s

====

====Added Functionality
- Create,Edit and delete contacts
- Save single and multiple contacts as pdf
- Search a contact among a list
- Download single or multiple contacts as vcard
- Friendly URLs
- I18n setup

