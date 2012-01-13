class User < ActiveRecord::Base
  def accept_invitation!(opts = {})
    accept = Middleware::AcceptInvitation.new(lambda {})
    accept.call(opts.merge(:user => user))

    # or

    run(:accept_invitation, opts.merge(:user => user))
  end
end
