require 'active_replica'

begin
  require 'rails/railtie'

  module ActiveReplica
    class Railtie < Rails::Railtie # :nodoc:
      initializer 'active_replica.initialize' do
        ActiveSupport.on_load(:active_record) do
          default_handler = ActiveRecord::Base.default_connection_handler
          active_handler = ActiveReplica::ConnectionHandler.new(default_handler)
          ActiveRecord::Base.default_connection_handler = active_handler
        end
      end
    end
  end
rescue LoadError
  warn "can't load railtie"
end
