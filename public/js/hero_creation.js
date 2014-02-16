$(document).ready(function() {
	$('.sex').click(function () {
		var sex = $(this).attr('id').split('_')[0];
		$('#sex_field').val(sex);
		$('#sex').hide();
		$('#rasse').show();
	});

	$('.rasse').click(function () {
		var rasse = $(this).attr('id').split('_')[0];
		$('#rasse_field').val(rasse);
		$('#rasse').hide();
		$('#class').show();
	});

	$('.class').click(function () {
		var Class = $(this).attr('id').split('_')[0];
		$('#class_field').val(Class);
		$('#class').hide();
		$('#hero_name').show();
	});

	$('#rasse a').click(function (){
		$('#rasse').hide();
		$('#sex').show();
	});

	$('#class a').click(function (){
		$('#class').hide();
		$('#rasse').show();
	});

	$('#hero_name a').click(function (){
		$('#class').hide();
		$('#rasse').show();
	});
})