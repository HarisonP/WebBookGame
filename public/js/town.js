$(document).ready(function(){
	editHeroEvents.index()	
})


var editHeroEvents = new function(){ 
	var self = this;
	var maxPoints = $('#unused_skill_points').text().match(/\d+/)
	this.index = function(){
		self.inputFiledEvents();
		self.editHeroWizard();
		self.changeSaver();
		self.updateNavBar();
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
			var stats = {}
			var offensiveMagicPoints ={};
			var defenciveMagicPoints = {};
			$('.statsUpdates input').each(function(){
				stats[$(this).attr('name')] = $(this).val();
			});

			$('.offensive_input').each(function(){
				offensiveMagicPoints[$(this).attr('id')] = $(this).val();
			});

			$('.defencive_input').each(function(){
				defenciveMagicPoints[$(this).attr('id')] = $(this).val();
			});

			$.ajax({
				type: "PUT",
				url: "/update-hero",
				data: {stats: stats, offensive: offensiveMagicPoints, defencive: defenciveMagicPoints},
				success: function(response){	
					respnse;
				}
			});
		});
	}

	this.updateNavBar = function(){
		$('#udateNavigator li').click(function(){
			$('#udateNavigator li').removeClass('active')
			$(this).addClass('active');
			var showTarget = $(this).attr('data-for');
			$('.offensive, .defencive, .statsUpdates').hide();
			$(showTarget).show();
			
		});
	}
}


