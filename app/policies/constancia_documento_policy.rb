class ConstanciaDocumentoPolicy < ApplicationPolicy
  def index?
    user.administrador? or user.direccion? or user.departamento? or user.captura? or user.validador?
  end

  def new?
    user.administrador? or user.departamento? or user.captura? or user.revisor?
  end

  def create?
    user.administrador? or user.departamento? or user.captura? or user.revisor?
  end

  def show?
    user.administrador? or user.departamento? or user.captura? or user.revisor?
  end

  def datos_captura?
    user.administrador? or user.departamento?
  end

  def validar_emision?
    user.administrador? or user.departamento? or user.validador?
  end

  def update?
    user.administrador? or user.direccion? or user.departamento? or
    user.captura? or user.revisor? or user.validador?
  end

  def firmar?
    user.direccion?
  end

  def eliminar?
    user.administrador? or user.departamento?
  end

  def opciones?
    user.administrador? or user.departamento? or user.captura? or user.revisor?
  end
end
