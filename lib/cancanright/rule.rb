module CanCanRight
  class Rule
    def self.rule_for(right)
      (right.controller.present? ? ControllerRule : StandardRule).new(right).call
    end

    def initialize(right)
      @right = right
    end

    def call
      fail NotImplementedError, 'must be implemented in sub-class'
    end

    private

    def can?
      true
    end

    def action
      :access
    end

    def subject
      [@right.controller, @right.action].compact.join('#')
    end

    def conditions
      nil
    end
  end

  class ControllerRule < Rule
    def initialize(right)
      @right = right
    end

    def call
      if @right.controller.present?
        CanCan::Rule.new(can?, action, subject, conditions, nil)
      else
        fail CanCanRight::Error, 'must specify controller'
      end
    end

    private

    def can?
      true
    end

    def action
      :access
    end

    def subject
      [@right.controller, @right.action].compact.join('#')
    end

    def conditions
      nil
    end
  end

  class StandardRule < Rule
    def initialize(right)
      @right = right
    end

    def call
      CanCan::Rule.new(can?, action, subject, conditions, nil)
    end

    private

    def can?
      true
    end

    def action
      @right.name.parameterize('_').to_sym
    end

    def subject
      nil
    end

    def conditions
      nil
    end
  end
end
