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
      end

    end

    # The following instance methods are wrapped within a module so we can
    # include them only in AR models that declare `has_crumb_trail`. The
    # InstanceMethods module inside ActiveSupport::Concern is no longer
    # included automatically.
    module InstanceMethods
      def icanhazcheeseburger?
        "om nom nom!"
      end
    end

  end
end
