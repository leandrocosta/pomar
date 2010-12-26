class Mailer < ActionMailer::Base
  default :from => "no-reply@pomar.com", :subject => "Pomar! Account confirmation"

  def notify_signup(receiver, key)
    mail :to => receiver, :body => "Please, click on this link to activate your account: http://localhost:3000/confirm?key=" + key
  end
end
