class OrderMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def welcome_email(user)
    @user = user
    @url  = 'https://papillonvital.fr/login' # ou root_path si local
    mail(to: @user.email, subject: 'Bienvenue chez Papillon Vital !')
  end
  

  def confirmation_email(order)
    @order = order
    @user = order.user
    @products = order.products
    mail(to: @user.email, subject: "Merci pour ta commande de Nos produits bio!")
  end

  def order_notification(order)
    @order = order
    @user = order.user
    mail(to: "admin@papillonvital.com", subject: "Nouvelle commande passée !")
  end

end