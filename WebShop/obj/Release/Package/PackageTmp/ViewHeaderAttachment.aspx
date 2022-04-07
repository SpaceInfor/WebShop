<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewHeaderAttachment.aspx.cs" Inherits="WebShop.ViewHeaderAttachment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Header Attachment</title>
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
            debugger
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
        var t_tano = '';
        $(document).ready(function () {
            debugger
           const urlParams = new URLSearchParams(window.location.search);
            //const lastmoddate = urlParams.get('userId');
            t_tano = '<%=Session["t_tano"] %>';
            UserName = '<%=Session["userName"] %>';
            t_tano = urlParams.get('t_tano');
           
            Bind_TaskHeaderDetails(t_tano);
        });
    </script>
    <%--<script language="javascript">
        var ctrl;
        function openChildProcess(control, form) {

            ctrl = control

            //frm = form + ".aspx?param1=" + username + "";
            frm = form + ".aspx";
            var left = (screen.width - 800) / 2;
            var top = (screen.height - 400) / 4;
            childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
        }
        function setValue(myVal) {

            document.getElementById(ctrl).value = myVal;
            $(document).ready(function () {
                document.getElementById(ctrl).onchange();
            });
        }
    </script>--%>
     <script type="text/javascript">
        function Bind_TaskHeaderDetails(t_tano) {

            $.ajax({

                type: "POST",
                url: "ViewHeaderAttachment.aspx/GetHeaderDetails",
                data: "{'t_tano': '" + t_tano + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tbltaskHeaderDetails').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            { "data": "t_tano", "title": "Task ID" },
                            { "data": "t_nama", "title": "User Name" },
                            { "data": "t_crdt", "title": "Date" },
                            { "data": "t_rmrk", "title": "Remark" },
                            //{ "data": "t_stat", "title": "Status" },
                            {

                                data: null, "title": "Status", render: function (data, type, row, meta) {
                                    var taskStatus = "";
                                    if (row.t_stat == 1) {
                                        taskStatus = "Pending";
                                        return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                    }
                                    else if (row.t_stat == 2) {
                                        taskStatus = "On-Hold";
                                        return '<div' + taskStatus + '" class="badge bg-danger">' + taskStatus + '</div>';
                                    }
                                    else {
                                        taskStatus = "Done";
                                        return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                    }

                                }
                            },
                            {

                                data: null, "title": "View", render: function (data, type, row, meta) {
                                    //return '<a href = "ViewAttachement.aspx?t_tano=' + row.t_tano + '&t_pono=' + row.t_pono + '"<i class="fas fa-images">View Attachment</a>';
                                    return '<a href = "ViewAttachement.aspx?t_tano=' + row.t_tano + '&t_pono=' + row.t_pono + '" class="fas fa-paperclip" data-toggle="modal" data-target="#myModalViewaAtt1"</a>';

                                }
                            },
                        ]
                    }).buttons().container().appendTo('#tbltaskHeaderDetails_wrapper .col-md-6:eq(0)');
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
                    <div class="card-body table-responsive p-0">
                        <table class="table table-bordered table-striped" id="tbltaskHeaderDetails">
                        </table>
                    </div>
                 </div>
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
</body>
</html>
