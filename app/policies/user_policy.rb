class UserPolicy < ApplicationPolicy
  def index?
    user.administrador? or user.direccion? or user.departamento?
  end

  def new?
    user.administrador?
  end

  def create?
    user.administrador?
  end

  def show?
    user.administrador? or user.departamento?
  end

  def update?
    user.administrador?
  end
end
