// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery
//= require rails-ujs
//= require filterrific/filterrific-jquery
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function(){

		// Envia el foco a la opciÃ³n del menu seleccionada
		$("#menu-manual a").on('click', function(event) {
		  if (this.hash !== "") {
		    event.preventDefault();
		    var hash = this.hash;
		    $('html, body').animate({
		      scrollTop: $(hash).offset().top
		    }, 800, function(){
		    	window.location.hash = hash;
		    });
		  }
		});




	// Modifica el encabezado cuando hace scroll
	$(window).scroll(function() {

		if( $(this).scrollTop() > 179 ) {

			// Muestra el botÃ³n para regresar arriba
			$('#top-contenedor').slideDown('slow');

			$('#menu-principal').addClass( 'fixed-top' );
			// $('#menu-principal').css( {
      			// "background": "rgba( 104 , 36 , 68 , .98 )"
    		// });
			// $('#menu-principal .nav-item.active , #menu-principal .navbar-nav .nav-link:hover')
			// .css( 'background' , 'rgba( 91 , 41 , 49 , .98 )' );

			// Fija el menu de utilerias al hacer scroll
			// $('#menu-utilerias').addClass( 'fixed-top' );
			// $('#menu-utilerias').addClass( 'movil' );

			/* Fija el menu manual */
			$('#menu-manual').addClass( 'fixed-top' );
			$('#menu-manual').addClass( 'fixed-top-menuManual' );
			// $('#menu-manual').css( {
      			// "background": "rgba( 93 , 39 , 47 , .98 )",
      			// "background": "rgba( 104 , 36 , 68 , .98 )",
    		// });

    		/* Fija el titulo de la escuela */
    		$('.nombreEscuela-contenedor').addClass( 'fixed-top' );

    		/* Agregar y coultar los botones de accesibilidad*/
    		$('#contenedorAccesibilidad-scroll').removeClass( 'u-oculto' );

    		/* Comprueba si existe el menu manual para ajustar la altura del margen y la posiciÃ³n de la franja del nombre de la escuea */
    		if ( $("#menu-manual").length > 0 ) {
    			$('.nombreEscuela-contenedor').addClass( 'fixed-top-tituloEscuela' );
    		} else {
    			$('.nombreEscuela-contenedor').addClass( 'fixed-top-menuManual' );
    		}

		} else {

			// Oculta el botÃ³n para regresar arriba
			$('#top-contenedor').slideUp('slow');

			/* Regresa el menu principal a su posiciÃ³n original */
			$('#menu-principal').removeClass('fixed-top');
			$('#menu-principal').css( {
      			// "background": "rgb( 93 , 39 , 47)",
      			"background": "rgba( 104 , 36 , 68 , .98 )",
    		});
			// $('#menu-principal .nav-item.active , #menu-principal .navbar-nav .nav-link:hover')
			// .css( 'background' , 'rgb( 55 , 28 , 32)' );


			/* Regresa el menu manual a su posiciÃ³n original */
			$('#menu-manual').removeClass('fixed-top');
			$('#menu-manual').removeClass( 'fixed-top-menuManual' );
			// $('#menu-manual').css( 'background' , 'rgb( 104 , 36 , 68)' );
			/* $('#menu-manual')
			.css( 'background-image' , 'linear-gradient(transparent 3px, rgba( 51 , 51 , 51 , .9 ) 3px)' ); */

			// Ajusta el menu de utilerias si no hay scroll
			$('#menu-utilerias').removeClass('fixed-top');
			$('#menu-utilerias').removeClass('movil');

			/* Regresa el nombre de escuela a su posiciÃ³n original*/
			$('.nombreEscuela-contenedor').removeClass('fixed-top');

			/* Agrega y oculta los botones de accesibilidad*/
    		$('#contenedorAccesibilidad-scroll').addClass( 'u-oculto' );


		}
	});

	// Disminuir Aumentar el tamaÃ±o de la letra
 	$(".reduceLetra").click(function(){

 		$('.aumentaLetra').removeClass('deshabiltar');

 		var donde = $('html');
 		var sizeFuenteActual = donde.css('font-size');
 		var sizeFuente = sizeFuenteActual.replace("px", "");

 		if (sizeFuente < 16 ) {
 			$('.reduceLetra').addClass('deshabiltar');
 		}
 		else {
 			$('.reduceLetra').removeClass('deshabiltar');
 		}

	 	var sizeFuenteActualNum = parseFloat(sizeFuenteActual, 10);
	    var sizeFuenteNuevo = sizeFuenteActualNum-2;
		donde.css('font-size', sizeFuenteNuevo);
		return false;

  	});

	// Resetear Aumentar el tamaÃ±o de la letra
  	$(".resetLetra").click(function(){

  		var donde = $('html');

  		donde.css('font-size', '16px');
  		$('.aumentaLetra').removeClass('deshabiltar');
  		$('.reduceLetra').removeClass('deshabiltar');

  	});

    // Agrega collapse a los elementos del menu manual en moviles para que al seleccionrlos se contraiga el menu
    if ( $( document ).width() > 1199 ) {
    	// alert("grande");
    	$('#menu-manual a').removeAttr( "data-toggle", "collapse" );
    	$('#menu-manual a').removeAttr( "data-target", "#navbarMenuManual" );
    	// Menu de mapas
    	$('#menu-mapas a').removeAttr( "data-toggle", "collapse" );
    	$('#menu-mapas a').removeAttr( "data-target", "#navbarMapas" );
    } else {
    	$('#menu-manual a').attr( "data-toggle", "collapse" );
    	$('#menu-manual a').attr( "data-target", "#navbarMenuManual" );
    	// Menu de mapas
    	$('#menu-mapas a').attr( "data-toggle", "collapse" );
    	$('#menu-mapas a').attr( "data-target", "#navbarMapas" );
    }

	})
