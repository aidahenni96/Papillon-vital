class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def welcome_email(user)
    @user = user
    @url = "http://monsite.fr/login"
    mail(to: @user.email, subject: "Bienvenue chez Papillon Vital !")
  end

  def order_notification(order)
    @order = order
    @user = order.user

    # Récupère tous les emails d'admin
    admins = User.where(is_admin: true).pluck(:email)

    mail(to: admins, subject: "Nouvelle commande passée !")
  end

  def new_user_notification(user)
    @user = user
    mail(
      to: "admin@papillon-vital.com",
      subject: "Nouveau compte utilisateur"
    )
  end
end
