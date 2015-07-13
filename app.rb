require "active_support"
require "active_support/core_ext/object/blank"
require "sinatra"
require "sinatra/reloader"
require "sinatra/json"
require "pry"

# -------------------------------------------------------------------------------------------------------------------
# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/assignment.rb"
require_relative "models/collaborator.rb"
require_relative "models/resource.rb"


# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/api_controller.rb"

