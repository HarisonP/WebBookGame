$(document).ready(function (){
	
	$('.deleter').click(function () {
		var self  = this
		var heroForDeletion = $(this).parents('.hero_container')
		$.ajax({
			type: "POST",
			url: "/delete-hero",
			data: {hero_for_deletion: heroForDeletion.attr('id')},
			success: function(response){
				if(response == 'success')
					heroForDeletion.remove();
			}
		})
	});



});