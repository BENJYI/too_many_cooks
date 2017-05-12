class User < ApplicationRecord
  include Geocodeable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_presence_of :address, if: :is_normal_user

  private
    def is_normal_user
      self.type.blank?
    end
end
