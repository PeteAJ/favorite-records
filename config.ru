require './app/controllers/application_controller'
require './app/controllers/record_controller'

use Rack::MethodOverride
run ApplicationController
use RecordsController