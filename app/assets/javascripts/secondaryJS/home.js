$(document).ready(function(){
  $('ul.freight-type li').click(function(e){
    freight_type = e.target.innerHTML;
    $('#landing_tab_freight_type').val(freight_type.toLowerCase());
  });

  $(function() {
    $(".source-auto-complete" ).combobox();
    $(".destination-auto-complete" ).combobox();
  });	
});