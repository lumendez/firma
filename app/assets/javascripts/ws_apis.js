     document.getElementById("getCurp").onclick = function(){
        var curp = document.getElementById("fcurp").value;
        $.ajax({
          type: "GET",
          //contentType: "application/json; charset=utf-8",
          url: "/get_info_curp/"+curp,
          dataType: "json",
          //data: "boleta=2019500120",
          success: function (data){
            //var json = parseJSON(data);
            //var response = JSON.stringify(data);
            //var json = parseJSON(data);
            console.log(data);
            if(data != null ){
              document.getElementById("constancia_documento_nombre").value = data['nombres'].toString();
              document.getElementById("constancia_documento_apellido_paterno").value = data['apellido1'].toString();
              document.getElementById("constancia_documento_apellido_materno").value = data['apellido2'].toString();
            }
            else{
              alert("Boleta no Encontrada");
            }
            //var json = JSON.parse(data.toString);
            //alert(json.html);
          },
          error: function (data){ console.log(data) }
        });
      }
      document.getElementById("getBoleta").onclick = function(){
        //var nombre = JSON.stringify(alumno)
        //document.getElementById("getBoleta")
              document.getElementById("constancia_documento_boleta").value = "";
              document.getElementById("constancia_documento_unidad_academica").value = "";
              document.getElementById("constancia_documento_programa_academico").value = "";
              document.getElementById("constancia_documento_nombre").value = "";
              document.getElementById("constancia_documento_apellido_paterno").value = "";
              document.getElementById("constancia_documento_apellido_materno").value = "";
        var boleta = document.getElementById("fboleta").value;

        //alert(boleta);
        $.ajax({
          type: "GET",
          //contentType: "application/json; charset=utf-8",
          url: "/get_info_alumno/"+boleta,
          dataType: "json",
          //data: "boleta=2019500120",
          success: function (data){
            //var json = parseJSON(data);
            //var response = JSON.stringify(data);
            //var json = parseJSON(data);
            console.log(data);
            //var json = JSON.parse(data.toString);
            if(data.length >= 1 ){
              document.getElementById("constancia_documento_boleta").value = data[0]['BOLETA'].toString();
              document.getElementById("constancia_documento_unidad_academica").value = data[0]['NOMBRE_ESCUELA'].toString();
              document.getElementById("constancia_documento_programa_academico").value = data[0]['CARRERA'].toString();
              document.getElementById("constancia_documento_nombre").value = data[0]['NOMBRE'].toString();
              document.getElementById("constancia_documento_apellido_paterno").value = data[0]['PATERNO'].toString();
              document.getElementById("constancia_documento_apellido_materno").value = data[0]['MATERNO'].toString();
            }
            else
            {
              alert("Boleta no Encontrada");
            }
            //alert(json.html);
          },
          error: function (data){ console.log(data) }
        });
        //window.alert(nombre);
      };
