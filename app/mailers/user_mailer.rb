class UserMailer < ApplicationMailer
  default from: "dctss@ipn.mx"
  default "Message-ID" => lambda {"<#{SecureRandom.uuid}@ipn.mx>"}

  def email_notificacion(constancia_documento)
    @constancia_documento = constancia_documento

    archivo = render_to_string_with_wicked_pdf(
      pdf: "constancia.pdf",
      template: "constancia_documentos/imprimir.html.erb",
      layout: "imprimir.html.erb"
      )

    attachments["constancia.pdf"] = archivo
    mail(to: constancia_documento.correo, subject: "Constancia de Servicio Social")
  end
end
