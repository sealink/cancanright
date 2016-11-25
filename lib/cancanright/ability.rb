module CanCanRight
  module Ability
    include CanCan::Ability

    private def add_rule_for(right)
      add_rule(CanCanRight::Rule.rule_for(right))
    end
  end
end
