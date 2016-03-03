<?php echo $header; ?>

<script type="text/javascript" src="http://code.highcharts.com/highcharts.js"></script>

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

    <div class="content">
    <h1><?php echo $heading_title3; ?></h1>
   <table class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $column_customer; ?></td>
            <td class="left"><?php echo $column_email; ?></td>
            <td class="left"><?php echo $column_customer_group; ?></td>
            <td class="left"><?php echo $column_status; ?></td>
            <td class="right"><?php echo $column_orders; ?></td>
            <td class="right"><?php echo $column_products; ?></td>
<td class="right"><?php echo "No of Distinct Products" ?></td>
            <td class="right"><?php echo $column_total; ?></td>
            <td class="right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($topcustomers) { ?>
          <?php foreach ($topcustomers as $bestcustomer) { ?>
          <tr>
            <td class="left"><?php echo $bestcustomer['customer']; ?></td>
            <td class="left"><?php echo $bestcustomer['email']; ?></td>
            <td class="left"><?php echo $bestcustomer['customer_group']; ?></td>
            <td class="left"><?php echo $bestcustomer['status']; ?></td>
            <td class="right"><?php echo $bestcustomer['orders']; ?></td>
            <td class="right"><?php echo $bestcustomer['products']; ?></td>
 <td class="right"><?php echo $bestcustomer['productsdistinct']; ?></td>
            <td class="right"><?php echo $bestcustomer['total']; ?></td>
            <td class="right"><?php foreach ($bestcustomer['action'] as $action) { ?>
              [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
              <?php } ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>


<table class="form">
        <tr>
          <td><?php echo $entry_date_start; ?>
            <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" size="12" /></td>
          <td><?php echo $entry_date_end; ?>
            <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" size="12" /></td>
<td><?php echo $entry_customer_name; ?>
            <input type="text" name="filter_customer_name" value="<?php echo $filter_customer_name; ?>" id="customer-name" size="12" /></td>

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


      <h1><?php echo "Customer Statistics Report"?></h1>

      <table class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $column_customer; ?></td>
            <td class="left"><?php echo $column_email; ?></td>
            <td class="left"><?php echo $column_customer_group; ?></td>
            <td class="left"><?php echo $column_status; ?></td>
            <td class="right"><?php echo $column_orders; ?></td>
            <td class="right"><?php echo $column_products; ?></td>
<td class="right"><?php echo "No of Distinct Products" ?></td>
            <td class="right"><?php echo $column_total; ?></td>
            <td class="right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php if ($customers) { ?>
          <?php foreach ($customers as $customer) { ?>
          <tr>
            <td class="left"><?php echo $customer['customer']; ?></td>
            <td class="left"><?php echo $customer['email']; ?></td>
            <td class="left"><?php echo $customer['customer_group']; ?></td>
            <td class="left"><?php echo $customer['status']; ?></td>
            <td class="right"><?php echo $customer['orders']; ?></td>
            <td class="right"><?php echo $customer['products']; ?></td>
   <td class="right"><?php echo $customer['productsdistinct']; ?></td>
            <td class="right"><?php echo $customer['total']; ?></td>
            <td class="right"><?php foreach ($customer['action'] as $action) { ?>
              [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
              <?php } ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>

<div id="mychart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
    url = 'index.php?route=report/customer_order_statistics&token=<?php echo $token; ?>';
   
    var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
   
    if (filter_date_start) {
        url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
    }

    var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
   
    if (filter_date_end) {
        url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
    }
        var filter_customer_name = $('input[name=\'filter_customer_name\']').attr('value');
   
    if (filter_customer_name) {

        url += '&filter_customer_name=' + encodeURIComponent(filter_customer_name);
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

<script type="text/javascript">
$(function () {
    <?php if ($customers) { ?>
    $('#mychart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Customer Order Statistics'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [
      <?php if ($customers) { ?>
          <?php foreach ($customers as $customer) { ?>
         '<?php echo $customer['customer']; ?>',
      <?php } ?>
          <?php } ?>
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Number'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.3,
                borderWidth: 0.1
            }
        },
        series: [{
            name: 'No of Orders',
            data: [
          <?php if ($customers) { ?>
              <?php foreach ($customers as $customer) { ?>
             <?php echo $customer['orders']; ?>,
          <?php } ?>
              <?php } ?>
           ]

        }, {
            name: 'No of Products',
            data: [
          <?php if ($customers) { ?>
              <?php foreach ($customers as $customer) { ?>
          <?php echo $customer['products']; ?>,
          <?php } ?>
              <?php } ?>
          ]

        }, {
            name: 'No of Distinct Products',
            data: [
          <?php if ($customers) { ?>
              <?php foreach ($customers as $customer) { ?>
          <?php echo $customer['productsdistinct']; ?>,
          <?php } ?>
              <?php } ?>
          ]

        }]
    });
<?php } ?>
});
</script>

<?php echo $footer; ?>
