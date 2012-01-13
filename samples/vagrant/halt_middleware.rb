module Vagrant
  module Action
    module VM
      class Halt
        def initialize(app, env)
          @app = app
        end

        def call(env)
          env[:ui].info I18n.t("vagrant.actions.vm.halt.graceful")
          env[:vm].guest.halt
          @app.call(env)
        end
      end
    end
  end
end
