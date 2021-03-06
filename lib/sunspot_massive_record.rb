require 'active_support'
require 'massive_record'
require 'rails'

require 'sunspot'
require 'sunspot/rails'
require 'sunspot/massive_record'
require 'sunspot/search/hit_result_from_stored'

if ::Rails::VERSION::MAJOR == 3
  require 'sunspot_massive_record/rails/railtie'
else
  raise "Sorry, we only support Rails 3."
end
