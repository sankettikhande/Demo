$(document).ready(function() {
  $('#price-range').val($("#price-range-txt").val());
  $('#transit-time').val($("#transit-time-txt").val());

  $("#price-range").on('input', function(){
    $('#price-range-txt').val($("#price-range").val());
  });

  $("#price-range-txt").on('blur', function(){
    $('#price-range').val($("#price-range-txt").val());
  });

  $("#transit-time").on('input', function(){
    $('#transit-time-txt').val($("#transit-time").val());
  });

  $("#transit-time-txt").on('blur', function(){
    $('#transit-time').val($("#transit-time-txt").val());
  });   

  $(".seller-chk").click(function() {
    booking_id = $('#booking_id').val();
    $.ajax({
      type: "POST",
      data: $('input[name="filter[seller_ids][]"]:checked').serialize(),
      url:"/bookings/filter_with_seller?id="+ booking_id,
      success: function(data){
        $('.searched-freight').html(data);
        bind_raty();     
      },
      error: function(data){
        alert("something went wrong");
      }
    });
  });

  $('#filter_length,#filter_height,#filter_width,#filter_weight').change(function(){
    update_filters();
  });
  
  $('#filter_date').datepicker({
      format: 'dd/mm/yyyy',
      multidate: false,
      toggleActive: false,
      autoclose: true,
      startDate: '1d'
    }).on('changeDate', function(e){
      update_filters();
    });
});

function update_filters(){
   var booking_id = $('#searched_booking').attr('search_booking_id'),
      filterFields = ["length","width", "height", "weight"],
      booking = {},
      booking_params = {},
      filter_params = {};

    $.each(filterFields,function(index,field){
      var value = $("#filter_"+field).val();
      if(!isNaN(value)){
        booking[field] = value;
      }
    });

    booking.pick_up_date = $('#filter_date').val();
    booking_params = {booking: booking};

    $('#freights-filters [name]').each(function(){
      if (this.value !==""){
        filter_params[this.name] = this.value;  
      }
    });

  $.ajax({
    type: "PUT",
    data: $.extend(booking_params, filter_params),
    url:"/bookings/"+booking_id+"/update_search_filters",
    success: function(data){
      $('.searched-freight').html(data);
      bind_raty();
    },
    error: function(data){
      alert("something went wrong");
    }
  });
}


function add_to_cart(booking_id, freight_id){
  $.ajax({
    type: "POST",
    data: {freight_id: freight_id},
    url:"/bookings/"+booking_id+"/add_to_cart",
    success: function(data){
      $('.selected').hide();
      $('.select').show();
      $('#'+'freight_'+freight_id).hide();
      $('#'+'selected_freight_'+freight_id).show();
      update_cart_detail_section();       
    },
    error: function(data){
      alert("something went wrong");
    }
  });
}

function remove_from_cart(booking_id, freight_id){
  $.ajax({
    type: "POST",
    data: {freight_id: freight_id},
    url:"/bookings/"+booking_id+"/remove_from_cart",
    success: function(data){
      $('#'+'selected_freight_'+freight_id).hide();
      $('#'+'freight_'+freight_id).show();
      update_cart_detail_section();
    },
    error: function(data){
      alert("something went wrong");
    }
  });

}

function update_cart_detail_section(){
  $.ajax({
    type: "GET",
    url:"/bookings/update_cart_details_section",
    success: function(data){
      $('.cart_detail').html(data);
    },
    error: function(data){
      alert("something went wrong");
    }
  });   
}

function remove_booking(booking_id, del_el){
  $.ajax({
    type: "GET",
    url:"/bookings/"+booking_id+"/remove_from_search",
    success: function(data){
      $(del_el).parents('.loc-item').fadeOut( "slow", function() {
       $(this).parents('.loc-item').remove();
      });
      update_cart_detail_section();
    },
    error: function(data){
      alert("something went wrong");
    }
  });  
}

function triggerClickEvent(booking_id, freight_id){
  $('button#freight_'+freight_id).trigger('click');
}

function check_cart(redirect_url) {
  $.ajax({
    type: "GET",
    url: "/bookings/check_cart_session",
    statusCode: {
        202: function () {
            alert('Nothing in the cart');
            return;
        },
        200: function () {
            window.location.href = redirect_url;
        }
    },
    error: function (data) {
        alert("something went wrong");
    }
  });
}

function update_booking_status(id,status,remark) {
  $.ajax({
      type: "POST",
      url: "/bookings/update_booking_status/",
      data: {booking_id: id, order_status: status,remark: remark},
      success: function () {
        $("#status_field_"+id).html(status);
        $("#remark_field_"+id).html(remark);
      }
  });
}

function download_csv(booking_id){
  $.ajax({
      type: "GET",
      url: "/bookings/"+booking_id+"/search_result_download_to_csv.csv",
      success: function (data) {
        window.open( "data:text/csv;charset=utf-8," + escape(data)); 
      }
  });
}

function filter_booking_with_discount(booking_id){
    $.ajax({
        type: "GET",
        url: "/bookings/booking_with_discount/",
        data: {booking_id :booking_id},
        success: function (data) {

        }
    });
}

