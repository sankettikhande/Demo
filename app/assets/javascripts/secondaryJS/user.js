$(document).ready(function(){

    $('.edit_user_info').click(function(){
        $('.user_information').removeAttr('disabled');
        $('#user_info_action').show()
    })

    $('.edit_user_contact').click(function(){
        $('.user_contact_information').removeAttr('disabled');
        $('#user_contact_action').show()
    })
})

function cancel_edit_user_info(){
    $('.user_information').attr( "disabled", "disabled" );
    $('#user_info_action').hide();
    return false
}

function cancel_edit_user_contact_info(){
    $('.user_contact_information').attr( "disabled", "disabled" );
    $('#user_contact_action').hide();
    return false
}

function update_user_informations(){
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var comp_name = $('#company_name').val();
    var comp_reg = $('#company_registration_number').val();
    var add1 = $('#address_line_1').val();
    var add2 = $('#address_line_2').val();
    var add3 = $('#address_line_3').val();
    var post_code = $('#post_code').val();
    var currency = $('#preferred_currency').val();
    $.ajax({
        type: 'PUT',
        url: '/users/update_user_information/',
        data: {user_information:true,first_name: first_name,last_name: last_name, comp_name: comp_name,comp_reg :comp_reg, add1: add1,add2: add2,add3: add3,post_code: post_code,currency: currency},
        success: function(data){
            $('.user_information').attr( "disabled", "disabled" );
        }
    })
    return false;
}

function update_user_contact_informations(){
    var email = $('#email').val();
    $.ajax({
        type: 'PUT',
        url: '/users/update_user_information/',
        data: {email: email},
        success: function(data){
            $('.user_contact_information').attr( "disabled", "disabled" );
        }
    })
    return false;
}