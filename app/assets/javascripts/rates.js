$(document).ready(function(){
  $('.rview-rating').raty({ 
    score: function() {
            return $(this).attr('rate_count');
          },
    half: true,
    path: '/assets/',
    readOnly: true,
    hints : ['', '', '', '', '']
  });

  $('body').on('click', '.closed-review' , function ( evt ){
    $(this).removeClass('closed-review');
    var seller_id = $(this).attr('seller_id'),
        freight_id = $(this).attr('freight_id'),
        url = '/reviews/'+seller_id+'?freight_id='+freight_id;
    $.get( url );
  });
});