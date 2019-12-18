$(document).ready(function() {
  $('tr[data-href]','table.client_data').on('click',function(){
	location.href = $(this).data('href');
  });
  $('tr[data-href]','table.hope_table').on('click',function(){
	location.href = $(this).data('href');
  });
  $(document).ready(function() {
  $('tr[data-href]','table.admin_user_table').on('click',function(){
	location.href = $(this).data('href');
  });
});
});