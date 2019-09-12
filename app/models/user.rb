class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  before_save :assign_role

  # Asignación de rol por default
  def assign_role
    self.role = Role.find_by nombre: "Administrador" if self.role.nil?
  end

end
