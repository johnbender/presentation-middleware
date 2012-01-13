class InvitationsController < Devise::InvitationsController
  def update
    # ... redacted ...

    user = User.find_by_invitation_token!(invitation_token)

    user.accept_invitation!(params[:user])
    # Middleware::AcceptInvitation.new.call(:user => user, :opts => params[:user])
    # run(:accept_invitation, :user => user, :opts => params[:user])

    # ... redacted ...
  end
end
