require 'active_support/all'
require 'cancan/ability'
require 'cancan/controller_additions'
require 'cancan/exceptions'
require 'cancan/rule'
require 'cancanright/ability'
require 'cancanright/controller_additions'
require 'cancanright/error'
require 'cancanright/rule'
require 'spec_helper'

describe 'CanCanRight::ControllerAdditions' do
  subject(:controller) {
    class Ability
      include CanCanRight::Ability

      def initialize(user)

      end
    end

    class Controller
      include CanCan::ControllerAdditions
      include CanCanRight::ControllerAdditions

      def rights_from
        nil
      end

      private

      def params
        { controller: 'controller', action: 'action' }
      end

      def current_user
        nil
      end
    end

    Controller.new
  }

  it 'should respond to authorize_action!' do
    expect(controller.respond_to? :authorize_action!).to be_truthy
  end

  describe 'private #authorize_action!' do
    context 'when the ability has a matching rule' do
      let(:right) {
        double(name: 'controller#action', controller: 'controller', action: 'action')
      }

      before do
        controller.send(:current_ability).send(:add_rule_for, right)
      end

      it 'should grant access to controller#action' do
        expect{controller.send(:authorize_action!)}.to_not(
          raise_error(CanCan::AccessDenied, 'You are not authorized to access this page.'))
      end
    end

    context 'when the ability does not have a matching rule' do
      let(:right) {
        double(name: 'controller#no_action', controller: 'controller', action: 'no_action')
      }

      before do
        controller.send(:current_ability).send(:add_rule_for, right)
      end

      it 'should grant access to controller#action' do
        expect{controller.send(:authorize_action!)}.to(
          raise_error(CanCan::AccessDenied, 'You are not authorized to access this page.'))
      end
    end
  end
end