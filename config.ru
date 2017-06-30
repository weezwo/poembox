require './config/environment'

if ActiveRecord::Migrator.needs_migration?
     raise "Migrations are pending"
end

use Rack::MethodOverride

run ApplicationController
