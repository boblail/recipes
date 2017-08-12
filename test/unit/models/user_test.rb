require "test_helper"

class UserTest < ActiveSupport::TestCase

  context "Creating a user" do
    should "also create a cookbook for the user" do
      user = create(:user)
      assert user.cookbook, "Expected the new user to have a cookbook"
    end
  end

end
