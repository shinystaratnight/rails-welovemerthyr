class Notifier < ActionMailer::Base
  default from: "from@example.com"

  BCC_FOR_TEST = 'ndgiang84@gmail.com'

  def invitation_to_business(email, business)
    @email = email
    @business = business

    mail subject: "Invitation to join #{business.name}",
         to: email,
         bcc: BCC_FOR_TEST
  end
end
