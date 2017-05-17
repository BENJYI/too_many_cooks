// .managers-downvote-chef

$(document).ready(function() {

  $('.managers-upvote-chef').on('click', function(e) {
    e.preventDefault();
    var chefId = $(this).data('chef-id')
    $.post('/managers/chefs/upvote', { id: chefId })
      .always(function() {
        window.location.reload();
      });
  });

  $('.managers-downvote-chef').on('click', function(e) {
    e.preventDefault();
    var chefId = $(this).data('chef-id')
    $.post('/managers/chefs/downvote', { id: chefId })
      .always(function() {
        window.location.reload();
      });
  });

});