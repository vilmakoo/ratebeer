require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "can be added when given a valid name" do
    visit new_beer_path
    fill_in('Name', with:'olut')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "cannot be added if given name is not valid" do
    visit new_beer_path
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
  end
end