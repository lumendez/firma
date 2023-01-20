class Role < ApplicationRecord

  has_many :users
  
  def nombre_descripcion
    "#{nombre} - #{descripcion}"
  end
end
