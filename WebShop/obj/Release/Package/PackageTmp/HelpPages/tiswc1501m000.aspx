<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tiswc1501m000.aspx.cs" Inherits="WebShop.HelpPages.tiswc1501m000" %>
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
  <title>Work Station Master</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

</head>
<body>
    <form id="form1" runat="server">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Business Partners</h3>
        </div>
           
        <div class="card-body" id="bpmaster" runat="server">
          <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Select</th>
                  <th>Work Station</th>
                  <th>Work Station Name</th>
                  
                </tr>
                </thead>
                  <div id="sam" runat="server">
                  
                  </div>
                <tfoot>
                </tfoot>
              </table>
        </div>
            <!-- /.card-body -->
      </div>
    </form>
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables -->
<script src="../../plugins/datatables/jquery.dataTables.js"></script>
<script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- page script -->
<script>
    $(function () {
        $("#example1").DataTable();
        $('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false,
        });
    });
</script>
</body>
</html>
