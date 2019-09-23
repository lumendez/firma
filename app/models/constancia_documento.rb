class ConstanciaDocumento < ApplicationRecord
  uuidable

  validates :folio, :numero_relacion,
    :numero_oficio, :numero_registro, :codigo_prestatario, :clave_programa,
    :fecha, :nombre, :boleta, :unidad_academica, :programa_academico,
    :periodo, :prestatario, :apellido_paterno, :user_id,
    :apellido_materno, presence: true

  filterrific(
    available_filters: [
      :search_query
    ],
  )

  paginates_per 5

  belongs_to :user

  scope :search_query, lambda { |query|

    # Filtra a los usuarios por nombre o apellido paterno
    return nil  if query.blank?

    # Condiciones del query divididas en palabras separadas y en minúsculas
    terms = query.to_s.downcase.split(/\s+/)

    # Reemplaza "*" con "%" para búsquedas con comodin,
    # liga '%', quita los '%' duplicados
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    # Configura el numero de condiciones OR proporcionados (provision)
    # como argumentos de interpolación. Ajustar si se cambian el
    # número de condiciones OR.
    num_or_conds = 1

    where(
      terms.map { |term|
        "(constancia_documentos.boleta LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  def to_param
    uuid
  end

end
