require "rails_helper"

RSpec.feature "on listing page" do 
  scenario "user can see listings" do 
    visit "/listings"
    expect(page).to have_content('Listings')
  end
end