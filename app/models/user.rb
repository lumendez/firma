class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :constancia_documentos, dependent: :destroy
  belongs_to :role
  before_save :assign_role

  # Asignación de rol por default
  def assign_role
    self.role = Role.find_by nombre: "Administrador" if self.role.nil?
  end

  def administrador?
    self.role.name == "Admin"
  end

  def direccion?
    self.role.name == "Dirección"
  end

  def departamento?
    self.role.name == "Departamento"
  end

  def captura?
    self.role.name == "Captura"
  end

end
