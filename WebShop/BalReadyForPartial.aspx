<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="BalReadyForPartial.aspx.cs" Inherits="WebShop.BalReadyForPartial" %>
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
  <title>BAL READY OF PARTIAL DESP ORDERS</title>
   <script type="text/javascript">
     $(document).ready(function () {
       debugger;
       const urlParams = new URLSearchParams(window.location.search);
       const myParam = urlParams.get('type');
       if (myParam == 'REG') {
         get_all_orders();
       }
       else {
         get_foc_orders();
       }

     });
  </script>

 <script type="text/javascript">
   function get_all_orders() {
   $.ajax({
     type: "POST",
     url: "BalReadyForPartial.aspx/GetCustomers",
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
           "responsive": true, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": true,
           "buttons": ["csv", "excel", "print", "colvis"],
           data: response.d,
           columns: [
            

             { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
             { 'data': 't_scbp', 'title': 'Secondary Customer' },
             { 'data': 't_date', 'title': 'Quotation Date' },
             { 'data': 't_qtyp', 'title': 'Type' },
             { 'data': 'Sales_Order', 'title': 'Sales Order No' },
             { 'data': 'Sales_Qty', 'title': 'Sales Order Qty' },
             { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
             { 'data': 'Sales_Amount', 'title': 'Sale Order Date' },
             { 'data': 'Sales_Amount', 'title': 'Planning Release Date' },
             { 'data': 'Prouced_Qty', 'title': 'FGMT Qty' },
             { 'data': 'FGMT_Date', 'title': 'FGMT Date' },
             { 'data': 'partial_despatch', 'title': 'Partial Despatched Qty' },
             { 'data': 'Despatch_Date', 'title': 'Partial Despatch Date' },
             { 'data': 't_rmsh', 'title': 'Tentative Desp Date' },
             { 'data': 't_devi', 'title': 'Deviation' },
             { 'data': 't_apst', 'title': 'Deviation Status' },
             { 'data': 't_npak', 'title': 'No Of Packets' }]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };

 </script>
  <script type="text/javascript">
    function get_foc_orders() {
      $.ajax({
        type: "POST",
        url: "BalReadyForPartial.aspx/GetFOCOrders",
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
          "responsive": true, "lengthChange": true, "autoWidth": false,
          "deferRender": true, "paging": true,
          "buttons": ["csv", "excel", "print", "colvis"],
          data: response.d,
          columns: [
            { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
            { 'data': 't_scbp', 'title': 'Secondary Customer' },
            { 'data': 't_date', 'title': 'Quotation Date' },
            { 'data': 't_qtyp', 'title': 'Type' },
            { 'data': 'Sales_Order', 'title': 'Sales Order No' },
            { 'data': 'Sales_Qty', 'title': 'Sales Order Qty' },
            { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
            { 'data': 'Sales_Amount', 'title': 'Sale Order Date' },
            { 'data': 'Sales_Amount', 'title': 'Planning Release Date' },
            { 'data': 'Prouced_Qty', 'title': 'FGMT Qty' },
            { 'data': 'FGMT_Date', 'title': 'FGMT Date' },
            { 'data': 'partial_despatch', 'title': 'Partial Despatched Qty' },
            { 'data': 'Despatch_Date', 'title': 'Partial Despatch Date' },
            { 'data': 't_rmsh', 'title': 'Shortage' },
            { 'data': 't_devi', 'title': 'Deviation' },
            { 'data': 't_apst', 'title': 'Deviation Status' },
            { 'data': 't_nopk', 'title': 'No Of Packets' }]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
    };
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>BAL.READY OF PARTIAL DESP.ORDERS</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">BAL READY OF PARTIAL DESP ORDERS</li>
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
              <h3 class="card-title">Sales Orders having bal. ready of partially despatched</h3>
              <div class="card-tools">
                
              </div>
            </div>  
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped ">
       
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
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
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
    <script src="../../dist/js/adminlte.min.js"></script>
    <script src="../../dist/js/demo.js"></script>

</asp:Content>
