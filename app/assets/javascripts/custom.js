$(document).ready(function(){
	$('.aside-toggle').click(function(){
		$(this).toggleClass('animate');
		$('.side-wrapper').toggleClass('active');
    $('.page-overlay').toggle();
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

  $('[data-toggle="tooltip"]').tooltip({
     container: 'body'
  });

  $('.dropdown-menu').click(function(e) {
      e.stopPropagation();
  });

});

$(function(){
 $('body').on('click', '.btn-remove', function () {
      $(this).parents('.search-item').remove();
    });
}); 

function call_selec (){
  $('.selecter').selecter();
}