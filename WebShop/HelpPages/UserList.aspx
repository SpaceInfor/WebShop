<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="WebShop.HelpPages.UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User List</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        function pageLoad() {
        }
        function GetSelectedRow(lnk) {
            
            var StateName = lnk.value;
            /*window.opener.setValue(StateName); */
            window.opener.setValue(lnk);
            window.close();
            return false;
        }
    </script>

    <script type="text/javascript">
        
        var userid = '';
        var UserName = '';
        var t_dept = '';
       
        $(document).ready(function () {
            const urlParams = new URLSearchParams(window.location.search);
            //const lastmoddate = urlParams.get('userId');
            userid = '<%= Session["t_usid"] %>';
            UserName = '<%= Session["t_nama"] %>';
            t_dept = '<%= Session["t_dept"] %>';
           

        });
    </script>


    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
     <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css" />
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">User List</h3>
            </div>

            <div class="card-body" id="bpmaster" runat="server">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th style="width: 30px;">Select</th>
                            <th>User Id</th>
                            <th>User Name</th>
                            <th>Department Id</th>
                            <th>Department Name</th>
                            <th>Level</th>
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
