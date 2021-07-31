require 'mysql2'

def get_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => ENV['DB_USERNAME'],
    :password => "",
    :database => ENV['DB_NAME']
  )
  client
end
