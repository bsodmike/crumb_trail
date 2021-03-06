require 'spec_helper'

module Factory
  def self.create_book_and_clear_logs
    Book.delete_all
    @book = Book.create!(:title => "Book").tap { |obj| obj.logs.reload }.reload
    Log.delete_all # Do not log changes for the above object
    @book
  end
end

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:each) do
    @book = Factory.create_book_and_clear_logs

    # NOTE All tests are run with the assumption that at this point there are no
    # logs persisted to the database.
  end

  it "should have the association of logs" do
    @book.logs.empty?.should be
  end

  describe "when changing object state" do
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
        @book = Book.create! title: "Book"
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

    describe "when updating attributes" do
      before(:each) do
        @book = Factory.create_book_and_clear_logs

        expect {
          created = Time.now.advance(:minutes => -5)
          @book.update_column :created_at, created

          @book_init = @book.dup.tap do |prev|
            prev.id = @book.id
            prev.title = @book.title
            prev.created_at = @book.created_at
            prev.updated_at = @book.updated_at
          end
          @book.update_attributes :title => "The Gutenberg Revolution"

          @result = @book.dup.tap do |book|
            book.id = @book.id
            book.title = "The Gutenberg Revolution"
            book.created_at = created
            book.updated_at = @book.updated_at
          end
        }.to_not raise_error
      end

      it "should ensure current object is as expected after update" do
        @book.reload.should == @result
      end

      it "should ensure the object returned by `previous_state` is the same as the object before update" do
        @book_init.reload.should == @book.previous_state
      end
    end

  end

  describe "CrumbTrail usage interface" do
    it "should respond to `has_logs?`" do
      @book.logs.empty?.should be
      @book.has_logs?.should be_false
    end

    context "without any logs" do
      it "should response to `previous_state` and return nil" do
        @book.logs.empty?.should be
        @book.previous_state.should be_nil
      end

      it "should respond to `previous_state` and return the previous object state" do
        @book.update_attributes :title => "The Gutenberg Revolution"
        result = @book.dup.tap do |prev|
          prev.id = @book.id
          prev.title = "Book"
          prev.created_at = @book.created_at
          prev.updated_at = @book.updated_at
        end
        @book.previous_state.should == result
      end
    end
  end
end
