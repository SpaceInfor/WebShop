<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewLoadingSlip.aspx.cs" Inherits="WebShop.ViewLoadingSlip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Spacewood Loading</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
       <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

    <script language="javascript">

        var ctrl;

        function openChildProcess(control, form) {

            ctrl = control

            frm = form + ".aspx?param1=" + username + "";
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
    </script>
    <script type="text/javascript">
        var username = '';
        $(document).ready(function () {
            //Bind_Corrected_opeining();
        });
    </script>

    <script type="text/javascript">
        function Bind_Loading_Slip() {
            
            var t_orno = document.getElementById("t_orno").value;
            var t_load = document.getElementById("t_load").value;
            if (t_orno != "" || t_load != "") {
                $.ajax({
                    type: "POST",
                    url: "ViewLoadingSlip.aspx/GetLoadingSlipDetails",
                    data: '{t_orno: "' + t_orno + '",t_load: "' + t_load + '"}',
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
            else {
                toastr.warning('Please enter sales order no or loading no..!!!');

                var table = $('#tblloadingslip').DataTable();
                table
                    .clear()
                    .draw();
            }
        }


        function OnSuccess(response) {
            $("#tblloadingslip").DataTable(
                {
                    destroy: true,
                    "responsive": false, "lengthChange": true, "autoWidth": false,
                    "deferRender": true, "paging": true,
                "buttons": [
                  'copy',
                  'csv',
                  'excel',
                  {
                    extend: 'pdfHtml5',
                    orientation: 'landscape',
                    pageSize: 'LEGAL'
                  }],
                    data: response.d,
                    columns: [
                        { 'data': 't_orno', 'title': 'Sales Order' },
                        { 'data': 't_load', 'title': 'Load No' },
                        { 'data': 't_pono', 'title': 'Sr No.' },
                        { 'data': 't_item', 'title': 'Item Code' },
                        { 'data': 't_boxn', 'title': 'Box No.' },
                        { 'data': 't_bqty', 'title': 'Box Qty' },
                        { 'data': 't_boxs', 'title': 'Unique Box No.' },
                        { 'data': 't_bpid', 'title': 'Business Partner No' },
                        { 'data': 't_nama', 'title': 'Business Partner Name' },
                        { 'data': 't_date', 'title': 'Loading Date' },
                        //{ 'data': 't_dest', 'title': 'Destination' },
                        //{ 'data': 't_lyno', 'title': 'Vehicle No.' },
                        //{ 'data': 't_lrno', 'title': 'LR No.' },
                        //{ 'data': 't_lrdt', 'title': 'LR Date' },
                        { 'data': 't_npak', 'title': 'No Of Packets' },
                       /* { 'data': 't_carp', 'title': 'Carrier LSP' },*/
                       /* { 'data': 't_dsca', 'title': 'Transporter Name' },*/
                        {

                            data: null, "title": "Status", render: function (data, type, row, meta) {
                                var Status = "";
                                if (row.t_stat == 1) {
                                    Status = "Finalized";
                                    return '<div' + Status + '" class="badge bg-success">' + Status + '</div>';
                                }
                                else {
                                    Status = "Not Finalized";
                                    return '<div' + Status + '" class="badge bg-danger">' + Status + '</div>';
                                }

                            }
                        }
                        //{ 'data': 't_stat', 'title': 'Corrected Width' }



                    ]
                }).buttons().container().appendTo('#tblloadingslip_wrapper .col-md-6:eq(0)');;
        };

    </script>

</head>
<body class="hold-transition layout-top-nav">
  <div class="wrapper">
   <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
    <div class="container">
      <a href="../../index3.html" class="navbar-brand">
        <img src="Images/facvicon.png" class="brand-image img-square elevation-3">
        <span class="brand-text font-weight-light">Loading Scan App</span>
      </a>
     <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="CustLogin.aspx" role="button">
            <i class="fas fa-power-off"></i>
          </a>
        </li>
      </ul>
    </div>
  </nav>
    <form id="form1" runat="server">
     <div class="content-header">
      <div class="container">
        <div class="row mb-2">
          <div class="col-sm-6">
            
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
             <li class="breadcrumb-item"> <a class="btn btn-block btn-warning btn-xs" href="LoadingList.aspx"><i class="fas fa-backward"></i></a></li>
     
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
        <%--   <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>View Loading Slip</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="CSDashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">View Loading Slip</li>
                        </ol>
                    </div>
                </div>
            </div>

        </section>--%>
        <div class="content">
            <div class="container">
                <div class="row">
                    <!-- /.col-md-6 -->
                    <div class="col-lg-12">
                        <div class="card card-warning card-outline">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-truck-loading"></i>&nbsp;Loading Slip</h3>
                                <div class="card-tools">
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12" id="morder">
                                    <div class="row">
                                        <div class="col-6">
                                            <label>Sales Order</label>
                                            <div class="input-group">
                                                <input class="form-control" placeholder="Add Sales Order" id="t_orno" />
                                                <div class="input-group-append">
                                                    <button id="btnt_orno" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_orno','HelpPages/tdswc1505m001')"><i class="fa fa-fw fa-search"></i></button>
                                                </div>
                                            </div>
                                            &nbsp;<label id="Label3" runat="server" class="link-black text-sm"></label>
                                        </div>
                                        <div class="col-6">
                                            <label>Loading Slip No.</label>
                                            <div class="input-group">
                                                <input class="form-control" placeholder="Add Loading ID Here" id="t_load" />
                                                <div class="input-group-append">
                                                    <button id="btnt_load" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_load','HelpPages/tdswc1505m000')"><i class="fa fa-fw fa-search"></i></button>
                                                </div>
                                            </div>
                                            &nbsp;<label id="Label1" runat="server" class="link-black text-sm"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="form-group">
                                <button id="btnReport" type="button" class="btn btn-warning float-left toastrDefaultSuccess" onclick="Bind_Loading_Slip();">View Report</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">View Loading Slip</h3>
                                <div class="card-tools">
                                </div>
                            </div>
                            <div class="card-body table-responsive">
                                <table id="tblloadingslip" class="table table-bordered table-striped">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <aside class="control-sidebar control-sidebar-dark">
  
        </aside>

        <footer class="main-footer">
    <!-- To the right -->
        <div class="float-right d-none d-sm-inline">

        </div>
    <!-- Default to the left -->
   
      </footer>
    </form>
  </div>
</body>
<script src="../plugins/jquery/jquery.min.js"></script>
<!-- Toastr -->
<script src="plugins/toastr/toastr.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- Filterizr-->
<script src="../plugins/filterizr/jquery.filterizr.min.js"></script>

<!-- Datatable -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="plugins/jszip/jszip.min.js"></script>
<script src="plugins/pdfmake/pdfmake.min.js"></script>
<script src="plugins/pdfmake/vfs_fonts.js"></script>
<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>




</html>
