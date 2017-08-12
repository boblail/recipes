require "test_helper"

class CookbookTest < ActiveSupport::TestCase

  context "Creating a cookbook" do
    should "also create a current menu plan for the cookbook" do
      cookbook = create(:cookbook)
      assert cookbook.current_menu_plan, "Expected the new cookbook to have a current menu plan"
    end
  end

end
