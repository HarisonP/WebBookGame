$(document).ready(function (){
	
	$('.deleter').click(function () {
		var self  = this
		var heroForDeletion = $(this).parents('.hero_container')
		$.ajax({
			type: "DELETE",
			url: "/delete-hero",
			data: {hero_for_deletion: heroForDeletion.attr('id')},
			success: function(response){
				if(response == 'success')
					heroForDeletion.remove();
			}
		})
	});

	$('.chooser').click(function () {
		var self  = this
		var chosenHeroId = $(this).parents('.hero_container').attr('id')
		window.location.href = '/hero-chosen/' + chosenHeroId
	});
});