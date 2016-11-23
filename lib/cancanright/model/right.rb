module CanCanRight
  module Model
    class Right < ActiveRecord::Base
      has_and_belongs_to_many :roles, :class_name => 'CanCan::Model::Role'

      validates :name, presence: true, uniqueness: true

      scope :ordered, -> { order :name }

      def sensible_name
        name.humanize.titleize.gsub(/#/, ' - ')
      end

      def to_s
        name
      end
    end
  end
end
