$(function() {
	$(".date_input").change( function(){
		$(this).val(Date.parse($(this).val()).toString().substring(4,15));
	});
});