class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def creado
    self.created_at.strftime("%d/%m/%y a las %T %P")
  end

end
