$(function() {
        $('#bank_table-table td').on('click', function() {
          var td = $(this)[0];
          var tr = $(this).closest('tr')[0];
          alert('td:' + td.cellIndex);
         // console.log('tr:' + tr.rowIndex);
         // console.log($(this).text());
        });
      });