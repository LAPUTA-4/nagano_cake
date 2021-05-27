// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


/*================== About ==================*/


$(document).on('turbolinks:load',function() {
  $(document).ready(function () {
   $("#theTarget").skippr({
    transition : 'fade',
    speed : 2000,
    easing : 'easeOutQuart',
    navType : 'bubble',
    childrenElementType : 'div',
    arrows : false,
    autoPlay : true,
    autoPlayDuration : 3800,
    keyboardOnAlways : false,
    hidePrevious : false
  });
 });
});
/*================== 商品詳細 ==================*/
$(document).on('turbolinks:load',function() {
  $(document).ready(function () {
   var gazou = $("#zoom").attr('src');
   $("#zoom").attr({'data-zoom-image': gazou });
   $("#zoom").elevateZoom({
		  zoomType : "lens",
		  lensShape : "round",
		  zoomWindowWidth: 500,
		  lensSize : 200,
		  borderSize : 1
	  });
  });
});

