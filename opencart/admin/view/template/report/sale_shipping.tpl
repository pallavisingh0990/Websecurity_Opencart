<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
</br>
<div class = 'button'>
<a href="#" id ="export" role ='button' class="button" align ="top">Export to CSV
</a>
</div>

    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_date_start; ?>
            <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" size="12" /></td>
          <td><?php echo $entry_date_end; ?>
            <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" size="12" /></td>
          <td><?php echo $entry_group; ?>
            <select name="filter_group">
              <?php foreach ($groups as $groups) { ?>
              <?php if ($groups['value'] == $filter_group) { ?>
              <option value="<?php echo $groups['value']; ?>" selected="selected"><?php echo $groups['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $groups['value']; ?>"><?php echo $groups['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
          <td><?php echo $entry_status; ?>
            <select name="filter_order_status_id">
              <option value="0"><?php echo $text_all_status; ?></option>
              <?php foreach ($order_statuses as $order_status) { ?>
              <?php if ($order_status['order_status_id'] == $filter_order_status_id) { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
          <td style="text-align: right;"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
        </tr>

      </table>
<div id ="dvData">
      <table class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $column_date_start; ?></td>
            <td class="left"><?php echo $column_date_end; ?></td>
            <td class="left"><?php echo $column_title; ?></td>
            <td class="right"><?php echo $column_orders; ?></td>
            <td class="right"><?php echo $column_total; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($orders) { ?>
          <?php foreach ($orders as $order) { ?>
          <tr>
            <td class="left"><?php echo $order['date_start']; ?></td>
            <td class="left"><?php echo $order['date_end']; ?></td>
            <td class="left"><?php echo $order['title']; ?></td>
            <td class="right"><?php echo $order['orders']; ?></td>
            <td class="right"><?php echo $order['total']; ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
</div>

      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/sale_shipping&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_group = $('select[name=\'filter_group\']').attr('value');
	
	if (filter_group) {
		url += '&filter_group=' + encodeURIComponent(filter_group);
	}
	
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');
	
	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 

<script type='text/javascript'>
$(document).ready(function () {
console.log("HELLO")
function exportTableToCSV($table, filename) {
var $headers = $table.find('tr:has(th)')
,$rows = $table.find('tr:has(td)')

,tmpColDelim = String.fromCharCode(11) // vertical tab character
,tmpRowDelim = String.fromCharCode(0) // null character
// actual delimiter characters for CSV format
,colDelim = '","'
,rowDelim = '"\r\n"';

var csv = '"';
csv += formatRows($headers.map(grabRow));
csv += rowDelim;
csv += formatRows($rows.map(grabRow)) + '"';
// Data URI
var csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
$(this)
.attr({
'download': filename
,'href': csvData

});

function formatRows(rows){
return rows.get().join(tmpRowDelim)
.split(tmpRowDelim).join(rowDelim)
.split(tmpColDelim).join(colDelim);
}

function grabRow(i,row){
var $row = $(row);

var $cols = $row.find('td');
if(!$cols.length) $cols = $row.find('th');
return $cols.map(grabCol)
.get().join(tmpColDelim);
}
// Grab and format a column from the table
function grabCol(j,col){
var $col = $(col),
$text = $col.text();
return $text.replace('"', '""'); // escape double quotes
}
}
// This must be a hyperlink
$("#export").click(function (event) {
// var outputFile = 'export'
var outputFile = "Shipping_report";
outputFile = outputFile.replace('.csv','') + '.csv'
// CSV
exportTableToCSV.apply(this, [$('#dvData>table'), outputFile]);

});
});
</script>
<?php echo $footer; ?>
