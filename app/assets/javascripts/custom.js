$(document).ready(function(){
	$('.aside-toggle').click(function(){
		$(this).toggleClass('animate');
		$('.side-wrapper').toggleClass('active');
	});
	$('#search-more-btn').click(function(){
		$($('.search-list .search-row').first().html()).clone().insertAfter(".search-row");
	});
	$('#forgot-link').click(function(){
		$('.login-form').toggleClass('forgot-form');
	});
	$('.datepicker,.input-group.date').datepicker();
	$('[data-toggle="tooltip"]').tooltip();
	$('.selecter').selecter();
});