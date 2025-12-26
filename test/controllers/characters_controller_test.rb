require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = User.create!(email: "test@example.com", password: "password")
    genre = Genre.create!(name: "test genre")
    @work = Work.create!(title: "test work", user: user, genre: genre)
    @character = @work.characters.create!(name: "test character")
  end

  test "should get index" do
    get work_characters_url(@work)
    assert_response :success
  end

  test "should get new" do
    get new_work_character_url(@work)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_character_url(@work, @character)
    assert_response :success
  end
end
