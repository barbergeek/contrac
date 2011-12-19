// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

// jQuery-UI style buttons
$(function() {
	$( "button, input:submit" ).button();
	$('#tabs').tabs();
	$('#menu').tabs();
//	$('.menu').wijmenu();
//	$(".menu").wijmenu("option", "crumbDefaultText", "Choose an option");
	$(".datepicker").datepicker({ dateFormat: 'yy-mm-dd', showOn: 'focus' });
	$(".accordion-collapsible").accordion({ collapsible: true, alwaysOpen: false, active: false });
	$(".dashboard").sortable({
		connectWith: ".dashboard"
	});
	$( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
		.find( ".portlet-header" )
			.addClass( "ui-widget-header ui-corner-all" )
			.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
			.end()
		.find( ".portlet-content" );

	$( ".portlet-header .ui-icon" ).click(function() {
		$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
		$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
	});

	$( ".dashboard" ).disableSelection();
	
	
	$( "#radio" ).buttonset();
	$("#calendar_order_by input:radio").click(function() {
	      $("#calendar_order_by").submit();      
	});

//	$(".ui-icon").hover(
//		function(){ 
//			$(this).addClass("ui-state-hover"); 
//		},
//		function(){ 
//			$(this).removeClass("ui-state-hover"); 
//		}
//	);
	
});

$(document).ready(function() {
	var $dialog = $('<div id="dialog-modal"></div>')
		.html('This dialog will show every time!')
		.dialog({
			modal: true,
			autoOpen: false,
			title: 'Basic Dialog',
			buttons: {
				Ok: function() {
					$( this ).dialog( "close" );
				}
			}
		});
});

