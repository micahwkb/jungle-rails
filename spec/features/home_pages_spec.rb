require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js:true do
  scenario "They see all products" do
    visit root_path
    save_screenshot
  end
end
