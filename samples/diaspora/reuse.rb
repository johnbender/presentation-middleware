noob_stack = Builder.new do
  use Actions::User::AcceptInvite
  use Actions::User::Noob
end

veteran_stack = Builder.new do
  use Actions::User::AcceptInvite
  use Actions::User::Veteran
end
