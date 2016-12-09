class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order)
    @order = order
    # byebug
    # email_with_name = %("#{@user.first_name} #{@user.last_name}" <#{@user.email}>)
    @url = 'http://localhost:3000'
    mail(to: @order.email,
         subject: "Thank you for your order from Jungle! - Order ID:#{@order.id}")
  end
end
