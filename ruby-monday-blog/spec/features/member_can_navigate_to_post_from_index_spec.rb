require 'rails_helper'

RSpec.feature "member can navigate to post from post index", type: :feature do
  let!(:user) { User.create!(email: "luke@skywalker.com", password: "Noooooooo!") }
  let!(:post) { Post.create(title: 'My Post', body: 'My Content', author: user) }

  scenario "user visits post index and clicks on a post headline" do
    # log_in_as user

    # Post#index
    visit posts_path
    expect(page).to have_link 'My Post'
    expect(page).to have_content post.author_full_name
    click_on 'My Post'

    # Post#show
    expect(current_path).to match post_path(post)
    expect(page).to have_content 'My Content'
    expect(page).to have_content post.author_full_name
  end
end
