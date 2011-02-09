// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

// jQuery-UI style buttons
$(function() {
	$( "button, input:submit" ).button();
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

// Enable tabs
//  $(function() {
//  	$( "#tabs" ).tabs({
//  		ajaxOptions: {
//  			error: function( xhr, status, index, anchor ) {
//  				$( anchor.hash ).html(
//  					"Couldn't load this tab. We'll try to fix this as soon as possible. " +
//  					"If this wouldn't be a demo." );
//  			}
//  		}ß
//  	});
//  });

//$('#example').tabs({
//    select: function(event, ui) {
//        var url = $.data(ui.tab, 'load.tabs');
//        if( url ) {
//            location.href = url;
//            return false;
//        }
//        return true;
//    }
//});