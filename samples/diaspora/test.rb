it "should setup the user" do
  mock.expects(:setup)
  @middleware.call(:user => mock)
end
