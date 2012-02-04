class User < ActiveRecord::Base
  def accept_invitation!(opts = {})
    accept = Middleware::AcceptInvitation.new(lambda {})
    accept.call(opts.merge(:user => self))

    # or

    run(:accept_invitation, opts.merge(:user => self))
  end
end
