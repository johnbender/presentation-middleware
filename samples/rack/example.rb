module Middleware
  class Example
    def initialize(app)
      @app = app
    end

    def call(env)
      # do something before the next middleware
      # possibly modify the environment

      # run the next middleware in the stack
      @app.call(env)

      # do something after the next middleware
    end
  end
end
