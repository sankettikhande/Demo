
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
      },
      error: function(data){
        alert("something went wrong");
      }
    })

  }
