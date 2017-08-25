//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .
//= require bootstrap-datepicker

// var dateFormat = 'yy-mm-dd';
// var disableDates = ['2017/08/01', '2017/08/02']; // ここがミソ
//var disableddates = ["12-3-2017", "12-11-2017", "12-25-2017", "12-20-2017"];

var dates = [];
var i;

for (i = 1; i < 16; i = i + 1) {
    if ($('#invisible').data('rubyvar' + i) !== undefined) {
      dates.push( $('#invisible').data('rubyvar' + i) );
   };
};

//var rubyVar2 = $('#invisible').data('rubyvar2');
//var rubyVar2 = $('#invisible').data('rubyvar2');

$('.datepicker').datepicker({
     format: "yyyy-mm-dd",
    datesDisabled: dates
});
