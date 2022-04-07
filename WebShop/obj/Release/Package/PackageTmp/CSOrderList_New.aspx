<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSOrderList_New.aspx.cs" Inherits="WebShop.CSOrderList_New" %>
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
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
   <script type="text/javascript">
     $(document).ready(function () {
       $.ajax({
         type: "POST",
         url: "CSOrderList_New.aspx/GetCustomers",
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
           "responsive": false, "lengthChange": true, "autoWidth": true,
           "deferRender": true, "paging": true,
           "buttons": ["csv", "excel", "print", "colvis"],
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
             { 'data': 'Pre_Planning_Status', 'title': 'Pre Planning Stat' },
             { 'data': 'Pre_Plan_Qty', 'title': 'Pre Planned Qty' },
             { 'data': 'Planning_Status', 'title': 'Planning Stat' },
             { 'data': 'Plan_Qty', 'title': 'Planned Qty' },
             { 'data': 'Production_Status', 'title': 'Production Stat' },
             { 'data': 'Prouced_Qty', 'title': 'Produced Qty' },
             { 'data': 'Despatch_Status', 'title': 'Despatch Stat' },
             { 'data': 'Dispatched_Qty', 'title': 'Despatch Qty' },
             { 'data': 't_rmsh', 'title': 'Shortages' },
             { 'data': 't_dldt', 'title': 'Tentative Desp Date' },
             { 'data': 't_devi', 'title': 'Deviation' },
             { 'data': 't_apst', 'title': 'Deviation Status' },
             { 'data': 't_dowp', 'title': 'Files' },
             { 'data': 't_chat', 'title': 'Chat' },
             { 'data': 't_devl', 'title': 'Add Shortages' },
             { 'data': 't_pckl', 'title': 'Get Packing List' }]
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
            <div class="card-body table-responsive p-0">
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

  
</asp:Content>
