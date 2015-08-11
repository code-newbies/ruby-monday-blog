require 'rails_helper'

RSpec.feature "member can navigate to post from post index", type: :feature do
  before :each do
    # replace with fixtures
    @post = Post.create(title: 'My Post', body: 'My Content')
  end

  scenario "user visits post index and clicks on a post headline" do
    # log_in_as user
    visit posts_path
    expect(page).to have_css "a", text: 'My Post'
    click_on 'My Post'
    expect(current_url).to match post_url(@post)
    expect(page).to have_content 'My Content'
  end
end
