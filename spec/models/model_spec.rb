require 'spec_helper'

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:each) do
    @book = Book.create!(:title => "Book").tap { |obj| obj.logs.reload }.reload
    Log.delete_all # Do not log changes for the above object
  end

  it "should have_many logs" do
    @book.logs.should eq []
  end

  it "should log object state for changes made" do
    @book.update_attributes :title => "The Gutenberg Revolution"
    @book.logs.empty?.should be_false
    @book.logs.first.object_changes["title"].should eq "Book"
  end

  it "should log object state after it is destroyed" do
    Log.all.empty?.should be
    @book.destroy
    Log.find_by_item_id(@book.id).should be
  end

  context "should log changes when saving a new object" do
    it "logs current object" do
      Log.all.empty?.should be
      @book = Book.create title: "Book"
      @book.logs.empty?.should be_false
    end
  end
end
