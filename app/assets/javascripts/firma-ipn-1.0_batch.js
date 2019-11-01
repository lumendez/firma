/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
if (typeof PKI === "undefined" || !PKI)
    PKI = {};
if (typeof PKI.IPN === "undefined" || !PKI.IPN)
    PKI.IPN = {};
PKI.IPN.FielUtil = new function () {
    this.id = "";
    this.cb = "";
    this.f = "";
    this.rfc = "";
    this.sncrt = "";
    this.cF = "";
    this.inicio = "";
    this.fin = "";
    this.cn_cert = "";
    var pem ="";//-- PEM Certificate
    var vigente;
    var match;
    
    
    //var resultSend;
    
    this.load = function (idComponete) {
        document.getElementById(idComponete + ":frm-fiel").reset();
    };
    this.docuuid = function () {
        this.id = this.up('DOCUUID');
        console.log('DOCUUID: ' + this.id);
        return this.id;
    };
    this.r = function (v) {
        var m = PKI.IPN.FielUtil.obtenMensajeError(v);
        console.log(m);
        $("#mensajes").text(m);
    };
    this.c = function (v) {
        return $.find(v)[0];
    };
    this.ce = function (n) {
    	PKI.IPN.FielUtil.vigente = true;
    	
        var r = this.r;
        if (!this.vce(n, r)) {
            return;
        }
        var i = new FileReader;
        
        i.onload = function (n) {
        	lock();
            var s = new Uint8Array(i.result);
            var o = "";
            for (var u = 0; u < s.byteLength; u++) {
                o += String.fromCharCode(s[u]);
            }
            var a = rstrtohex(o);
            var f = KJUR.asn1.ASN1Util.getPEMStringFromHex(a, "CERTIFICATE");
            var l = new X509;
            l.readCertPEM(f);
            var c = l.subjectPublicKeyRSA.n;
            if (typeof c === "undefined") {
                r(27);
                return;
            }
            PKI.IPN.FielUtil.cn_cert = c;
            
            /*PKI.IPN.FielUtil.vigente = PKI.IPN.FielUtil.isVigente(l);
            if (PKI.IPN.FielUtil.vigente === false) {
                r(27);
                return;
            }*/
            
            PKI.IPN.FielUtil.vigente = validacion(f);
            if (PKI.IPN.FielUtil.vigente === false) {
                r(27);
                return;
            }
            
            PKI.IPN.FielUtil.prfc(l);
            PKI.IPN.FielUtil.prsc(l);
            PKI.IPN.FielUtil.pem=f;
            //console.log(this.pem);
            unlock();
            
        };
        
        if (PKI.IPN.FielUtil.vigente === false) {
            r(27);
            return;
        }
        
        this.cn(n.files[0]);
        i.readAsArrayBuffer(n.files[0]);
    };
    this.ke = function (e, t, n) {
    	PKI.IPN.FielUtil.match = true;
        r = this.r;
        if (!this.vce(n, r)) {
            return;
        }
        if (!this.vfi(e, t, "...", r)) {
        	PKI.IPN.FielUtil.ck(e.files[0]);
            return;
        }
        var i = new FileReader;
        i.onload = function (n) {
            var s = new Uint8Array(i.result);
            var o = "";
            for (var u = 0; u < s.byteLength; u++) {
                o += String.fromCharCode(s[u]);
            }
            var a = rstrtohex(o);
            var f = KJUR.asn1.ASN1Util.getPEMStringFromHex(a, "CERTIFICATE");
            var l = new X509;
            l.readCertPEM(f);
            var c = l.subjectPublicKeyRSA.n;
            if (typeof c === "undefined") {
                r(27);
                return;
            }
            var h = new FileReader;
            h.onload = function (e) {
                var n = new Uint8Array(h.result);
                var i = "";
                for (var s = 0; s < n.byteLength; s++) {
                    i += String.fromCharCode(n[s])
                }
                var o = rstrtohex(i);
                var u = KJUR.asn1.ASN1Util.getPEMStringFromHex(o, "ENCRYPTED PRIVATE KEY");
                try {
                    var a = KEYUTIL.getKey(u, t, "PKCS8PRV");
                    t = null;
                    var f = a.n;
                    if (!c.equals(f)) {
                    	PKI.IPN.FielUtil.match = false;
                        r(28);
                        return;
                    }                    
                    
                } catch (e) {
                    if (e.indexOf("malformed format: SEQUENCE(0).items != 2") !== -1) {
                        r(24);
                        console.log(24);
                        return;
                    } else if (e === "malformed plain PKCS8 private key(code:001)") {
                        r(25);
                        console.log(25);
                        return;
                    } else {
                        r(24);
                        console.log(24);
                        return;
                    }
                }
            };
            PKI.IPN.FielUtil.ck(e.files[0]);
            h.readAsArrayBuffer(e.files[0]);
        };
        this.cn(n.files[0]);
        i.readAsArrayBuffer(n.files[0]);
    };
    
    this.fi = function (e, t, n) {
        console.log("START SIGN");
        console.log("Dato Certificado: "+PKI.IPN.FielUtil.cn_cert);
        r = this.r;

        var ci = PKI.IPN.FielUtil.c;
        var ki = ci('[name="fileCer"]');


        if (PKI.IPN.FielUtil.vigente === false) {
        	unlock();
        	r(27);
            return;
        }
    	
        if (!this.vfi(e, t, n, r)) {
        	unlock();
        	return;
        }
        
        var hi = new FileReader;
		hi.onload = function (ki) {
			var si = new Uint8Array(hi.result);
            var oi = "";
            for (var ui = 0; ui < si.byteLength; ui++) {
                oi += String.fromCharCode(si[ui]);
            }
            var ai = rstrtohex(oi);
            var fi12 = KJUR.asn1.ASN1Util.getPEMStringFromHex(ai, "CERTIFICATE");
            var li = new X509;
            li.readCertPEM(fi12);
            var ci = li.subjectPublicKeyRSA.n;
            if (typeof ci === "undefined") {
            	unlock();
                r(27);
                return;
            }


            var i = new FileReader;
            i.onload = function (e) {
                var s = new Uint8Array(i.result);
                var o = "";
                for (var u = 0; u < s.byteLength; u++) {
                    o += String.fromCharCode(s[u]);
                }
                var a = rstrtohex(o);
                var f = KJUR.asn1.ASN1Util.getPEMStringFromHex(a, "ENCRYPTED PRIVATE KEY");
                var l = "";
                try {
                    var c = KEYUTIL.getKey(f, t, "PKCS8PRV");
                    t = null;
                    //--
                    var fi = c.n;
                    if (!ci.equals(fi)) {
                    	unlock();
                        r(28);
                        return;
                    }
	                //--
	                /*var cadenaFoliar = getCadenaParaFirmar(n,tf);
	                if(typeof cadenaFoliar === "undefined"){
	                	r(32);
	                    return;
	                }
	                
	                PKI.IPN.FielUtil.caFo(cadenaFoliar);*/
	                
	                /*var h = c.signString(n, "sha1");
	                l = hex2b64(h)*/
	                
	                //lock();
	                //--- 1. GET CADENAS
	                //var myJson = getCadenas("processId","SessionId");
	                var myJson = n;
	                if(myJson === null){
	                	unlock();
	                    r(34);
	                    return;
	                }
	                
	                
	                //--- 2. FIRMA Multiple
	                var firmas=firmaMultiple(c,myJson);
	                //--- 3. VALIDATE CERTIFICADOS
	                /*PKI.IPN.FielUtil.vigente = PKI.IPN.FielUtil.isVigente(li);
	                if (PKI.IPN.FielUtil.vigente === false) {
	                	unlock();
	                    r(27);
	                    return;
	                }
	                
	                PKI.IPN.FielUtil.vigente = validacion(fi);
	                if (PKI.IPN.FielUtil.vigente === false) {
	                	unlock();
	                    r(27);
	                    return;
	                }*/
	                
	                
	                var resultFirma2Send = "";
                    if(firmas.length !== 0){
                    	resultFirma2Send = JSON.stringify({"data":{"cadena":firmas}});
                    }
                    
                    
                    console.log("Result To Send...");
	                console.log(resultFirma2Send);
	                
	                //--- 4. SEND CADENAS
	                /*var myJson2 = sendCadenas(firmas,"processId","sessionId","personId");
	                if(myJson2 === null){
	                	unlock();
	                    r(35);
	                    return;
	                }else{
	                	PKI.IPN.FielUtil.resultSend = true;
	                }*/
	                //PKI.IPN.FielUtil.f = resultFirma2Send;
	                PKI.IPN.FielUtil.pfi(resultFirma2Send);
	                //console.log("firma:"+l);
	                unlock();
	                
	                console.log("OUT -> Serie Certificado:"+PKI.IPN.FielUtil.sncrt);
	                console.log("OUT -> Vigencia Certificado:"+PKI.IPN.FielUtil.inicio +" al "+PKI.IPN.FielUtil.fin);
	                //console.log("OUT -> Result:"+PKI.IPN.FielUtil.resultSend);
	                console.log("OUT -> Enviando...");
	                
	                //enviaFirma2(PKI.IPN.FielUtil.f, PKI.IPN.FielUtil.sncrt,PKI.IPN.FielUtil.inicio,PKI.IPN.FielUtil.fin,'dlgFirmaDigital');
	                //enviaFirma2(PKI.IPN.FielUtil.f, PKI.IPN.FielUtil.sncrt,PKI.IPN.FielUtil.inicio,PKI.IPN.FielUtil.fin,'dlgFirmaDigital');
	                console.log("Firma:"+PKI.IPN.FielUtil.f);
	            } catch (e) {
	            	console.log(e.name);
	            	unlock();
	            	
	            	if(e.name === "TypeError"){
	            		r(36);
	                    return;
	            	}
	            	
	                if (e.indexOf("malformed format: SEQUENCE(0).items != 2") !== -1) {
	                    r(24);
	                    return;
	                } else if (e === "malformed plain PKCS8 private key(code:001)") {
	                    r(25);
	                    return;
	                } else {
	                    r(24);
	                    return;
	                }
	            }
	        };
	        i.readAsArrayBuffer(e.files[0]);
		};
        hi.readAsArrayBuffer(ki.files[0]);
        
        console.log("END SIGN");
    };
    this.cn = function (n) {
        this.c('[name="fileCerName"]').value = n.name;
    };
    this.ck = function (v) {
        this.c('[name="fileKeyName"]').value = v.name;
    };
    this.vce = function (e, t) {
    	this.clear();
        if (typeof t !== "function") {
            throw "Se requiere una función callback al invocar el método firmar()";
        }
        if (typeof e === "undefined" || e === null) {
            t(15);
            return false;
        }
        if (typeof e.files === "undefined") {
            t(16);
            return false;
        }
        if (e.files.length === 0) {
            t(26);
            return false;
        }
        return true;
    };
    this.vfi = function (e, t, n, r) {
    	this.clear();
        if (typeof r !== "function") {
            throw "Se requiere una función callback al invocar el método firmar()";
        }
        if (typeof e === "undefined" || e === null) {
            r(11);
            return false;
        }
        if (typeof e.files === "undefined") {
            r(12);
            return false;
        }
        if (typeof t === "undefined" || t === null) {
            r(13);
            return false;
        }
        if (typeof n === "undefined") {
            r(14);
            return false;
        }
        if (e.files.length === 0) {
            r(21);
            return false;
        }
        if (t === "") {
            r(22);
            return false;
        }
        if (n === "") {
            r(23);
            return false;
        }
        return true;
    };
    this.pfi = function (l) {
        PKI.IPN.FielUtil.f = l;
        $.find('[name="firmaElectronica"]')[0].value = PKI.IPN.FielUtil.f;
    };
    this.caFo = function (l) {
    	PKI.IPN.FielUtil.cF = l;
        $.find('[name="cadenaUnicaFolio"]')[0].value = PKI.IPN.FielUtil.cF;
    };
    this.prfc = function (l) {
    	this.rfc = this.obtenRfc(l);
        $.find('[name="rfcEmisor"]')[0].value = this.rfc;
        $.find('[name="rfcSesion"]')[0].value = this.rfc;
    };
    this.prsc = function (l) {
    	this.sncrt = this.obtenNumSerie(l);
    };
    this.obtenRfc = function (e) {
        var t = e.getSubjectString();
        var n = t.match(/\/undefined=[A-Z,\u00D1,\u00F1,&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9]?[A-Z,0-9]?[0-9,A-Z]?[\s]{0,1}\//);
        if (n.length === 1) {
            var r = n[0].match(/[A-Z,\u00D1,\u00F1,&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9]?[A-Z,0-9]?[0-9,A-Z]?/);
            if (r.length > 0) {
                return r[0];
            } else {
                return "";
            }
        } else {
            return "";
        }
    };
    this.obtenNumSerie = function (e) {
        var t = e.getSerialNumberHex();
        var n = 1;
        var r = "";
        while (n < t.length) {
            var i = t.charAt(n);
            r = r + i;
            n = n + 2;
        }
        return r;
    };
    this.obtenDateInicial = function (e) {
        var t = e.getNotBefore();
        var n = parseInt(t.substring(0, 2)) + 2e3;
        var r = parseInt(t.substring(2, 4)) - 1;
        var i = parseInt(t.substring(4, 6));
        var s = new Date(n, r, i);
        PKI.IPN.FielUtil.inicio = PKI.IPN.FielUtil.date2String(s);
        return s;
    };
    this.obtenDateFinal = function (e) {
        var t = e.getNotAfter();
        var n = parseInt(t.substring(0, 2)) + 2e3;
        var r = parseInt(t.substring(2, 4)) - 1;
        var i = parseInt(t.substring(4, 6));
        var s = new Date(n, r, i, 23, 59, 59);
        PKI.IPN.FielUtil.fin = PKI.IPN.FielUtil.date2String(s);
        return s;
    };
    this.isVigente = function (e) {
    	var t = this.obtenDateInicial(e);
        var n = this.obtenDateFinal(e);
        var r = new Date;
        if (r >= t && r <= n) {
            return true;
        } else {
            return false; //TODO: false
        }
    };
    this.date2String = function (e) {
    	var today = e;
    	var dd = today.getDate();
    	var mm = today.getMonth()+1; //January is 0!

    	var yyyy = today.getFullYear();
    	if(dd<10){
    	    dd='0'+dd;
    	} 
    	if(mm<10){
    	    mm='0'+mm;
    	} 
    	return dd+'/'+mm+'/'+yyyy;    	
    };
    
    this.obtenMensajeError = function (e) {
        var t;
        if (typeof e === "undefined" || e === null) {
            return "Desconocido";
        }
        switch (e) {
            case 11:
                t = "No se ha pasado un valor para filePrivateKey para llave privada";
                break;
            case 12:
                t = "No se ha pasado un input del tipo file para llave privada";
                break;
            case 13:
                t = "No se ha pasado un valor para contraseña";
                break;
            case 14:
                t = "No se ha pasado un valor para la cadena a firmar";
                break;
            case 15:
                t = "No se ha pasado un valor para fileCertificado para Certificado";
                break;
            case 16:
                t = "No se ha pasado un input del tipo file para Certificado";
                break;
            case 21:
                t = "Selecione una llave privada";
                break;
            case 22:
                t = "Escriba la contraseña";
                break;
            case 23:
                t = "Introduza la información a firmar";
                break;
            case 24:
                t = "La llave privada no es válida";
                break;
            case 25:
                t = "La contraseña no es válida";
                break;
            case 26:
                t = "Seleccione un certificado";
                break;
            case 27:
                t = "El certificado no es válido";
                break;
            case 28:
                t = "El certificado no corresponde con la llave privada";
                break;
            case 29:
                t = "El certificado no pertenece al usuario en sesión";
                break;
            case 30:
                t = "Error Red: Fallo al recuperar el Folio IPN";
                break;
            case 31:
                t = "Error Red: Fallo al validar Certificado";
                break;
            case 32:
                t = "Fallo al recuperar el Folio IPN";
                break;
            case 33:
                t = "El tipo de Folio IPN es requerido";
                break;
            case 34:
                t = "Error de Red: Fallo al recuperar cadenas originales";
                break;
            case 35:
                t = "Error de Red: Fallo al enviar cadenas firmadas";
                break;
            case 36:
                t = "Error en datos";
                break;
            default:
                t = "Ocurrió una condición no válida";
                break
        }
        if (document.characterSet.toUpperCase() === "ISO-8859-1" || document.characterSet.toUpperCase() === "WINDOWS-1252") {
            var n = decodeURIComponent(escape(t));
            return n;
        } else {
            return t;
        }
    };
    this.clear = function () {
        $("#mensajes").text("");
    };
    this.up = function (p) {
        var r = new RegExp('[\?&]' + p + '=([^&#]*)').exec(window.location.href);
        if (r == null) {
            return null;
        } else {
            return r[1] || 0;
        }
    }
    this.sd = function () {
        var rs = {
            data: {
                uuid: this.id,
                rfc: this.rfc,
                sncert: this.sncrt,
                firma: this.f
            }
        };
        return rs;
    };
};
$(document).ready(function () {
    $("input[name='fileCer']").change(function () {
        lock();
        var c = PKI.IPN.FielUtil.c;
        var n = c('[name="fileCer"]');
        PKI.IPN.FielUtil.ce(n);
        unlock();
    });
    $("input[name='fileKey']").change(function () {
        lock();
        var c = PKI.IPN.FielUtil.c;
        var e = c('[name="fileKey"]');
        var t = c('[name="pwdPrivateKey"]').value;
        var n = c('[name="fileCer"]');
        PKI.IPN.FielUtil.ke(e, t, n);
        unlock();
    });
});
function generaFirmaElectronica(xhr, status, args) {
	console.log("@GeneraFirma INICIO");
	lock();
    var c = PKI.IPN.FielUtil.c;
    var e = c('[name="fileKey"]');
    var t = c('[name="pwdPrivateKey"]').value;
    var n = args.cadenaOriginal;
    var z = args.rfc;
    
    console.log('Inicio: '+PKI.IPN.FielUtil.inicio);
    console.log('Fin: '+PKI.IPN.FielUtil.fin);
    PKI.IPN.FielUtil.vigente = validacion(PKI.IPN.FielUtil.pem);
    if (typeof PKI.IPN.FielUtil.vigente === "undefined" || PKI.IPN.FielUtil.vigente === false) {
    	PKI.IPN.FielUtil.r(27);
        return;
    }
    
    if (new String(PKI.IPN.FielUtil.rfc).valueOf() != new String(args.rfc).valueOf()) {
    	r(29);
        return;
    }
    
    //validarCertificado(PKI.IPN.FielUtil.sncrt,PKI.IPN.FielUtil.pem);
    
    PKI.IPN.FielUtil.fi(e, t, n);
    console.log("@GeneraFirma FIN");
}

function firmarLocalmente() {
	lock();
	
	//PKI.IPN.FielUtil.resultSend = false;
	//var myJson = getCadenas("processId","SessionId");
	var c = PKI.IPN.FielUtil.c;
    var e = c('[name="fileKey"]');
    var t = c('[name="pwdPrivateKey"]').value;
    var n = $("#cadenaUnica").val(); //CADENA UNICA
    var z = $.find('[name="rfcSesion"]')[0].value;// RFC Sesion
    //var tf;//$.find('[name="tipoFolio"]')[0].value;    FOLIO IPN
    
    //console.log("IN -> Cadena Original:"+n);
    //console.log("IN -> Tipo Folio (Nombre Corto UR + Acronimo Sistema Ej. CENAC GD):"+tf);
    console.log("IN -> RFC Usuario en Sesion:"+z);
    console.log('Inicio: '+PKI.IPN.FielUtil.inicio);
    console.log('Fin: '+PKI.IPN.FielUtil.fin);
    
    
    /* FOLIO IPN
     * if(typeof tf === "undefined" || new String("").valueOf() === new String(tf).valueOf()){
		PKI.IPN.FielUtil.r(33);
        return;
    }*/
    
    if (PKI.IPN.FielUtil.vigente === false) {
    	unlock();
    	PKI.IPN.FielUtil.r(27);
        return;
    }
    
    if (new String(PKI.IPN.FielUtil.rfc).valueOf() != new String(z).valueOf()) {
    	unlock();
    	PKI.IPN.FielUtil.r(29);
        return;
    }
    
    PKI.IPN.FielUtil.fi(e, t, n);
    
    
    
}



function getCadenaParaFirmar(n,tf){
	var folio = getFolio(n,tf);
	if(typeof folio === "undefined"){
		return;
    }
	
    var cadenaCFolio = cadenaConFolio(n,folio);
    
    return cadenaCFolio;
}

function getFolio(n,nn){
	var xhr = new XMLHttpRequest();
	var url = "https://api.plataforma.ipn.mx/publico/general/secure/noauth/folio/obtener/save";
	var data = JSON.stringify({"data":{"cadena":n,"type":nn}});//JSON.stringify({"email": "hey@mail.com", "password": "101010"});
	var folio ="";
	xhr.open("POST", url, false);
//	xhr.withCredentials = true;
	xhr.setRequestHeader("Content-type", "application/json");
	xhr.onreadystatechange = function () {
		if (xhr.readyState === 4 && xhr.status === 200) {
	        var json = JSON.parse(xhr.responseText);
	        //console.log(xhr.responseText);
	        //console.log(json.data.folio + ", " + json.data);
	        folio = json.data.folio;
	        
	    }else{
	    	r(30);
	        return;
	    }
	};
	
	/**
	req.open(method, fullurl, true);
    req.setRequestHeader("Authorization", "Basic " + Base64.encode(user + ":" + pass)); 
    req.send(data);
	 */
	//xhr.setRequestHeader("Authorization", "Basic " + "ZGFlZm9saW86c0JkRTNyazdTWWFtSndiOXBkd1FreVg2bVcyS1lCeXo="); 
	xhr.send(data);
	
	/*var x = {
		    "questionCons": [{
		        "string": "In",
		        "alignment": 2
		    }, {"string": "New York State", "alignment": 1}, {
		        "string": "the",
		        "alignment": -1
		    }, {"string": "shortest", "alignment": -1}, {"string": "period", "alignment": 0}, {
		        "string": "of",
		        "alignment": 2
		    }, {"string": "daylight", "alignment": 0}, {
		        "string": "occurs",
		        "alignment": 2
		    }, {"string": "during", "alignment": 1}, {"string": "which", "alignment": 0}, {
		        "string": "month",
		        "alignment": 0
		    }],
		    "options": [{"string": "January", "alignment": 1}, {
		        "string": "December",
		        "alignment": 2
		    }, {"string": "June", "alignment": 1}, {"string": "July", "alignment": 1}]
		};

		console.log(JSON.parse(JSON.stringify(x)));*/
	
//		var myJSON = '{ "name":"John", "age":31, "city":"New York" }';
//		var myObj = JSON.parse(myJSON);
//		console.log(myObj.name);
//		document.getElementById("demo").innerHTML = myObj.name; 
		//console.log("Folio:"+folio);
		return folio;
	
}



function cadenaConFolio(n,fc){
	var tamanio = n.length;
	var ultimosCaracteres = n.substring(tamanio-2, tamanio);
	var cadenaCFolio =n;
//	console.log("Cadena:"+n);
//	console.log("2 Caracteres:"+ultimosCaracteres);
	if(new String("||").valueOf() === new String(ultimosCaracteres).valueOf()){
		cadenaCFolio = n.substring(0,tamanio-2);		
	}else{
		ultimosCaracteres = n.substring(tamanio-1, tamanio);
		if(new String("|").valueOf() === new String(ultimosCaracteres).valueOf()){
			cadenaCFolio = n.substring(0,tamanio-1);
		}
	}
	cadenaCFolio += "|"+fc+"||";
	
	return cadenaCFolio;
}

function validacion(n){
	var xhr = new XMLHttpRequest();
	var url = "https://api.plataforma.ipn.mx/publico/general/secure/noauth/ocsp/verifica";
	var data = JSON.stringify({"data":{"certPem":n}});
	var result =false;	
	
	xhr.open("POST", url, false);
	xhr.setRequestHeader("Content-type", "application/json");
	console.log("1a");
	xhr.onreadystatechange = function () {
	    console.log("REady");
		if (xhr.readyState === 4 && xhr.status === 200) {
	        var json = JSON.parse(xhr.responseText);
	        console.log(xhr.responseText);
	        var code = json.error.code;
	        if(code === 0){
	        	var cStatus = json.data.certStatus;
	        	if(cStatus === "GOOD"){
	        		result = true;
	        	}
	        }
	    }else{
	    	PKI.IPN.FielUtil.vigente =false;
	    	PKI.IPN.FielUtil.r(31);
	        return;
	    }
	};	
	console.log("2a");
	xhr.send(data);
	console.log("3a");
	return result;
}

function lock() {
    block(true);
}
function unlock() {
    setTimeout(function () {
        block(false);
    }, 1000);
}
function block(value) {
    $("#modal").css("display", (value ? "block" : "none"));
}

//1. Get Cadenas Paginadas
function getCadenas(processId,sessionId){
	//lock();
	console.log("getCadenas");
	//console.log("Ini:"+inicio+",fin:"+fin)
	//sesion
	/*
	 {
	 	data:{
	 		cadena:[{"a"},{"b"}]
	 	}
	 }
	*/
	
	var json = "{\"data\":{\"total\":4987,\"cadena\":[]}}";
	var xhr = new XMLHttpRequest();
	var url = "http://148.204.14.23:8081/cadenas";
	var data = JSON.stringify({"data":{"processId":processId},"auth":{"sessionId":sessionId}});
	xhr.open("POST", url, false);
//	xhr.withCredentials = true;
	xhr.setRequestHeader("Content-type", "application/json");
	xhr.onreadystatechange = function () {
		if (xhr.readyState === 4 && xhr.status === 200) {
			console.log("Leyendo respuesta...");
	        json = JSON.parse(xhr.responseText);
	        var code = json.error.code;
	        if(code !== 0){
	        	json = null;
	        }else{
	        	json = xhr.responseText;
	        	//console.log(json);
	        }
	    }else{
	    	console.log("No existe respuesta del server...");
	    	r(34);
	        return null;
	    }
	};
	
	
	xhr.send(data);
	
	
	
	/*if(fin<500){
		json = JSON.parse("{\"data\":{\"total\":4987,\"cadena\":[\"Cadena1\",\"Cadena2\"]}}");
		console.log("Cadena: ->"+json.data.cadena);
	}*/
	//unlock();
	return json;
}
//2. Send Cadenas Paginadas
function sendCadenas(cadenasFirmadas,processId,sessionId,personId){
	//sesion
	console.log("send Cadenas...")
	var json;
	var xhr = new XMLHttpRequest();
	var url = "http://148.204.14.23:8081/cadenas/receive";
	var data = JSON.stringify({"data":{"processId":processId,"personId":personId,"cadenas":cadenasFirmadas},"auth":{"sessionId":sessionId}});
//	console.log("Data to Send: "+data);
	xhr.open("POST", url, false);
//	xhr.withCredentials = true;
	xhr.setRequestHeader("Content-type", "application/json");
	xhr.onreadystatechange = function () {
		if (xhr.readyState === 4 && xhr.status === 200) {
			console.log("Leyendo respuesta...");
			json = JSON.parse(xhr.responseText);
	        var code = json.error.code;
	        if(code !== 0){
	        	json = null;
	        }
	    }else{
	    	console.log("No existe respuesta del server...");
	    	r(35);
	        return null;
	    }
	};
	
	
	xhr.send(data);
	console.log("FIN send Cadenas...")
	return json;
}


function firmaMultiple(c,myJson){
	//lock();
	/***************************/
	if(myJson === null){
		return null;
	}
	
	myJson = JSON.parse(myJson);
	
	
    var contador =0;
    var sizePage = 100;
    
    //var pagina = 1;
    //-- ** Recupera Cadenas Originales ** --
    //var myJson = getCadenas(pagina,pagina+sizePage);
    //pagina = pagina+sizePage;
    
    //console.log(myJson.data.cadena);
    console.log(myJson.data.total);
    
    var total = myJson.data.total;
    var cadenaArray = myJson.data.cadena;
    var firmas = [];
    var l = "";
    
    var cadena;
    var folio;
    var obj;
    //while(cadenaArray.length>0){
    	//genera firmas
    	for(var i = 0; i<cadenaArray.length;i++){
    		cadena = cadenaArray[i].cadena;
    		folio = cadenaArray[i].id;
    		var h = c.signString(cadena, "sha256");
            l = hex2b64(h)
    		console.log("["+contador+"]->"+l);
            obj = {"firma":l,"id":folio};
//            obj = {"firma":l,"id":folio,"url":"https://api.plataforma.ipn.mx/publico/general/secure/noauth/efirma/valida?c="+cadena+"&f="+l+"&nsc="+PKI.IPN.FielUtil.sncrt};
    		firmas.push(obj);
    		contador++;
    		
    		
    		 
    	}
    	//envia firmas
    	console.log("enviando firmas...")
    	
    	//recupera Cadenas
    	/*myJson = getCadenas(pagina,pagina+sizePage-1);
        pagina = pagina+sizePage;
    	cadenaArray = myJson.data.cadena;*/    	
    //}
    
    /*do{
    	
    	
    	var cadenaArray = myJson.data.cadena;
    }while(false);*/
    //Validar Vigencia nuevamente del Certificado
    
    
    
    /***************************/
    //unlock();
    
    return firmas;
}

function lock() {
    console.log("lock");
    block(true);
}
function unlock() {
    console.log("unlock");
    setTimeout(function () {
        block(false);
    }, 1000);
}
function block(value) {    
    $("#modal").css("display", (value ? "block" : "none"));
}
function enviaFirma2(a,b,c,d,e){
	console.log("¡LOCAL! TODO asalazar: Implementa remote commando en xhtml -> Envia firma 2 ....")
}

//function lock(value) {
//    $("#modal").css("display", (value ? "block" : "none"));
////    $("[name='fileCerName']").prop('disabled', value);
////    $("[name='fileCer']").prop('disabled', value);
////    $("[name='fileKeyName']").prop('disabled', value);
////    $("[name='fileKey']").prop('disabled', value);
////    $("[name='pwdPrivateKey']").prop('disabled', value);
////    $("[name='password']").prop('disabled', value);
////    $("[name='rfcEmisor']").prop('disabled', value);
////    $("[name='cadenaUnica']").prop('disabled', value);
////    $("[name='firmaElectronica']").prop('disabled', value);
////    $("[name='firmar']").prop('disabled', value);
//}
