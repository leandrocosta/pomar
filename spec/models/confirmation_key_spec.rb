require 'spec_helper'

describe ConfirmationKey do
  it "should validate the presence of key" do
    confirmation_key = ConfirmationKey.new
    confirmation_key.should_not be_valid
  end

  it "should accept a valid key" do
    confirmation_key = ConfirmationKey.new
    confirmation_key.key = Digest::SHA1.hexdigest('')
    confirmation_key.should be_valid
  end
end
