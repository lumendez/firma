class ConstanciaDocumentoPolicy < ApplicationPolicy
  def index?
    user.administrador? or user.direccion? or user.departamento? or user.captura?
  end

  def new?
    user.administrador? or user.departamento? or user.captura?
  end

  def create?
    user.administrador? or user.departamento? or user.captura?
  end

  def show?
    user.administrador? or user.departamento? or user.captura?
  end

  def datos_captura?
    user.administrador? or user.departamento?
  end

  def validar_emision?
    user.administrador? or user.departamento?
  end

  def update?
    user.administrador? or user.direccion? or user.departamento? or user.captura?
  end

  def firmar?
    user.direccion?
  end

  def eliminar?
    user.administrador? or user.departamento?
  end
end
