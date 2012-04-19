$(function(){
  set_char_limit();
  $("#lettre_order_message").keyup(set_char_limit);
});

function set_char_limit(){
	var current_value = $("#lettre_order_message").val();
	var current_length;
	if (current_value == undefined) {
		current_length = 0;
	}
	else{
		current_length = current_value.length;	
	}
	
  var diff_length = 500 - current_length;
  var overage_fee = " You will be charged $0.05/character over the limit.";
  var base_rate = "Base rate includes ";
  if (diff_length < 0) {
    if (diff_length == -1){
      $("#message_char_count").html(
        'You have gone <span class=\"red\">1 character</span> over the limit. You will be charged an extra $0.05.'
      );
    }
    else{
      $("#message_char_count").html(
        'You have gone <span class=\"red\">' + Math.abs(diff_length) + ' characters</span> over the limit. You will be charged an extra $' + (Math.round(Math.abs(diff_length)* 5)/100).toFixed(2) + '.'
      );
    }
  }else{
    if (diff_length == 1){
      $("#message_char_count").html(base_rate + "1 more character." + overage_fee);
    }
    else{
      $("#message_char_count").html(base_rate + diff_length + " more characters." + overage_fee);
    }
  }
};