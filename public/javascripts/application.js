$(function(){
  var $ch_left = $('#characters_left');
  console.log($ch_left.length > 0)
  if ($ch_left.length > 0)
  {
    var max_limit = parseInt($ch_left.attr('class').split('-')[1], 10);
    $ch_left.parents('form').find('textarea').keydown(function(event){
      var curr_size = parseInt($(this).val().length, 10),
          diff = max_limit - curr_size;
      if (diff < 256 && diff > 0)
      {
        $ch_left.html(max_limit - curr_size).css('color', 'rgb(' + diff + ',' + diff + ',' + diff + ')');
      } else {
        $ch_left.html('').css('color', 'white')
      }
    });
  }
});
