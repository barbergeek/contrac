// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

//$(function() {
//	$("ul.css-tabs").tabs();
//});

// jQuery-UI style buttons
$(function() {
	$( "button, input:submit" ).button();
	$('#tabs').tabs();
	$('.menu').wijmenu();
	$(".menu").wijmenu("option", "crumbDefaultText", "Choose an option")
});

//$(function() {
//	$( "button, input:submit" ).button();
//	$('#tabs').tabs({
//	    select: function(event, ui) {
//	        var url = $.data(ui.tab, 'load.tabs');
//	        if( url ) {
//	            location.href = url;
//	            return false;
//	        }
//	        return true;
//	    }
//	});
//});

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
