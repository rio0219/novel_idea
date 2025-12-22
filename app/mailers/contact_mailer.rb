class ContactMailer < ApplicationMailer
  default to: "riomomo555@gmail.com"

  def send_contact(contact)
    @contact = contact
    mail(
      from: contact.email,
      subject: "【】#{contact.name}様より"
    )
  end
end
