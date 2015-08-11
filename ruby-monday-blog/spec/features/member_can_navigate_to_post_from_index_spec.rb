require 'rails_helper'

RSpec.feature "member can navigate to post from post index", type: :feature do
  let!(:post) { Post.create(title: 'My Post', body: 'My Content') }

  scenario "user visits post index and clicks on a post headline" do
    # log_in_as user
    visit posts_path
    expect(page).to have_link 'My Post'
    click_on 'My Post'
    expect(current_path).to match post_path(post)
    expect(page).to have_content 'My Content'
  end
end
