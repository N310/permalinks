$(function() {
  $('input[type=submit]').on('click', function(){
    $('#js-validation').hide();
    $(this).hide();
    $('.spinner-geturl').show();
  });

  $('.js-copy').on('click', function(){
    let urls = $(this).parent().find('.js-urltext');
    let $clipboard = $('<textarea></textarea>');
    let text = "";

    $.each(urls, function(index, url) { text += $(url).text() + '\n'; });
    $clipboard.text(text);
    $(this).append($clipboard);
    $clipboard.select();
    document.execCommand('copy');
    $clipboard.remove();
    $('.js-copied').show().delay(2000).fadeOut(500);
  });
});
