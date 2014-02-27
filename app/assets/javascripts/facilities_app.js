/* Global Variables */




//window resizing

if (window.location.toString().match(/facility_work_orders/)) {
	$(document).ready(function() {
		/* define variables */
		
		/* window resizing */

		window_resize_handler();

		if(window.attachEvent) {
		window.attachEvent('onresize', window_resize_handler);
		}else if(window.addEventListener) {
		    window.addEventListener('resize', window_resize_handler, true);
		}else {
		    //The browser does not support Javascript event binding
		}
	});
}



function window_resize_handler(){
	var window_width = window.outerWidth;
	var window_height = window.outerHeight;
	
	var mid_summary = document.getElementById("mid-summary");
	var right_detail = document.getElementById("right-detail");

	/* width */
	mid_summary.style.width = ((window_width-240)/2)-5;
	right_detail.style.width = ((window_width-240)/2)-5;
	mid_summary.style.height = window_height-135;
	right_detail.style.height = window_height-135;

	$('.mid-summary_ul_li').css("width", (((window_width-240)/2)-1));
	$('.mid-summary_ul_li_hr').css("width", (((window_width-240)/2)-1));
};

function edit_button_handler(){
	var object_view = document.getElementById("object-view");
	var object_form = document.getElementById("object-form");
	if (object_form.style.display === "none"){
		object_view.style.display="none";
		object_form.style.display="inline";
	}else{
		object_view.style.display="inline";
		object_form.style.display="none";
	}
}
