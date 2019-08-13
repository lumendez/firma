require 'test_helper'

class ConstanciaDocumentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @constancia_documento = constancia_documentos(:one)
  end

  test "should get index" do
    get constancia_documentos_url
    assert_response :success
  end

  test "should get new" do
    get new_constancia_documento_url
    assert_response :success
  end

  test "should create constancia_documento" do
    assert_difference('ConstanciaDocumento.count') do
      post constancia_documentos_url, params: { constancia_documento: { boleta: @constancia_documento.boleta, clave_programa: @constancia_documento.clave_programa, codigo_prestatario: @constancia_documento.codigo_prestatario, constancia_emitida: @constancia_documento.constancia_emitida, fecha: @constancia_documento.fecha, folio: @constancia_documento.folio, nombre: @constancia_documento.nombre, numero_oficio: @constancia_documento.numero_oficio, numero_registro: @constancia_documento.numero_registro, numero_relacion: @constancia_documento.numero_relacion, periodo: @constancia_documento.periodo, prestatario: @constancia_documento.prestatario, programa_academico: @constancia_documento.programa_academico, unidad_academica: @constancia_documento.unidad_academica } }
    end

    assert_redirected_to constancia_documento_url(ConstanciaDocumento.last)
  end

  test "should show constancia_documento" do
    get constancia_documento_url(@constancia_documento)
    assert_response :success
  end

  test "should get edit" do
    get edit_constancia_documento_url(@constancia_documento)
    assert_response :success
  end

  test "should update constancia_documento" do
    patch constancia_documento_url(@constancia_documento), params: { constancia_documento: { boleta: @constancia_documento.boleta, clave_programa: @constancia_documento.clave_programa, codigo_prestatario: @constancia_documento.codigo_prestatario, constancia_emitida: @constancia_documento.constancia_emitida, fecha: @constancia_documento.fecha, folio: @constancia_documento.folio, nombre: @constancia_documento.nombre, numero_oficio: @constancia_documento.numero_oficio, numero_registro: @constancia_documento.numero_registro, numero_relacion: @constancia_documento.numero_relacion, periodo: @constancia_documento.periodo, prestatario: @constancia_documento.prestatario, programa_academico: @constancia_documento.programa_academico, unidad_academica: @constancia_documento.unidad_academica } }
    assert_redirected_to constancia_documento_url(@constancia_documento)
  end

  test "should destroy constancia_documento" do
    assert_difference('ConstanciaDocumento.count', -1) do
      delete constancia_documento_url(@constancia_documento)
    end

    assert_redirected_to constancia_documentos_url
  end
end
