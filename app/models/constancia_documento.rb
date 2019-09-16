class ConstanciaDocumento < ApplicationRecord
  validates :folio, :numero_relacion,
    :numero_oficio, :numero_registro, :codigo_prestatario, :clave_programa,
    :fecha, :nombre, :boleta, :unidad_academica, :programa_academico,
    :periodo, :prestatario, :apellido_paterno, :user_id,
    :apellido_materno, presence: true

    belongs_to :user
end
