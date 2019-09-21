class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :constancia_documentos, dependent: :destroy
  belongs_to :role
  has_one_time_password
  enum otp_module: {disabled: 0, enabled: 1}, _prefix: true
  attr_accessor :otp_code_token




  def administrador?
    self.role.nombre == "Administrador"
  end

  def direccion?
    self.role.nombre == "Dirección"
  end

  def departamento?
    self.role.nombre == "Departamento"
  end

  def captura?
    self.role.nombre == "Captura"
  end

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end

end
