class Book < ActiveRecord::Base
  attr_accessible :title
  has_crumb_trail
end
