require 'rails_helper'

RSpec.feature "VisitorSeesLandingPage", type: :feature do
  describe "landing page" do
    it "should have a welcome headline" do
      visit root_path
      expect(page).to have_css "h1", text: "Welcome to the Ruby-Monday blog!"
    end
  end
end
