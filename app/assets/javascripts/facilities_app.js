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

$(document).ready(function() {

	$("#cbox0").prop("checked",true)
	$("#cbox1").prop("checked",true)
	$("#cbox2").prop("checked",true)

	addListenerToBox(document.getElementById("cbox0"))
	addListenerToBox(document.getElementById("cbox1"))
	addListenerToBox(document.getElementById("cbox2"))


});

function addListenerToBox(checkB){
	if(checkB.attachEvent) {
		(checkB).attachEvent('onchange', checkbox_filter_handler);
	}else if(checkB.addEventListener) {
		(checkB).addEventListener('change', checkbox_filter_handler, true);
	}
}

function checkbox_filter_handler(){
	if ($("#cbox0").prop("checked")==false){
		$(".status-0").parent().hide()
	}else{
		$(".status-0").parent().show()
	}
	if ($("#cbox1").prop("checked")==false){
		$(".status-1").parent().hide()
	}else{
		$(".status-1").parent().show()
	}
	if ($("#cbox2").prop("checked")==false){
		$(".status-2").parent().hide()
	}else{
		$(".status-2").parent().show()
	}

};

function sort_by_date_created(){
	var list_to_sort = document.getElementById("mid-summary_ul").getElementsByTagName("li");

};

function sort_by_status(){
	var list_to_sort = document.getElementById("mid-summary_ul").getElementsByTagName("li");
	var nodeArray = [];
	var s = 0
	for (var x = 0; x < 3; x++){
		for (var i = 0; i < list_to_sort.length; i++) {
			if (list_to_sort[i].childNodes[1].classList[0]== "status-"+x) {
    			nodeArray[s] = list_to_sort[i].cloneNode(true);
    			s++
    		}
		}
	}

	for (var i = 0; i < nodeArray.length; i++){
		if (list_to_sort[i] != null) {
			list_to_sort[i].parentNode.replaceChild(nodeArray[i], list_to_sort[i]);
		}
	}
	console.log(list_to_sort);
	console.log(nodeArray);
};

$(document).ready(function() {
   $('.dropdown-menu').on('click', function(e) {
       if($(this).hasClass('dropdown-menu-form')) {
           e.stopPropagation();
       }
   });
});

