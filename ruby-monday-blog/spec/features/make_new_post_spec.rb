require 'rails_helper'

RSpec.feature "Authors can create a new post" do
  let!(:author) { create(:author) }

  scenario "make a new post" do
    login_as(author, scope: :user)
    visit new_post_path

    fill_in "Title", with: "My Title"
    fill_in "Body", with: "My Body"
    fill_in "Tag", with: "my tag"

    click_button "Create Post"

    expect(page).to have_content "Post has been created."
    expect(page).to have_content "My Title"
    expect(page).to have_content "My Body"
    expect(page).to have_content "My Tag"
    expect(page).to have_content Post.last.author_full_name
  end
end
