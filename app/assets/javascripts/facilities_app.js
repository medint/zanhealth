/* Global Variables */




//window resizing


$(document).ready(function() {
	/* define variables */

	/* left-nav things*/
	// $('.left-nav_ul_li')
	// 	.mouseover(function(){
	// 		$('.left-nav_ul_li').css('background-color', "#2a7368");
	// 	})
	// 	.mouseout(function(){
	// 		$('.left-nav_ul_li').css('background-color', "#77ccbf");
	// 	});
	
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




function window_resize_handler(){
	var window_width = window.outerWidth;
	var window_height = window.outerHeight;
	
	var mid_summary = document.getElementById("mid-summary");
	var right_detail = document.getElementById("right-detail");

	/* width */
	mid_summary.style.width = ((window_width-240)/2)-1;
	right_detail.style.width = ((window_width-240)/2)-1;


	$('.mid-summary_ul_li').css("width", (((window_width-240)/2)-1));
	$('.mid-summary_ul_li_hr').css("width", (((window_width-240)/2)-1));
};