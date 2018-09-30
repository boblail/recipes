require "test_helper"

class RecipeHelperTest < ActionView::TestCase
  include ERB::Util

  context "#format_source" do
    context "when the source is a valid URI, it" do
      should 'create an anchor element' do
        assert_dom_equal %{<a href="http://pinchofyum.com/thai-yellow-curry-with-beef-and-potatoes">pinchofyum.com</a>}, format_source("http://pinchofyum.com/thai-yellow-curry-with-beef-and-potatoes")
      end
    end

    context "when the source is an invalid URI, it" do
      should "return the escaped string" do
        assert_dom_equal %{This is not valid &amp;&amp; http://cool.com}, format_source("This is not valid && http://cool.com")
      end
    end
  end
end
