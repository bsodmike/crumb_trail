require 'spec_helper'

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:all) do
    @book = Book.create :title => 'Book'
  end

  it "should respond to Book#icanhazcheeseburger?" do
    @book.icanhazcheeseburger?.should == "om nom nom!"
  end
end
