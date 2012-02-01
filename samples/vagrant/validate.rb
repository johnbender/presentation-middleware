module Vagrant::Action::General
  class Validate
    def initialize(app, env)
      @app, @env = app, env
    end

    def call(env)
      if !@env["validate"]
        @env[:vm].config.validate!(@env[:vm].env)
      end

      @app.call(@env)
    end
  end
end
