class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    # Honeypot: スパナ対策
    if params.dig(:contact, :nickname).present?
      Rails.logger.info "[SPAM] contact honeypot triggered ip=#{request.ip} ua=#{request.user_agent}"
      head :ok and return
    end

    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_contact(@contact).deliver_now
      redirect_to new_contact_path, notice: "お問い合わせを送信しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
