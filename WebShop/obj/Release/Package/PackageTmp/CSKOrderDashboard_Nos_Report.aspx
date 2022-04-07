<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSKOrderDashboard_Nos_Report.aspx.cs" Inherits="WebShop.CSKOrderDashboard_Nos_Report" %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  <script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
  <script src="Scripts/sum.js"></script>

  <title>ORDER DASHBOARD REPORT</title>
      <script type="text/javascript">
        $(document).ready(function () {
          
          get_all_orders();
        });
    
      </script>
      
      <script type="text/javascript">
      function get_all_orders()
      {
        $.ajax({
          type: "POST",
          url: "CSKOrderDashboard_Nos_Report.aspx/GetOrders",
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
      }
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
             rnototal = api
               .column(1)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rvaltotal = api
               .column(2)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rbaltotal = api
               .column(3)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);


             rbalvtotal = api
               .column(4)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);


             rparttotal = api
               .column(5)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rpartvtotal = api
               .column(6)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rwiptotal = api
               .column(7)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rwipvtotal = api
               .column(8)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             
             
             rplngtotal = api
               .column(9)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             rplngvtotal = api
               .column(10)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             sreadytotal = api
               .column(11)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             spartreadytotal = api
               .column(12)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             swiptotal = api
               .column(13)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             slogintotal = api
               .column(14)
               .data()
               .reduce(function (a, b) {
                 return intVal(a) + intVal(b);
               }, 0);

             //// Total over this page
             //pageTotal = api
             //  .column(4, { page: 'current' })
             //  .data()
             //  .reduce(function (a, b) {
             //    return intVal(a) + intVal(b);
             //  }, 0);

             // Update footer
             $(api.column(1).footer()).html(Math.round(rnototal));
             $(api.column(2).footer()).html(Math.round(rvaltotal));
             $(api.column(3).footer()).html(Math.round(rbaltotal));
             $(api.column(4).footer()).html(Math.round(rbalvtotal));
             $(api.column(5).footer()).html(Math.round(rparttotal));
             $(api.column(6).footer()).html(Math.round(rpartvtotal));
             $(api.column(7).footer()).html(Math.round(rwiptotal));
             $(api.column(8).footer()).html(Math.round(rwipvtotal));
             $(api.column(9).footer()).html(Math.round(rplngtotal));
             $(api.column(10).footer()).html(Math.round(rplngvtotal));
             $(api.column(11).footer()).html(Math.round(sreadytotal));
             $(api.column(12).footer()).html(Math.round(spartreadytotal));
             $(api.column(13).footer()).html(Math.round(swiptotal));
             $(api.column(14).footer()).html(Math.round(slogintotal));
             
       
           },

           "responsive": false, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": false,
           "buttons": [{ extend: 'copyHtml5', footer: true, header: true },
             { extend: 'excelHtml5', footer: true, header: true },
             { extend: 'csvHtml5', footer: true, header: true },
             { extend: 'pdfHtml5', footer: true, header: true }],
           
           data: response.d,
           columns: [

             { 'data': 'bp_code_name' },
             { 'data': 'FullReady_Qty'},
             { 'data': 'FullReady_Val'},
             { 'data': 'BalPartReady_Qty'},
             { 'data': 'BalPartReady_Val'},
             { 'data': 'PartReady_Qty'},
             { 'data': 'PartReady_Val'},
             { 'data': 'WIP_Qty'},
             { 'data': 'WIP_Val'},
             { 'data': 'Planning_Qty'},
             { 'data': 'Planning_Val'},
             { 'data': 'FOC_FullReady_Qty'},
             { 'data': 'FOC_PartReady_Qty'},
             { 'data': 'FOC_WIP_Qty'},
             { 'data': 'FOC_Login_Nos'}]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };
      </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Order Dashboard</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Order Dashboard Report</li>
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
              <h3 class="card-title">Note : Values In Lakhs</h3>
              <div class="card-tools">
                
                
              </div>
            </div>  
            <div class="card-body table-responsive p-0">
                <table id="example1" class="table table-bordered table-striped">
                <thead>
               <%-- <tr>
                    <th rowspan="2">bp code & name</th>
                    <th colspan="2">100 ready orders</th>
                    <th colspan="2">bal.ready of partial desp.orders</th>
                    <th colspan="2">partially ready</th>
                    <th colspan="2">wip</th>
                    <th colspan="2">planning</th>
                    <th colspan="4">no of service orders</th>
                </tr>--%>
                <tr>
                    <th>BP Code & Name</th>
                    <th>Ready Orders NOs</th>
                    <th>Ready Orders Val</th>
                    <th>Bal.ready of Partial desp NOs</th>
                    <th>Bal.ready of Partial desp Val</th>
                    <th>Part Ready NOs</th>
                    <th>Part Ready Val</th>
                    <th>WIP NOs</th>
                    <th>WIP Val</th>
                    <th>Planning NOs</th>
                    <th>Planning Val</th>
                    <th>Service Ready</th>
                    <th>Service Part Ready</th>
                    <th>Service WIP</th> 
                  	<th>Service Login</th> 
                </tr>
                 
                </thead>
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
                  </tr>
                </tfoot>
                </table>
            </div>
          </div>
        </div>
      </div>
  </section>
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
   <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
   <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables  & Plugins -->
<script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../../plugins/jszip/jszip.min.js"></script>
<script src="../../plugins/pdfmake/pdfmake.min.js"></script>
<script src="../../plugins/pdfmake/vfs_fonts.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

</asp:Content>
