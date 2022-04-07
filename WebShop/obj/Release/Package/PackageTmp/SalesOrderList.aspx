<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderList.aspx.cs" Inherits="WebShop.SalesOrderList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sales Order List</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css" />
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css" />

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
        $(document).ready(function () {
            
            Bind_SalesDetails();
        });
    </script>
    <script type="text/javascript">
        function Bind_SalesDetails() {
          
            $.ajax({

                type: "POST",
                url: "SalesOrderList.aspx/GetSalesOrderDetails",

                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#example1').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": false,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            //{ 'data': null, title: "Select", wrap: true, "render": function (item) { return '<div button type="button" class="btn btn-block btn-secondary" OnClick=javascript:GetSelectedRow("' + row.t_orno.ToString() + '")><i class="fas fa-arrow-circle-left"></i></button></div>' } },
                            {

                                data: null, "title": "Select", render: function (data, type, row, meta) {

                                    return '<a href="#" class="btn btn-block btn-secondary" onclick=javascript:GetSelectedRow("' + row.t_orno + '")><i class="fas fa-arrow-circle-left"></i></a></div>';
                                     //return '<a href="#"  class="badge bg-primary btnRetriveProdShape"><i class="fa fa-backward"></i></a>';
                                }
                            },
                            { "data": "t_orno", "title": "Sales Order" },
                            { "data": "t_stbp", "title": "Business Partner Id" },
                            { "data": "t_nama", "title": "Name" },
                        ]
                    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Sales Order List</h3>
            </div>

            <div class="card-body" id="bpmaster" runat="server">
                <div class="card-body table-responsive p-0">
                    <table id="example1" class="table table-bordered table-striped ">
                         <thead>
                        <tr>
                            <th style="width: 30px;">#</th>
                            <th>Sales Order</th>
                            <th>Business Partner</th>
                            <th>Name</th>
                         </tr>
                    </thead>
                    </table>
                </div>
                <%--<table id="example1" class="table table-bordered table-striped">--%>
                <%--<thead>
                        <tr>
                            <th style="width: 30px;">#</th>
                            <th>Sales Order</th>

                        </tr>
                    </thead>--%>
                <%--<div id="sam" runat="server">
                    </div>--%>
                <%--  <tfoot>
                    </tfoot>--%>
                <%--</table>--%>
            </div>
            <!-- /.card-body -->
        </div>
    </form>
    <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables -->
    <%-- <script src="../../plugins/datatables/jquery.dataTables.js"></script>
    <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>--%>
    <!-- AdminLTE App -->
    <script src="../../dist/js/adminlte.min.js"></script>
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


    <!-- AdminLTE for demo purposes -->
    <%--  <script src="../../dist/js/demo.js"></script>--%>
    <!-- page script -->
    <%--<script>
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
    </script>--%>
</body>
</html>
