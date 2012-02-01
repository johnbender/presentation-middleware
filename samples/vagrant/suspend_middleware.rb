module Vagrant::Action::VM
  class Suspend
    def initialize(app, env)
      @app = app
    end

    def call(env)
      if env[:vm].state == :running
        env[:vm].driver.suspend
      end

      @app.call(env)
    end
  end
end
