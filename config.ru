require './config/environment'

if ActiveRecord::Migrator.needs_migration?
     raise "Migrations are pending"
end

use Rack::MethodOverride

use PoemsController
use UsersController
use RatingsController
run ApplicationController
