<?php
class ControllerReportCustomerReferrer extends Controller {
    public function index() {    

        $this->language->load('report/customer_order');

        $this->document->setTitle($this->language->get('heading_title'));
       
        if (isset($this->request->get['filter_date_start'])) {
            $filter_date_start = $this->request->get['filter_date_start'];
        } else {
            $filter_date_start = '';
        }

        if (isset($this->request->get['filter_date_end'])) {
            $filter_date_end = $this->request->get['filter_date_end'];
        } else {
            $filter_date_end = '';
        }
                if (isset($this->request->get['filter_referrer_name'])) {

            $filter_referrer_name = $this->request->get['filter_referrer_name'];
        } else {
            $filter_referrer_name = '';
        }
       
        if (isset($this->request->get['filter_order_status_id'])) {
            $filter_order_status_id = $this->request->get['filter_order_status_id'];
        } else {
            $filter_order_status_id = 0;
        }   
               
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $url = '';
       
        if (isset($this->request->get['filter_date_start'])) {
            $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
        }
       
        if (isset($this->request->get['filter_date_end'])) {
            $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
        }
               
               if (isset($this->request->get['filter_referrer_name'])) {
            $url .= '&filter_referrer_name=' . $this->request->get['filter_referrer_name'];
        }

        if (isset($this->request->get['filter_order_status_id'])) {
            $url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
        }
       
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
                       
        $this->data['breadcrumbs'] = array();

           $this->data['breadcrumbs'][] = array(
               'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
              'separator' => false
           );

           $this->data['breadcrumbs'][] = array(
               'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('report/customer_order', 'token=' . $this->session->data['token'] . $url, 'SSL'),
              'separator' => ' :: '
           );       
       
        $this->load->model('report/customer');
       
        $this->data['customers'] = array();
       
        $data = array(
            'filter_date_start'         => $filter_date_start,
            'filter_date_end'         => $filter_date_end,
                        'filter_referrer_name'         => $filter_referrer_name,
            'filter_order_status_id' => $filter_order_status_id,
            'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit'                  => $this->config->get('config_admin_limit')
        );
               
        $customer_total = $this->model_report_customer->getTotalOrders($data);
       
        $results = $this->model_report_customer->getReferrerOrders($data);
     $referrers = $this->model_report_customer->getBestReferrerOrders($data);
       

foreach ($referrers as $referrer) {
           
                       
            $this->data['bests'][] = array(
                'numberofunits'       => $referrer['no_of_units'],
                                'referrer'       => $referrer['referrer'],
                'amount'          => $referrer['total_amount'],
               
                'orders'         => $referrer['no_of_orders'],
                'products'       => $referrer['no_of_distinct_products']
          
            );
        }

        foreach ($results as $result) {
       
                       
            $this->data['customers'][] = array(
                'numberofunits'       => $result['no_of_units'],
                                'referrer'       => $result['referrer'],
                'amount'          => $result['total_amount'],
              
                'orders'         => $result['no_of_orders'],
                'products'       => $result['no_of_distinct_products'],
                //'total'          => $this->currency->format($result['total'], $this->config->get('config_currency')),
                //'action'         => $action
            );
        }
         
         $this->data['heading_title1'] = $this->language->get('heading_title1');
        $this->data['heading_title2'] = $this->language->get('heading_title2');
        $this->data['text_no_results'] = $this->language->get('text_no_results');
        $this->data['text_all_status'] = $this->language->get('text_all_status');
       
        $this->data['column_customer'] = $this->language->get('column_customer');
        $this->data['column_email'] = $this->language->get('column_email');
        $this->data['column_customer_group'] = $this->language->get('column_customer_group');
        $this->data['column_status'] = $this->language->get('column_status');
        $this->data['column_orders'] = $this->language->get('column_orders');
        $this->data['column_products'] = $this->language->get('column_products');
        $this->data['column_total'] = $this->language->get('column_total');
        $this->data['column_action'] = $this->language->get('column_action');
                $this->data['column_referrer'] = $this->language->get('column_referrer');
        $this->data['column_number_order'] = $this->language->get('column_number_order');
$this->data['column_number_of_units'] = $this->language->get('column_number_of_units');
$this->data['column_number_distinct_products'] = $this->language->get('column_number_distinct_products');

        $this->data['entry_date_start'] = $this->language->get('entry_date_start');
        $this->data['entry_date_end'] = $this->language->get('entry_date_end');
                $this->data['entry_referrer_name'] = $this->language->get('entry_referrer_name');
        $this->data['entry_status'] = $this->language->get('entry_status');

        $this->data['button_filter'] = $this->language->get('button_filter');
       
        $this->data['token'] = $this->session->data['token'];
       
        $this->load->model('localisation/order_status');
       
        $this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
           
        $url = '';
                       
        if (isset($this->request->get['filter_date_start'])) {
            $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
        }
       
        if (isset($this->request->get['filter_date_end'])) {
            $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
        }
                if (isset($this->request->get['filter_referrer_name'])) {
            $url .= '&filter_referrer_name=' . $this->request->get['filter_referrer_name'];
        }

        if (isset($this->request->get['filter_order_status_id'])) {
            $url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
        }
               
        $pagination = new Pagination();
        $pagination->total = $customer_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
           
        $this->data['pagination'] = $pagination->render();
       
        $this->data['filter_date_start'] = $filter_date_start;
        $this->data['filter_date_end'] = $filter_date_end;       
                $this->data['filter_referrer_name'] = $filter_referrer_name;
        $this->data['filter_order_status_id'] = $filter_order_status_id;
                 
        $this->template = 'report/customer_referrer.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
               
        $this->response->setOutput($this->render());
    }
}
?>
