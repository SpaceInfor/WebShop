<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="INNDespDrill1.aspx.cs" Inherits="WebShop.INNDespDrill1" %>
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

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
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
         url: "INNDespDrill1.aspx/GetCustomers",
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
       debugger
       $("#example1").DataTable(
         {
           "responsive": true, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": true,
           "buttons": ["csv", "excel", "print", "colvis"],
           data: response.d,
           columns: [
        
             { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
             { 'data': 't_qorn', 'title': 'Quot. No' },
             { 'data': 't_ccit', 'title': 'Destination' },
             { 'data': 't_cprj', 'title': 'Project Code' },
             { 'data': 't_date', 'title': 'Quotation Date' },
             { 'data': 't_refa', 'title': 'Reference A' },
             { 'data': 't_refb', 'title': 'Reference B' },
             { 'data': 't_corn', 'title': 'Customer Order' },
             { 'data': 'Sales_Order', 'title': 'Sales Order No' },
             { 'data': 'Sales_Order_Date', 'title': 'Sales Order Date' },
             { 'data': 't_item', 'title': 'Item Code' },
             { 'data': 't_item_desc', 'title': 'Item Description' },
             { 'data': 'Sales_Qty', 'title': 'Sales Order Qty' },
             { 'data': 't_cuni', 'title': 'Unit' },
             { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
             { 'data': 't_cwar', 'title': 'Warehouse' },
             { 'data': 't_desp', 'title': 'Despatched Qty' }]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };

   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Sales Orders Pending For Despatch</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="INNDashboard.aspx">Home</a></li>
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
              <h3 class="card-title">Sales Orders Pending For Despatch</h3>
              <div class="card-tools">
              
              </div>
            </div>  
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped ">
                  <%--<thead>
                  <tr>
                    <th>#</th>
                    <th>BP Code & Name</th>
                    <th>Quot. No</th>
                    <th>Master Project</th>
                    <th>Secondary Customer</th>
                    <th>Innocal Ref</th>
                    <th>DeltaCadd Ref</th>
                    <th>Order Ref</th>
                    <th>Remarks</th>
                    <th>Date</th>              
                    <th>Type</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Login Team Status</th>
                    <th>Sales Order No</th>
                    <th>Sales Order Amt</th>
                    <th>Pre Planning Stat</th>
                    <th>Pre Planned Qty</th>
                    <th>Planning Stat</th>
                    <th>Planned Qty</th>
                    <th>Production Stat</th>
                    <th>Produced Qty</th>
                    <th>Despatch Stat</th>
                    <th>Despatch Qty</th>
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Deviation</th>
                    <th>Deviation Staus</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Add Shortages</th>
                    <th>Get Packing List</th>
                  </tr>
                  </thead>
                  <tbody>
                  <asp:Literal ID="order" runat="server"></asp:Literal>
                  </tbody>
                  <tfoot>
                  <tr>
                    <th>#</th>
                    <th>BP Code & Name</th>
                    <th>Quot. No</th>
                    <th>Master Project</th>
                    <th>Secondary Customer</th>
                    <th>Innocal Ref</th>
                    <th>DeltaCadd Ref</th>
                    <th>Order Ref</th>
                    <th>Remarks</th>
                    <th>Date</th>              
                    <th>Type</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Login Team Status</th>
                    <th>Sales Order No</th>
                    <th>Sales Order Amt</th>
                    <th>Pre Planning Stat</th>
                    <th>Pre Planned Qty</th>
                    <th>Planning Stat</th>
                    <th>Planned Qty</th>
                    <th>Production Stat</th>
                    <th>Produced Qty</th>
                    <th>Despatch Stat</th>
                    <th>Despatch Qty</th>
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Deviation</th>
                    <th>Deviation Staus</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Add Shortages</th>
                    <th>Get Packing List</th>
                  </tr>
                  </tfoot>--%>
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
<!-- Page specific script -->
<%--<script>
  $(function () {
    $("#example1").DataTable({
      "responsive": false, "lengthChange": true, "autoWidth": false,
      "deferRender": true, "paging": true,
      "buttons": ["csv", "excel", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    $('#example1').show();
  });
</script>--%>
  


</asp:Content>
