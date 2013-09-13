class Notifier < ActionMailer::Base
  default from: "from@example.com"

  BCC_FOR_TEST = 'ndgiang84@gmail.com'

  def invitation_to_business(user_id, business)
    @business = business

    mail subject: "Invitation to join #{business.name}",
         to: User.find(user_id).email,
         bcc: BCC_FOR_TEST
  end
end
