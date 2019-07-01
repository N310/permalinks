$(function() {
  $('input[type=submit]').on('click', function(){
    $('.alert').hide();
    $(this).hide();
    $('.spinner-geturl').show();
  });
});
