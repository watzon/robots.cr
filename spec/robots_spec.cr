require "./spec_helper"

fixtures = ["emptyish", "eventbrite", "google", "reddit"].reduce({} of String => Robots) do |hash, name|
  robotstxt = File.read("spec/fixtures/#{name}.txt")
  hash[name] = Robots.new(robotstxt, "Googlebot")
  hash
end

describe Robots do
  describe "emptyish robots.txt" do
    it "allows access" do
      fixtures["emptyish"].allowed?("/").should be_true
      fixtures["emptyish"].allowed?("/home").should be_true
      fixtures["emptyish"].allowed?("/blog").should be_true
      fixtures["emptyish"].allowed?("/multiple/path/separators").should be_true
    end
  end

  describe "eventbrite robots.txt" do
    it "allows access" do
      fixtures["eventbrite"].allowed?("/").should be_true
      fixtures["eventbrite"].allowed?("/d/az--tempe/events/").should be_true
    end

    it "disallows access" do
      fixtures["eventbrite"].allowed?("/rest/").should be_false
      fixtures["eventbrite"].allowed?("/xml/").should be_false
      fixtures["eventbrite"].allowed?("/json/").should be_false
      fixtures["eventbrite"].allowed?("/atom/").should be_false
      fixtures["eventbrite"].allowed?("/orderconfirmation").should be_false
    end
  end

  describe "google robots.txt" do
    it "allows access" do
      fixtures["google"].allowed?("/").should be_true
    end

    it "disallows access" do
      fixtures["google"].allowed?("/search").should be_false
      fixtures["google"].allowed?("/groups").should be_false
      fixtures["google"].allowed?("/images").should be_false
      fixtures["google"].allowed?("/?").should be_false
      fixtures["google"].allowed?("/m?").should be_false
    end
  end

  describe "reddit robots.txt" do
    it "allows access" do
      fixtures["reddit"].allowed?("/").should be_true
      fixtures["reddit"].allowed?("/r/SushiChain").should be_true
    end

    it "disallows access" do
      fixtures["reddit"].allowed?("/goto").should be_false
      fixtures["reddit"].allowed?("/themorningafter=").should be_false
      fixtures["reddit"].allowed?("/login").should be_false
      fixtures["reddit"].allowed?("/search").should be_false
      fixtures["reddit"].allowed?("/r/SushiChain/search").should be_false
      fixtures["reddit"].allowed?("/reddits/search").should be_false
    end
  end
end
