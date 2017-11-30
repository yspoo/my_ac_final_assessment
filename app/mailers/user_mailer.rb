class UserMailer < ApplicationMailer

  default from: "admin@example.com"

  def delete_account_notification(user)
    @user = user
    mail to: @user.email, subject: "Confirmation of deletetion of account."
  end

  def delete_note_notification(user)
    @user = user
    mail to: @user.email, subject: "Confirmation of deletion of note."
  end

end
