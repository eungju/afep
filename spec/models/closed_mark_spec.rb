require 'spec_helper'

describe ClosedMark do
  before(:each) do
    @valid_attributes = {
      :todo_id=>1
    }
  end

  it "should create a new instance given valid attributes" do
    ClosedMark.create!(@valid_attributes)
  end
end
