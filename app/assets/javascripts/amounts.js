$(document).ready(function(){
  $('.sum').dblclick(function(evt){
    evt.stopImmediatePropagation();

    var sum = $(this).text();
    sum = sum.replace('€', '').trim();

    $(this).html('<input class="change_sum" type="text" value="' + sum + '">');

  });

  $('td').on('keypress', '.change_sum', function(evt){
    if (evt.which == 13) {
      $(this).blur();
    }
  });

  $('td').on('focusout', '.change_sum', function(evt){
    evt.stopImmediatePropagation();
    console.log('focusout');
    var sum = $(this).val();
    if ($.isNumeric(sum)) {
      $(this).parent().html(sum + ' €');
    }
    recalculateTotal();
  });
});

function recalculateTotal() {
  var total = 0.0;
  $('td.sum').each(function( index ) {
    var sum = $(this).text();
    sum = sum.replace('€', '').trim();
    if ($.isNumeric(sum)) {
      total += parseFloat(sum);
    }
  });
  $('strong.total').html(total.toFixed(2) + ' €');
}
