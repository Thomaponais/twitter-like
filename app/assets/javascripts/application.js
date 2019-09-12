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
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
$(document).on('turbolinks:load', function() {
  window.setTimeout(function() {
    $("#fade.alert").fadeTo(1000, 0).slideUp(1000, function(){
      $(this).remove();
    });
  }, 3000);
});

$(document).ready(function(){
$('a[data-toggle="tab"]').on('tab', function (e) {
  localStorage.setItem('activeTab', $(e.target).attr('href'));
});
var activeTab = localStorage.getItem('activeTab');
if(activeTab){
  $('.nav-tabs a[href="' + activeTab + '"]').tab('show');
}
});

$(document).ready(function(){
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    localStorage.setItem('activeTab', $(e.target).attr('href'));
  });
  var activeTab = localStorage.getItem('activeTab');
  if(activeTab){
    $('.nav-pills a[href="' + activeTab + '"]').tab('show');
  }
  });
