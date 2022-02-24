require 'rails_helper'

RSpec.describe Link, type: :model do
  it "is valid it has a url and a slug field" do
    link = Link.new(url: "https://www.westsideplugs.com/welcome-to-an-original-container",
    slug: "Shorty")
    expect(link.valid?).to be true
  end

  it "is invalid it it does not contain a url" do
    link =  Link.new(url: "", slug: "World")
    expect(link.valid?).not_to be true
  end

  it "is invalid if the slug has already been used" do
    link = Link.new(url: "https://www.westsideplugs.com/welcome-to-an-original-container",
    slug: "Shorty")
    link.save
    link2 = Link.new(url: "https://www.westsideplugs.com/welcome-to-an-original-container",
    slug: "Shorty")
    link2.save



    expect(link2.valid?).to be false
  end

  it "accepts only https or http formats for urls" do
    link = Link.new(url:"ftp://prayforukraine.com/world-wide", slug: "Notice")
    expect(link.valid?).to be false
  end

end
