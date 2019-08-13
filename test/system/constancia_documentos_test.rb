require "application_system_test_case"

class ConstanciaDocumentosTest < ApplicationSystemTestCase
  setup do
    @constancia_documento = constancia_documentos(:one)
  end

  test "visiting the index" do
    visit constancia_documentos_url
    assert_selector "h1", text: "Constancia Documentos"
  end

  test "creating a Constancia documento" do
    visit constancia_documentos_url
    click_on "New Constancia Documento"

    fill_in "Boleta", with: @constancia_documento.boleta
    fill_in "Clave programa", with: @constancia_documento.clave_programa
    fill_in "Codigo prestatario", with: @constancia_documento.codigo_prestatario
    check "Constancia emitida" if @constancia_documento.constancia_emitida
    fill_in "Fecha", with: @constancia_documento.fecha
    fill_in "Folio", with: @constancia_documento.folio
    fill_in "Nombre", with: @constancia_documento.nombre
    fill_in "Numero oficio", with: @constancia_documento.numero_oficio
    fill_in "Numero registro", with: @constancia_documento.numero_registro
    fill_in "Numero relacion", with: @constancia_documento.numero_relacion
    fill_in "Periodo", with: @constancia_documento.periodo
    fill_in "Prestatario", with: @constancia_documento.prestatario
    fill_in "Programa academico", with: @constancia_documento.programa_academico
    fill_in "Unidad academica", with: @constancia_documento.unidad_academica
    click_on "Create Constancia documento"

    assert_text "Constancia documento was successfully created"
    click_on "Back"
  end

  test "updating a Constancia documento" do
    visit constancia_documentos_url
    click_on "Edit", match: :first

    fill_in "Boleta", with: @constancia_documento.boleta
    fill_in "Clave programa", with: @constancia_documento.clave_programa
    fill_in "Codigo prestatario", with: @constancia_documento.codigo_prestatario
    check "Constancia emitida" if @constancia_documento.constancia_emitida
    fill_in "Fecha", with: @constancia_documento.fecha
    fill_in "Folio", with: @constancia_documento.folio
    fill_in "Nombre", with: @constancia_documento.nombre
    fill_in "Numero oficio", with: @constancia_documento.numero_oficio
    fill_in "Numero registro", with: @constancia_documento.numero_registro
    fill_in "Numero relacion", with: @constancia_documento.numero_relacion
    fill_in "Periodo", with: @constancia_documento.periodo
    fill_in "Prestatario", with: @constancia_documento.prestatario
    fill_in "Programa academico", with: @constancia_documento.programa_academico
    fill_in "Unidad academica", with: @constancia_documento.unidad_academica
    click_on "Update Constancia documento"

    assert_text "Constancia documento was successfully updated"
    click_on "Back"
  end

  test "destroying a Constancia documento" do
    visit constancia_documentos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Constancia documento was successfully destroyed"
  end
end
