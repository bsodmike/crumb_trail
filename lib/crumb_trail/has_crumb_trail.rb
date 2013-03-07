module CrumbTrail
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def has_crumb_trail
        send(:include, InstanceMethods)

        class_attribute :log_association_name
        self.log_association_name = :logs

        has_many self.log_association_name,
          :as => :item,
          :dependent => :destroy

        after_create :record_create
        before_update :record_update
        after_destroy :record_destroy
      end

    end

    # The following instance methods are wrapped within a module so we can
    # include them only in AR models that declare `has_crumb_trail`. The
    # InstanceMethods module inside ActiveSupport::Concern is no longer
    # included automatically.
    module InstanceMethods
      private
      def record_create
        log_changes(:event => 'create')
      end

      def record_update
        log_changes(:event => 'update')
      end

      def record_destroy
        Log.create!(:item_id => self.id,
          :item_type => self.class.base_class.name,
          :event => 'destroy',
          :object => to_hash(self),
          :object_changes => self.changed_attributes
        )
      end

      def log_changes(data)
        self.logs.create!(:event => data[:event],
          :object => to_hash(self),
          :object_changes => self.changed_attributes
        )
      end

      def to_hash(item)
        JSON.parse item.to_json
      end
    end

  end
end
