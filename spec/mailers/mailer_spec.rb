require "spec_helper"

describe Mailer do
	before(:all) do
		@email = Mailer.notify_signup("john@sub.domain", "CONFIRMATION_KEY")
	end

	it "should be set to be delivered to the email passed in" do
		@email.should deliver_to("john@sub.domain")
	end

	it "should be set to be delivered from the no-reply email" do
		@email.should deliver_from("no-reply@pomar.com")
	end

	it "should have the correct subject" do
		@email.should have_subject(/Pomar! Account confirmation/)
	end

	it "should contain a link for the account confirmation in the mail body" do
		@email.should have_body_text(/http:\/\/localhost:3000\/confirm\?key=CONFIRMATION_KEY/)
	end
end
