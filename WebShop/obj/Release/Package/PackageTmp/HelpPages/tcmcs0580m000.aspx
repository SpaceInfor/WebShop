<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tcmcs0580m000.aspx.cs" Inherits="WebShop.HelpPages.tcmcs0580m000" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <script type="text/javascript">

      function pageLoad() 
      {
      }
      function GetSelectedRow(lnk)
      {    
          var StateName = lnk.value;
          
      /*window.opener.setValue(StateName); */
          
          window.opener.setValue(lnk);
          
          window.close();
          return false;
      }
    </script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 3 | DataTables</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
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
   <script type="text/javascript">
     $(document).ready(function ()
     {
       GetCarrierLsp();
       
     });
   </script> 
  <script type="text/javascript">
    function GetCarrierLsp()
      {
        $.ajax({
          type: "POST",
          url: "tcmcs0580m000.aspx/GetCarrierLsp",
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
             { 'data': 't_olnk', 'title': 'Select' },
             { 'data': 't_cfrw', 'title': 'Transporter Code' },
             { 'data': 't_dsca', 'title': 'Trnsporter Name' }
            
             ]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };
  </script>
</head>
<body>
    <form id="form1" runat="server">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Transporter Master</h3>
        </div>
        <div class="card-body" id="bpmaster" runat="server">
          <table id="example1" class="table table-bordered table-striped">  
          </table>
        </div>
      </div>
    </form>
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

</body>
</html>
