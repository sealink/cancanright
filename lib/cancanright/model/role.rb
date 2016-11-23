module CanCanRight
  module Model
    class Role < ActiveRecord::Base
      has_and_belongs_to_many :rights, :class_name => 'CanCanRight::Model::Right'

      validates :title, presence: true, uniqueness: true

      def to_s
        self.title.try(:titleize)
      end
      alias_method :name, :to_s
    end
  end
end
