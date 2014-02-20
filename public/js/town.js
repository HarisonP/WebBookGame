$(document).ready(function(){
	editHeroEvents.index()	
})


var editHeroEvents = new function(){ 
	var self = this;
	var maxPoints = $('#unused_skill_points').text().match(/\d+/)
	this.index = function(){
		self.inputFiledEvents();
		self.editHeroWizard();
		this.changeSaver();
	}

	this.inputFiledEvents = function(){
		$('input[type="number"]').change(function(){
		});
	}

	this.editHeroWizard = function(){
		$('#edit_hero').click(function(){
			$('.heroView').hide();
			$('.editView').show();
		});
		$('#back_to_hero_view').click(function(){
			$('.editView').hide();
			$('.heroView').show();
		});
	}

	this.changeSaver = function(){
		$('#change_saver').click(function () {
			var self1  = this
			var info = {}
			$('.editView input').each(function(){
				info[$(this).attr('id')] = $(this).val();
			});
			$.ajax({
				type: "PUT",
				url: "/update-hero",
				data: {stats: info},
				success: function(response){
					console.log(response)
				}
			});
		});
	}
}


