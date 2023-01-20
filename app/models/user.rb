class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

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

  def revisor?
    self.role.nombre == "Revisor"
  end

  def unidad_academica?
    self.role.nombre == "Unidad Academica"
  end

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end

  def ultima_sesion
    if self.last_sign_in_at?
      self.last_sign_in_at.strftime("%d/%m/%y a las %T %P")
    else
      "Este usuario no ha inciado sesión"
    end
  end

end
