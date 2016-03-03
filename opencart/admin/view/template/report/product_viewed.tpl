<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="<?php echo $reset; ?>" class="button"><?php echo $button_reset; ?></a></div>
    </div>
</br>
<div class = 'button'>
<a href="#" id ="export" role ='button' class="button" align ="top">Export to CSV
</a>
</div>	

    <div class="content">
<div id ="dvData">
      <table class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $column_name; ?></td>
            <td class="left"><?php echo $column_model; ?></td>
            <td class="right"><?php echo $column_viewed; ?></td>
            <td class="right"><?php echo $column_percent; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($products) { ?>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="left"><?php echo $product['name']; ?></td>
            <td class="left"><?php echo $product['model']; ?></td>
            <td class="right"><?php echo $product['viewed']; ?></td>
            <td class="right"><?php echo $product['percent']; ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
</div>

      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<script type='text/javascript'>
$(document).ready(function () {

function exportTableToCSV($table, filename) {
var $headers = $table.find('tr:has(th)')
,$rows = $table.find('tr:has(td)')

,tmpColDelim = String.fromCharCode(11) // vertical tab character
,tmpRowDelim = String.fromCharCode(0) // null character

,colDelim = '","'
,rowDelim = '"\r\n"';
// Grab text from table into CSV formatted string
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
// Grab and format a row from the table
function grabRow(i,row){
var $row = $(row);
//for some reason $cols = $row.find('td') || $row.find('th') won't work...
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
var outputFile = "Product_Viewed";
outputFile = outputFile.replace('.csv','') + '.csv'
// CSV
exportTableToCSV.apply(this, [$('#dvData>table'), outputFile]);

});
});
</script>
<?php echo $footer; ?>
