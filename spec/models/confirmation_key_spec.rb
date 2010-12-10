require 'spec_helper'

describe ConfirmationKey do
  before do
    @confirmation_key = ConfirmationKey.new
  end

  it "should validate the presence of key" do
    @confirmation_key.should_not be_valid
  end

  it "should validate the key's length" do
    @confirmation_key.key = "123456789012345678901234567890123456789"
    @confirmation_key.should_not be_valid
  end

  it "should accept a valid key" do
    @confirmation_key.key = Digest::SHA1.hexdigest('')
    @confirmation_key.should be_valid
  end
end
