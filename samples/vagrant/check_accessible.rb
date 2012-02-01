module Vagrant::Action::VM
  class CheckAccessible
    def initialize(app, env)
      @app = app
    end

    def call(env)
      if env[:vm].state == :inaccessible
        raise Errors::VMInaccessible
      end

      @app.call(env)
    end
  end
end
