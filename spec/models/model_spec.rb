require 'spec_helper'

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:all) do
    # Do not trigger AR callbacks
    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => "../dummy/db/test.sqlite3"
    ActiveRecord::Base.connection.execute "INSERT INTO books (title, created_at, updated_at) VALUES ('Book', '#{Time.now}', '#{Time.now}')"
    @book = Book.first
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
