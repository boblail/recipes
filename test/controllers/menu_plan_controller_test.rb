require 'test_helper'

class MenuPlanControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:test)
  end

  context "when a user submits a valid menu plan, it" do
    should "create a new menu plan" do
      assert_difference('MenuPlan.count') do
        post menu_plans_path, params: { menu_plan: { name: "New Menu Plan" } }, xhr: true
      end
    end

    should "return the new menu plan" do
      post menu_plans_path, params: { menu_plan: { name: "New Menu Plan" } }, xhr: true

      assert_response :success
      assert_equal "application/json", @response.content_type
      assert_equal 'New Menu Plan', JSON.parse(@response.body)["name"]
    end
  end
end
