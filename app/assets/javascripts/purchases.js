$(function() {
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
	$('#new_purchase').submit(function(){
		$('input[type=submit]').attr('disabled', 'disabled');
		var card = {
			number:   $('#card_number').val(),
			cvc:      $('#card_code').val(),
			expMonth: $('#card_month').val(),
			expYear:  $('#card_year').val()
		};		
		Stripe.createToken(card, function(status, response) {			
			if (response.error) {
				// show the errors on the form
				$(".payment-errors").text(response.error.message);
				$('input[type=submit]').attr('disabled', false);
				alert(response.error.message);
			} else {
				var form$ = $("#new_purchase");
				// token contains id, last4, and card type
				var token = response['id'];
				// insert the token into the form so it gets submitted to the server
				// form$.append("<input type='hidden' name='stripe_card_token' value='" + token + "'/>");
				$("#stripe_card_token").val(token);
				// and submit
				form$[0].submit();
			}
		});
		return false;
	});
});