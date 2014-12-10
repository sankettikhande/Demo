$(document).ready(function(){
	$('.aside-toggle').click(function(){
		$(this).toggleClass('animate');
		$('.side-wrapper').toggleClass('active');
	});
	$('#search-more-btn').click(function(){
		$($('.search-list .search-row').first().html()).clone().insertAfter(".search-row");
	});

    $('#forgot-link').click(function(){
        $('.login-form').addClass('hidden');
        $('.forgot-form').removeClass('hidden');
    });

    $('#login-link').click( function(){
        $('#login-modal').modal('show');
    });

    $('#login-modal').on("hidden.bs.modal", function(){
        $('.forgot-form').addClass('hidden');
        $('.login-form').removeClass('hidden');
    });

	$('.selecter').selecter();

    $('.date').datepicker({
        format: 'yyyy/mm/dd'
    });

});