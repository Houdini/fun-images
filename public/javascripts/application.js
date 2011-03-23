$(function(){

    var $ch_left = $('#characters_left');
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

    $('div.i-like a').bind('ajax:success', function(data, status, xhr){
      if (status.error === 'sign_up')
      {
          var dialog = $('<div class="dialog-box"></div>');
          dialog.appendTo('body');

          $.cookie('do', $(this).attr('href'));

          var   mask_height = $(document).height(),
                mask_width = $(window).width(),
                dialogTop =  (mask_height/3) - ($('#dialog_overlay .dialog-box').height()),
                dialogLeft = (mask_width/2) - ($('#ddialog_overlay .dialog-box').width()/2);

          dialog.css({top: dialogTop, left: dialogLeft}).show();
          dialog.html('<div class="dialog-content">' + status.form + '</div>');
      }
    });

    $('dt').live('click', function(){
        $(this).siblings().removeClass('selected').end().next('dd').andSelf().addClass('selected');
    });

//    $('ul.auth-way li .title').live('click', function(event){
//        event.preventDefault();
//        $(this).parents('li').addClass('active').siblings().removeClass('active');
//    });

    $('.i-like a').bind('ajax:success', function(data, status, xhr){
        var $this = $(this),
            comment = $this.parent();
        if (status.status === 'ok' && status.like === '1')
        {
            var old_href = $this.attr('href'),
                new_a_href = old_href.substring(0, old_href.length - "i_like".length) + 'dont_like';
            $this.attr('href', new_a_href).html(tg.dont_like).addClass('like').removeClass('dont-like');
            $.gritter.add({
                title: tg['notice.thanks'],
                sticky: false,
                text: Mustache.to_html(tg['notice.thanks_for_comment'], {nick: $this.parents('.comment').find('.nick a').html()}),
                image: '/images/gritter/success.png'
            });
        }

        if (status.status === 'ok' && status.like === '0')
        {
            var old_href = $this.attr('href'),
                new_a_href = old_href.substring(0, old_href.length - "dont_like".length) + 'i_like';
            $this.attr('href', new_a_href).html(tg.like).addClass('dont-like').removeClass('like');
            $.gritter.add({
                title: tg['notice.dislike_thanks'],
                sticky: false,
                text: Mustache.to_html(tg['notice.dislike_comment'], {nick: $this.parents('.comment').find('.nick a').html()})
            });
        }
    });

    $('form#new_comment').bind('ajax:success', function(data, responce, xhr){
        var $this = $(this);
        if (responce.status === 'ok')
        {
            $this.hide();
            var comment_content = $(tg.comment_content);
            comment_content.find('.body').html(responce.body);
            comment_content.find('.time-passed abbr').html(tg.just_now).attr('title', new Date());
            comment_content.find('.nick a').html($('#nick').html());
            $('.comments').prepend(comment_content);
            $this.parent().prepend($('<h1>' + tg.save_comment_successfully + '</h1>'));
        }

        if (responce.status === 'error')
        {
            var errors = '<ul class="errors">', i;
            for (i = 0; i < responce.errors.body.length; i += 1)
                errors += '<li>' + responce.errors.body[i] + '</li>';
            errors += '</ul>';
            $.gritter.add({
                title: tg.errors,
                sticky: true,
                text: errors,
                image: '/images/gritter/error.png'
            });
        }

        document.getElementById('comment_submit').disabled = false;
    }).bind('ajax:beforeSend', function(xhr, settings){
        document.getElementById('comment_submit').disabled = true;
    });

    $('#comment_body').click(function(){
        $(this).css('height', '50px');
        $('#comment_submit').show();
    });

});

$(window).scroll(function(){
    var $sticky_image = $('#main_image'),
        window_top = $(window).scrollTop(),
        image_top = $sticky_image.offset().top,
        comments = $('#comments');

    if ((window_top > image_top) && !$sticky_image.hasClass('sticky') && (comments.height() > $sticky_image.height()))
    {
        $sticky_image.addClass('sticky');
        console.log('window top > image top');
        console.log(comments.height() > $sticky_image.height())
    } else if((window_top < image_top || window_top < 112) && ($sticky_image.hasClass('sticky'))) {
        $sticky_image.removeClass('sticky');
        console.log('window top < image top');
    }
});