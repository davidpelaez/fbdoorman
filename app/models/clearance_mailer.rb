class ClearanceMailer < ActionMailer::Base

  def change_password(user)
    from       Clearance.configuration.mailer_sender
    recipients user.email
    subject    I18n.t(:change_password,
                      :scope   => [:clearance, :models, :clearance_mailer],
                      :default => "Change your password")
    body       :user => user
  end

  def confirmation(user)
    from       Clearance.configuration.mailer_sender
    recipients select_destination(user)
    subject    I18n.t(:confirmation,
                      :scope   => [:clearance, :models, :clearance_mailer],
                      :default => "Account confirmation")
    body      :user => user
  end
  
  private
  
  def select_destination(user)
    if user.email.blank? then user.email2 else user.email end
  end

end
