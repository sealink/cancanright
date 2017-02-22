module CanCanRight
  module ControllerAdditions
    def authorize_action!
      controller = (self.rights_from || params[:controller]).to_s
      action = params[:action].to_s

      return if can?(:access, controller) || can?(:access, controller + '#' + action)

      fail CanCan::AccessDenied, "You are not authorized to access this page."
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include CanCanRight::ControllerAdditions
  end
end
