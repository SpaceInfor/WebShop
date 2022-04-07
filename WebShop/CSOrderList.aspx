<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSOrderList.aspx.cs" Inherits="WebShop.CSOrderList" %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" >
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
<script src="Scripts/sum.js"></script>
  <script type="text/javascript">
      function redirect() {
          debugger
          var url = "https://localhost:44367/WebOrderBooking.aspx";
          window.location(url);
      }
  </script>
  <script type="text/javascript">
     $(document).ready(function () {
       $.ajax({
         type: "POST",
         url: "CSOrderList.aspx/GetCustomers",
         data: '{}',
         contentType: "application/json; charset=utf-8",
         dataType: "json",
         success: OnSuccess,
         failure: function (response) {
           alert(response.d);
         },
         error: function (response) {
           alert(response.d);
         }
       });
     });
    function OnSuccess(response) {
     

       $("#example1").DataTable(
         {
           "footerCallback": function (row, data, start, end, display) {
             var api = this.api(), data;

             // Remove the formatting to get integer data for summation
             var intVal = function (i) {
               return typeof i === 'string' ?
                 i.replace(/[\$,]/g, '') * 1 :
                 typeof i === 'number' ?
                   i : 0;
             };

             // Total over all pages


             saleamttotal = api
               .column(16)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             preplanqty = api
               .column(21)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             planqty = api
               .column(24)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             prodqty = api
               .column(27)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);
            
             despqty = api
               .column(30)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             nopack = api
               .column(32)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);




             // Update footer
             $(api.column(16).footer()).html(saleamttotal);
             $(api.column(21).footer()).html(preplanqty);
             $(api.column(24).footer()).html(planqty);
             $(api.column(27).footer()).html(prodqty);
             $(api.column(30).footer()).html(despqty);
             $(api.column(32).footer()).html(nopack);
            
           },
          
           "responsive": true, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": true,
           dom: 'Bfrtip',
           buttons: [
             { extend: 'copyHtml5', footer: true, header: true },
             { extend: 'excelHtml5', footer: true, header: true },
             { extend: 'csvHtml5', footer: true, header: true },
             { extend: 'pdfHtml5', footer: true, header: true }
           ],

           data: response.d,
           columns: [
             { 'data': 'ord_link', 'title': '#' },
             { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
             { 'data': 't_worn', 'title': 'Quot. No' },
             { 'data': 't_cprj', 'title': 'Master Project' },
             { 'data': 't_scbp', 'title': 'Secondary Customer' },
             { 'data': 't_incl', 'title': 'Innocal Ref' },
             { 'data': 't_dlcd', 'title': 'DeltaCadd Ref' },
             { 'data': 't_quot', 'title': 'Order Ref' },
             { 'data': 't_rmrk', 'title': 'Remarks' },
             { 'data': 't_date', 'title': 'Date' },
             { 'data': 't_qtyp', 'title': 'Type' },
             { 'data': 't_item', 'title': 'Item' },
             { 'data': 't_qnty', 'title': 'Qty' },
             { 'data': 'Sales_Status', 'title': 'Login Team Status' },
             { 'data': 'Sales_Order', 'title': 'Sales Order No' },
             { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
             { 'data': 'Sales_Order_date', 'title': 'Sales Order Date' },
             { 'data': 'Batch_No', 'title': 'Batch No' },
             { 'data': 'Sales_Order_Status', 'title': 'Sales Order Status' },
             { 'data': 'Pre_Planning_Status', 'title': 'Pre Planning Stat' },
             { 'data': 'Pre_Plan_Qty', 'title': 'Pre Planned Qty' },
             { 'data': 'Pre_Planning_Date', 'title': 'Pre Planning Date' },
             { 'data': 'Planning_Status', 'title': 'Planning Stat' },
             { 'data': 'Plan_Qty', 'title': 'Planned Qty' },
             { 'data': 'Planning_Date', 'title': 'Planning Date' },
             { 'data': 'Production_Status', 'title': 'Production Stat' },
             { 'data': 'Prouced_Qty', 'title': 'Produced Qty' },
             { 'data': 'FGMT_Date', 'title': 'Production Date' },
             { 'data': 'Despatch_Status', 'title': 'Despatch Stat' },
             { 'data': 'Dispatched_Qty', 'title': 'Despatch Qty' },
             { 'data': 'Despatch_Date', 'title': 'Despatch Date' },
             { 'data': 't_nopk', 'title': 'No Of Packets' },
             { 'data': 't_rmsh', 'title': 'Shortages' },
             { 'data': 't_dldt', 'title': 'Tentative Desp Date' },
             { 'data': 't_devi', 'title': 'Deviation' },
             { 'data': 't_apst', 'title': 'Deviation Status' },
             { 'data': 't_dowp', 'title': 'Files' },
             { 'data': 't_chat', 'title': 'Chat' },
             { 'data': 't_devl', 'title': 'Add Shortages' },
             { 'data': 't_pckl', 'title': 'Get Packing List' }
             ]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };

  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Sales Quotation</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Sales Quotations</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Sales Quotations</h3>
              <div class="card-tools">
                <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-block btn-warning btn-sm" OnClick="btnAddNew_Click"><i class="fa fa-fw fa-plus-circle"></i>Add New</asp:LinkButton>
              </div>
            </div>  
            <div class="card-body">
              <table id="example1" class="table table-bordered table-striped ">
                <tfoot>
                  <tr>
                    <th style="text-align:right">Total:</th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th></th>
                    <th></th>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>
      </div>
  </section>

  <script src="../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- Filterizr-->
<script src="../plugins/filterizr/jquery.filterizr.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>

  <script>
    $(function () {
      $(document).on('click', '[data-toggle="lightbox"]', function (event) {
        event.preventDefault();
        $(this).ekkoLightbox({
          alwaysShowClose: true
        });
      });

      $('.filter-container').filterizr({ gutterPixels: 3 });
      $('.btn[data-filter]').on('click', function () {
        $('.btn[data-filter]').removeClass('active');
        $(this).addClass('active');
      });
    })
</script>


</asp:Content>
