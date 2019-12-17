$(document).ready(function() {
  $('tr[data-href]','table.history_data').on('click',function(){
	location.href = $(this).data('href');
  });
});