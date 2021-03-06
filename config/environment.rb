require 'bundler/setup'
require 'colorize'
require 'io/console'
require 'highline'
require 'tty-spinner'
Bundler.require



ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite'
)

ActiveRecord::Base.logger = nil

# ActiveRecord::Base.logger = nil

require_all 'app/models'

