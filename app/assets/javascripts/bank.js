$(document).ready(function() {
  $('tr[data-href]','table#bank_history_table').on('click',function(){
	location.href = $(this).data('href');
  });
});