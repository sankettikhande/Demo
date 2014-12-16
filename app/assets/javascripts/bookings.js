
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
    })
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
    })

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
    })    
  }