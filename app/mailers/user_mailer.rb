class UserMailer < ApplicationMailer
  default from: "dctss@ipn.mx"
  default "Message-ID" => lambda {"<#{SecureRandom.uuid}@ipn.mx>"}

  def email_notificacion(constancia_documento)
    @constancia_documento = constancia_documento
=begin
    archivo = WickedPdf.new.pdf_from_string(
      render_to_string(template: "constancia_documentos/imprimir.html.erb", layout: "imprimir.html.erb")
      )

    attachments["constancia_documento.pdf"] = archivo
=end
    mail(to: constancia_documento.correo, subject: "Constancia de Servicio Social")
  end
end
