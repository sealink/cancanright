require 'active_support/all'
require 'cancan/ability'
require 'cancanright/error'
require 'cancanright/rule'
require 'cancanright/ability'
require 'spec_helper'

describe 'CanCanRight::Ability' do
  describe 'private #add_rule_for' do
    subject(:ability) {
      class TestAbility
        include CanCanRight::Ability
      end

      TestAbility.new
    }
    let(:right) {
      double(name: 'Do Something', can: true, action: 'action', subject: 'subject', conditions: {})
    }

    before do
      ability.send(:add_rule_for, right)
    end

    it 'should add a rule to the ability' do
      expect(ability.send(:rules).count).to eq(1)
    end
  end
end
