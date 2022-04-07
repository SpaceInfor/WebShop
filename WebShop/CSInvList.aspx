<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSInvList.aspx.cs" Inherits="WebShop.CSInvList" %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
  
  <!-- Theme style -->
  <script type="text/javascript">
      function redirect() {
          debugger
          var url = "https://localhost:44367/WebOrderBooking.aspx";
          window.location(url);
      }
</script>
  <script type="text/javascript">
    $(document).ready(function () {
        get_Invoices();
    });
</script>
   <script type="text/javascript">
     function get_Invoices() {
       $.ajax({
         type: "POST",
         url: "CSInvList.aspx/GetSalesInvoice",
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
             { 'data': 't_nama', 'title': 'BP Code & Name' },
             { 'data': 't_idoc', 'title': 'Invoice No' },
             { 'data': 't_idat', 'title': 'Date' },
             { 'data': 't_lrno', 'title': 'LR No' },
             { 'data': 't_lrdt', 'title': 'LR Date' },
             { 'data': 't_lyno', 'title': 'Vehichle No' },
             { 'data': 't_name', 'title': 'Transporter' },
             { 'data': 't_item', 'title': 'Item' },
             { 'data': 't_dqua', 'title': 'Qty' },
             { 'data': 't_cuni', 'title': 'UOM' },
             { 'data': 't_amti', 'title': 'Amount' },
             { 'data': 't_orno', 'title': 'Sales Order No' },
             { 'data': 't_worn', 'title': 'CP Order No.' }
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
          <h1>Sales Invoice List</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Sales Invoices List</li>
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
              <h3 class="card-title">Invoices</h3>
              <div class="card-tools">
                
              </div>
            </div>  
            <div class="card-body">
              <table id="example1" class="table table-bordered table-striped">
               
            </table>
            </div>
          </div>
        </div>
      </div>
  </section>
<!-- Bootstrap -->
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
      "responsive": true, "lengthChange": true, "autoWidth": false,
      "buttons": ["csv", "excel", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
    });
  });
</script>--%>
<!-- Ekko Lightbox -->
</asp:Content>
