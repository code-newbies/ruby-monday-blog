require 'rails_helper'

RSpec.feature "Users can create a new post" do
  scenario "make a new post" do
    visit new_post_path

    fill_in "Title", with: "My Title"
    fill_in "Body", with: "My Body"
    fill_in "Tag", with: "Ruby"

    click_button "Create Post"
    expect(page).to have_content "Post has been created."
    expect(page).to have_content "My Title"

  end
end
