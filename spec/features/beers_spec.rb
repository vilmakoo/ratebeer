require 'rails_helper'

describe "Beer" do
  it "can be added when given a valid name" do
    visit beers_path
    click_link('New Beer')
    fill_in('Name', with:'olut')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "cannot be added if given name is not valid" do
    visit beers_path
    click_link('New Beer')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
  end
end