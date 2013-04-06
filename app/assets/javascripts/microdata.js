$(function () {
  var show_microdata_html = '<a href="#" id="show_microdata">Show Microdata</a>';
  var hide_microdata_html = '<a href="#" id="hide_microdata">Hide Microdata</a>';
  $('#page_results pre').hide();
  $('#page_results').before(show_microdata_html);
  $('body').on('click', '#show_microdata', function(){
    $('#show_microdata').remove();
    $('#page_results pre').show();
    $('#page_results').before(hide_microdata_html);
  });
  $('body').on('click', '#hide_microdata', function(){
    console.log('here');
    $('#hide_microdata').remove();
    $('#page_results pre').hide();
    $('#page_results').before(show_microdata_html);    
  });

});