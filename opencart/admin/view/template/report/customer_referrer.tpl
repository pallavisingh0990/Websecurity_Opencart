<?php
echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title1; ?></h1>
    </div>
   
    <div class="content">

<h1><?php echo $heading_title2; ?></h1>

   
<table class="list" >
        <thead>
          <tr>
           
            <td class="left"><?php echo $column_referrer; ?></td>
            <td class="left"><?php echo $column_number_order; ?></td>
            <td class="left"><?php echo $column_number_of_units; ?></td>
            <td class="left"><?php echo $column_number_distinct_products; ?></td>
           
            <td class="right"><?php echo $column_total; ?></td>
           
          </tr>
        </thead>
        <tbody>
          <?php if ($bests) { ?>
          <?php foreach ($bests as $bestreferrer) { ?>
          <tr>
           
            <td class="left"><?php echo $bestreferrer['referrer']; ?></td>
            <td class="left"><?php echo $bestreferrer['orders']; ?></td>
            <td class="left"><?php echo $bestreferrer['numberofunits']; ?></td>
            <td class="left"><?php echo $bestreferrer['products']; ?></td>
            <td class="right"><?php echo $bestreferrer['amount']; ?></td>
           
     </tr>
          <?php } ?>
          <?php } else { ?>
        
          <?php } ?>
        </tbody>
      </table>



<h1><?php echo "Referrer Statistics"?></h1>

      <div id="dvData">
      <table class="list" >
        <thead>
          <tr>
           
            <td class="left"><?php echo $column_referrer; ?></td>
            <td class="left"><?php echo $column_number_order; ?></td>
            <td class="left"><?php echo $column_number_of_units; ?></td>
            <td class="left"><?php echo $column_number_distinct_products; ?></td>
           
            <td class="right"><?php echo $column_total; ?></td>
           
          </tr>
        </thead>
        <tbody>
          <?php if ($customers) { ?>
          <?php foreach ($customers as $customer) { ?>
          <tr>
           
            <td class="left"><?php echo $customer['referrer']; ?></td>
            <td class="left"><?php echo $customer['orders']; ?></td>
            <td class="left"><?php echo $customer['numberofunits']; ?></td>
            <td class="left"><?php echo $customer['products']; ?></td>
            <td class="right"><?php echo $customer['amount']; ?></td>
           
     </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
</div>

     <div class='button'>
<a href="#" id ="export" role='button' class="button">Export To CSV
</a>
</div>
    
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
function filter() {
    url = 'index.php?route=report/customer_referrer&token=<?php echo $token; ?>';
   
    var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
   
    if (filter_date_start) {
        url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
    }

    var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
   
    if (filter_date_end) {
        url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
    }
        var filter_referrer_name = $('input[name=\'filter_referrer_name']').attr('value');
   
    if (filter_referrer_name) {

        url += '&filter_referrer_name=' + encodeURIComponent(filter_referrer_name);
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
<script type="text/javascript"><!--
function exporttocsv() {
    alert("hi");

}
//--></script>
<script type='text/javascript'>
$(document).ready(function () {
console.log("HELLO")
function exportTableToCSV($table, filename) {
var $headers = $table.find('tr:has(th)')
,$rows = $table.find('tr:has(td)')

,tmpColDelim = String.fromCharCode(11) // vertical tab character
,tmpRowDelim = String.fromCharCode(0) // null character

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


$("#export").click(function (event) {

var outputFile = "Customer_Referrer_Report";
outputFile = outputFile.replace('.csv','') + '.csv'
// CSV
exportTableToCSV.apply(this, [$('#dvData>table'), outputFile]);

});
});
</script>
   

<?php echo $footer; ?>
