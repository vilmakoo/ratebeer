require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are all shown at the page" do
    places = [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new(name:"toinen pub", id: 2) ]
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        places
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "toinen pub"
  end

  it "if no places are returned by the API, the page shows an error message" do
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end