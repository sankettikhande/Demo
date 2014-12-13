$(document).ready(function(){
	$('.aside-toggle').click(function(){
		$(this).toggleClass('animate');
		$('.side-wrapper').toggleClass('active');
	});

	$('body').on('click', '#search-more-btn', function(){
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

  // $('.date').datepicker({
  //     format: 'yyyy/mm/dd'
  // });

  $('[data-toggle="tooltip"]').tooltip({
     container: 'body'
  });

  $(function(){
   $('body').on('click', '.btn-remove', function () {
        $(this).parents('.search-item').remove();
      });
  }); 

  $('.btn-del').click(function(){
     $(this).parents('.loc-item').fadeOut( "slow", function() {
         $(this).parents('.loc-item').remove();
     });
  });

});