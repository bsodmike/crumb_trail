require 'spec_helper'

describe "ActiveRecord Models that declare `has_crumb_trail`" do
  before(:all) do
    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => "../dummy/db/test.sqlite3"
    ActiveRecord::Base.connection.execute "INSERT INTO books (title, created_at, updated_at) VALUES ('Book', '#{Time.now}', '#{Time.now}')"
    @book = Book.first
  end

  it "should respond to Book#icanhazcheeseburger?" do
    @book.icanhazcheeseburger?.should eq "om nom nom!"
  end

  it "should have_many logs" do
    @book.logs.should eq []
  end
end
