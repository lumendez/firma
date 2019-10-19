class UserMailer < ApplicationMailer
  default from: "dctss@ipn.mx"

  def email_notificacion(constancia_documento)
    @constancia_documento = constancia_documento
    mail(to: constancia_documento.correo, subject: "Constancia de Servicio Social")
  end
end
