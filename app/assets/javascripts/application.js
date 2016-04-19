// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require lightbox-bootstrap
//= require summernote
//= require turbolinks
//= require_tree .

var playNext = function(i) {
  var elm = $("#homeslide li:eq(" + i + ")");
  var next = i + 1;
  if(next === 3){ next = 0; }
  elm.fadeIn(1000).delay(2000).fadeOut(1000, function(){
    playNext(next);
  });
};

$(document).ready(function(){
  // initialize summernote
  $('[data-provider="summernote"]').each(function(){
    $(this).summernote({
      height: 300
    });
    $(this).code();
  });

  // homepage fading text
  $("#homeslide li").hide();
  playNext(0);

  //
  $('.screenshot').matchHeight();
  $('.screenshot-wrapper').matchHeight();
  $('.submission-image').matchHeight();
});

// lightbox
$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});
