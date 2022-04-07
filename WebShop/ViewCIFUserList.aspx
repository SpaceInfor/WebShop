<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCIF.Master" AutoEventWireup="true" CodeBehind="ViewCIFUserList.aspx.cs" Inherits="WebShop.ViewCIFUserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>View CIF User List</title>
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
            window.opener.setValue(lnk);
            window.close();
            return false;
        }
    </script>
    <script type="text/javascript">
        var userid = '';
        var UserName = '';
       
        $(document).ready(function () {
            
            //const urlParams = new URLSearchParams(window.location.search);
            //const lastmoddate = urlParams.get('userId');
            userid = '<%=Session["t_usid"] %>';
            UserName = '<%=Session["userName"] %>';
            if (userid != '') {
                Bind_CIFUserDetails(userid);
            }

        });
    </script>
  
    <script type="text/javascript">
        function Bind_CIFUserDetails(userid) {

            $.ajax({

                type: "POST",
                url: "ViewCIFUserList.aspx/GetCIFUserDetails",
                data: "{'t_usid': '" + userid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tblViewCIFUserList').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            { "data": "t_usid", "title": "User ID" },
                            { "data": "t_nama", "title": "User Name" },
                            { "data": "t_pass", "title": "Password" },
                            { "data": "t_emai", "title": "E-mail" },
                            {

                                data: null, "title": "User Type", render: function (data, type, row, meta) {
                                    var userType = "";
                                    if (row.t_type == 8) {
                                        userType = "Admin";
                                        return '<div' + userType + '" class="badge bg-warning">' + userType + '</div>';
                                    }
                                    else if (row.t_type == 9) {
                                        userType = "User";
                                        return '<div' + userType + '" class="badge bg-success">' + userType + '</div>';
                                    }
                                
                                }
                            },
                            //{ "data": "t_type", "title": "User Type" },
                           
                        ]
                    }).buttons().container().appendTo('#tblViewCIFUserList_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">CIF User Registration List</h3>
        </div>

        <div class="card-body" id="bpmaster" runat="server">
            <div class="card-body table-responsive p-0">
                <div class="card-body table-responsive p-0">
                    <table class="table table-bordered table-striped" id="tblViewCIFUserList">
                    </table>
                </div>
            </div>
        </div>
        <!-- /.card-body -->
    </div>
    <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables -->
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
    <script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

</asp:Content>
