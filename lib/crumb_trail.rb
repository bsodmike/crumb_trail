require 'crumb_trail/has_crumb_trail'
require 'crumb_trail/log'

module CrumbTrail
end

ActiveSupport.on_load(:active_record) do
  include CrumbTrail::Model
end
