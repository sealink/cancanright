require 'active_support/all'
require 'cancan/rule'
require 'cancanright/error'
require 'cancanright/rule'
require 'spec_helper'

describe 'CanCanRight::StandardRule' do
  subject(:rule) { CanCanRight::StandardRule.new(right).call() }

  describe '#call' do
    context 'when a name is specified' do
      let(:right) {
        double(name: 'Do Something', controller: nil, action: nil)
      }

      it 'should return a CanCan::Rule' do
        is_expected.to be_a(CanCan::Rule)
      end

      it 'should convert the name to a parameterized symbol as the action' do
        expect(rule.actions).to eq([:do_something])
      end

      it 'should not have a subject' do
        expect(rule.subjects).to eq([nil])
      end

      it 'should not have any conditions' do
        expect(rule.conditions).to eq({})
      end
    end

    context 'when controller and action are not specified' do
      let(:right) {
        double(name: nil, controller: nil, action: nil)
      }

      it 'should fail with CanCanRight::Error' do
        expect{rule}.to raise_error(CanCanRight::Error, 'must specify a name')
      end
    end
  end
end

describe 'CanCanRight::ControllerRule' do
  subject(:rule) { CanCanRight::ControllerRule.new(right).call() }

  describe '#call' do
    context 'when a controller and action is specified' do
      let(:right) {
        double(name: 'controller#action', controller: 'controller', action: 'action')
      }

      it 'should return a cancan rule' do
        is_expected.to be_a(CanCan::Rule)
      end

      it 'should have :access as the action' do
        expect(rule.actions).to eq([:access])
      end

      it 'it should combine the controller and action into the subject' do
        expect(rule.subjects).to eq(['controller#action'])
      end

      it 'should not have any conditions' do
        expect(rule.conditions).to eq({})
      end
    end

    context 'when only a controller is specified' do
      let(:right) {
        double(name: 'controller#action', controller: 'controller', action: nil)
      }

      it 'should return a cancan rule' do
        is_expected.to be_a(CanCan::Rule)
      end

      it 'should have :access as the action' do
        expect(rule.actions).to eq([:access])
      end

      it 'it should have the controller as the subject' do
        expect(rule.subjects).to eq(['controller'])
      end

      it 'should not have any conditions' do
        expect(rule.conditions).to eq({})
      end
    end

    context 'when controller and action are not specified' do
      let(:right) {
        double(name: 'controller#action', controller: nil, action: nil)
      }

      it 'should fail with CanCanRight::Error' do
        expect{rule}.to raise_error(CanCanRight::Error, 'must specify controller')
      end
    end
  end
end

describe 'CanCanRight::Rule' do
  describe '#self.rule_for' do
    subject(:rule) { CanCanRight::Rule.rule_for(right) }

    context 'when a controller is specified' do
      let(:right) {
        double(name: 'controller#action', controller: 'controller', action: nil)
      }

      it 'should return a cancan rule' do
        is_expected.to be_a(CanCan::Rule)
      end

      it 'should behave like a conroleer rule' do
        expect(rule.actions).to eq([:access])
        expect(rule.subjects).to eq(['controller'])
        expect(rule.conditions).to eq({})
      end
    end

    context 'when a controller is not specified' do
      let(:right) {
        double(name: 'Do Something', controller: nil, action: nil)
      }

      it 'should return a cancan rule' do
        is_expected.to be_a(CanCan::Rule)
      end

      it 'should behave like a standard rule' do
        expect(rule.actions).to eq([:do_something])
        expect(rule.subjects).to eq([nil])
        expect(rule.conditions).to eq({})
      end
    end
  end
end
