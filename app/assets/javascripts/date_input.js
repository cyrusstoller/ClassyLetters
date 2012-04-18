$(function() {
	$(".date_input").change( function(){
		$(this).val(Date.parse($(this).val()).toString().substring(4,15));
	});
	
	$(".make_upcase").change( function(){
		$(this).val($(this).val().toUpperCase());
	});
});