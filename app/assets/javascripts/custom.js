$(document).ready(function(){
	$('.aside-toggle').click(function(){
		$(this).toggleClass('animate');
		$('.side-wrapper').toggleClass('active');
	});

	$('body').on('click', '#search-more-btn', function(){
		$($('.search-list .search-row').first().html()).clone().insertAfter(".search-row");
    $('.selecter').selecter();
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

  $('[data-toggle="tooltip"]').tooltip({
     container: 'body'
  });

  $('.dropdown-menu').click(function(e) {
      e.stopPropagation();
  });


  $('.btn-del').click(function(){
     $(this).parents('.loc-item').fadeOut( "slow", function() {
         $(this).parents('.loc-item').remove();
     });
  });

  $('.rview-rating').raty({ 
    score: 3,
    half: true,
    starHalf:'assets/star-half.png',
    starOff:'assets/star-off.png',
    starOn:'assets/star-on.png'
  });

});

$(function(){
 $('body').on('click', '.btn-remove', function () {
      $(this).parents('.search-item').remove();
    });
}); 