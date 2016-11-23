module CanCanRight
  module RoleModel
    def self.included(base)
      base.module_eval 'has_and_belongs_to_many :roles, :class_name => "CanCanRight::Model::Role"'
      base.module_eval 'has_many :rights, through: :roles, :class_name => "CanCanRight::Model::Right"'

      Model::Role.module_eval "has_and_belongs_to_many :#{base.table_name}"
    end
  end
end
