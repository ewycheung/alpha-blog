require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password")
    @article = Article.create(title: "Sports Article", description: "Sports Article Description")    
    @articles = Article.all
  end

  test "user sign up" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "eddie", email: "eddie@gmail.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end
end
