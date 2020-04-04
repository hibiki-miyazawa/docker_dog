require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        assert_equal full_title, "Community for Dogs"
        assert_equal full_title("Help"), "Help|Community for Dogs"
    end
end