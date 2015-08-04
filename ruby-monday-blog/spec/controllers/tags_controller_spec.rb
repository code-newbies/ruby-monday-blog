require 'rails_helper'

RSpec.feature "Users can create a new tag" do
  scenario "make a new tag" do

    visit new_tag_path

    fill_in "Add Tag", with: "Rails"

    click_button "Create Tag"
    expect(page).to have_content "Rails has been added."
  end
end
