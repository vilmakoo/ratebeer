
require 'rails_helper'

describe "Ratings page" do
  it "lists existing ratings and their total number" do
    FactoryGirl.create :rating3

    visit ratings_path

    expect(page).to have_content "Number of ratings: 1"
    expect(page).to have_content 15
  end
end