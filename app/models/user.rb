class User < ApplicationRecord
  has_one  :cart,  dependent: :destroy
  after_create :create_cart
  has_many :orders, dependent: :nullify, dependent: :destroy

  # after_create :create_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


        def admin?
          self.admin
        end

      private

      def create_cart
        Cart.create(user: self)
        end

        def name
          [ first_name, last_name ].compact.join(" ")
        end

    after_create :notify_admin

        def notify_admin
          UserMailer.new_user_notification(self).deliver_later
          end
end
