require 'spec_helper'

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:each) do
    @book = Book.create!(:title => "Book").tap { |obj| obj.logs.reload }.reload
    Log.delete_all # Do not log changes for the above object

    # NOTE All tests are run with the assumption that at this point there are no
    # logs persisted to the database.
  end

  it "should have the association of logs" do
    @book.logs.empty?.should be
  end

  context "when changing object state" do
    context "when updating an object attribute" do
      it "should log object state for changes made" do
        @book.update_attributes :title => "The Gutenberg Revolution"
        @book.logs.empty?.should be_false
        @book.logs.first.object_changes["title"].should eq "Book"
      end
    end

    context "when saving a new object" do
      it "should log state of the current object" do
        Log.all.empty?.should be
        @book = Book.create title: "Book"
        @book.logs.empty?.should be_false
      end
    end

    context "when destroying an object" do
      it "should log object state after it is destroyed" do
        Log.all.empty?.should be
        @book.destroy
        Log.find_by_item_id(@book.id).should be
      end
    end
  end
end
