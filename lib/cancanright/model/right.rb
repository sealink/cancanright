module CanCanRight
  module Model
    class Right < ActiveRecord::Base
      has_and_belongs_to_many :roles, :class_name => 'CanCan::Model::Role'

      validates :name, presence: true, uniqueness: true

      scope :ordered, -> { order :name }

      after_save :clear_cache
      after_destroy :clear_cache

      def self.load_file(file_path)
        @rights = YAML::load_file(file_path)['rights']
      end

      def self.rights_from_file
        @rights || fail(StandardError, 'no file loaded')
      end

      def self.rights_by_group
        @rights_by_group = {}
        rights_from_file.each do |group, rights|
          rights.each do |right|
            if right.is_a? Hash
              right.each do |controller, actions|
                actions.each do |action|
                  right_name = [controller, action].compact.join('#')
                  @rights_by_group[right_name] = group
                end
              end
            else
              @rights_by_group[right] = group
            end
          end
        end
        @rights_by_group
      end

      def self.group_for(right)
        rights_by_group[right.name]
      end

      def self.by_groups
        Right.all.group_by(&:group)
      end

      def sensible_name
        name.humanize.titleize.gsub(/#/, ' - ')
      end

      def to_s
        name
      end

      def group
        self.class.group_for(self)
      end
    end
  end
end
