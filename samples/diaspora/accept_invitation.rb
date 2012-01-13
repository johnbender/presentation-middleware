module Diaspora
  module Middleware
    module User
      class AcceptInvitation < Base
        def initialize(app)
          @app = app
        end

        def call(env)
          @user = env[:user]
          opts = env[:opts]

          log_hash = {
            :event    => :invitation_accepted,
            :username => opts[:username],
            :uid      => user.id
          }

          if user.invitations_to_me.first && user.invitations_to_me.first.sender
            log_hash[:inviter] = user.invitations_to_me.first.sender.diaspora_handle
          end

          if user.invited?
            user.setup(opts)
            user.invitation_token      = nil
            user.password              = opts[:password]
            user.password_confirmation = opts[:password_confirmation]
            user.save

            return unless user.errors.empty?

            # moved old Invitation#share_with! logic into here,
            # but i don't think we want to destroy the invitation
            # anymore.  we may want to just call user.share_with
            user.invitations_to_me.each do |invitation|
              if !invitation.admin? && invitation.sender.share_with(user.person, invitation.aspect)
                invitation.destroy
              end
            end

            log_hash[:status] = "success"
            Rails.logger.info(log_hash)
            user
          end

          # call the next middleware
          @app.call
        end

        def setup(opts)
          user.username    = opts[:username]
          user.email       = opts[:email]
          user.language    = opts[:language]
          user.language || = I18n.locale.to_s
          user.valid?
          errors = user.errors
          errors.delete :person
          return if errors.size > 0
          user.set_person(Person.new(opts[:person] || {} ))
          user.generate_keys
        end

        def user
          @user
        end
      end
    end
  end
end
