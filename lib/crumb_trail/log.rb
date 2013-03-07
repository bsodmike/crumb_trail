class Log < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  validates_presence_of :event
  attr_accessible :item_type, :item_id, :event, :object, :object_changes
  serialize :object

  # Returns what changed in this version of the item.  Cf. `ActiveModel::Dirty#changes`.
  serialize :object_changes
end
