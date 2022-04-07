<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSComplaintList.aspx.cs" Inherits="WebShop.CSComplaintList" %>

<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
   <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">


    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

    <%-- <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  

   <%-- <script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>--%>

    <%--<script src="Scripts/sum.js"></script>--%>

    <title>ORDER DASHBOARD REPORT</title>
    <script type="text/javascript">
      $(document).ready(function () {
        debugger
        Bind_Complaint_Lines('A');
        BindStatusData();
      });

    </script>
    <script type="text/javascript">
      function BindStatusData() {
        debugger
        $.ajax({
          type: "POST",
          url: "CSComplaintList.aspx/GetStatusDetails",
          data: '{ }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {
            if (response.d != '') {
              var orno = JSON.parse(response.d);
              $('#t_open').html(orno.t_open);
              $('#t_inpr').html(orno.t_inpr);
              $('#t_clos').html(orno.t_clos);
              $('#t_pnfs').html(orno.t_pnfs);
              $('#t_pnfu').html(orno.t_pnfu);
              $('#t_papr').html(orno.t_papr);

            }
            else {
              $('#t_open').html('0');
              $('#t_inpr').html('0');
              $('#t_clos').html('0');
              $('#t_pnfs').html('0');
              $('#t_pnfu').html('0');
              $('#t_papr').html('0');
            }
          },
          error: function (response) {
            alert(response.responseText);
          }
        });
      }
    </script>



    <script type="text/javascript">
      function Bind_Complaint_Lines(flag) {
        debugger
        $.ajax(
          {
            type: "POST",
            url: "CSComplaintList.aspx/GetComplaintLines",
            data: '{t_flag: "' + flag + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: BindTable,
            failure: function (response) {
              alert(response.d);
            },
            error: function (response) {
              alert(response.d);
            }
          });
      }
      function BindTable(response) {
        debugger
        $("#example2").DataTable(
          {
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["excel", "pdf", "print"],
            "bDestroy": true,
            data: response.d,
            columns: [
              { 'data': null, title: 'Select', wrap: true, "render": function (item) { return '<a href="CSComplaint.aspx?t_cono=' + item.t_cono + '"><i class="far fa-plus-square"></i></a>' } },
              { 'data': 't_cono', 'title': 'Complaint No' },
              { 'data': 't_codt', 'title': 'Complaint Date' },
              { 'data': 't_worn', 'title': 'CPS No' },
              { 'data': 't_orno', 'title': 'Sales Order' },
              { 'data': 't_nama', 'title': 'Branch Name' },

              {

                data: null, "title": "Severity", render: function (data, type, row, meta) {

                  if (row.t_prio == 'High') {

                    return '<div class="badge bg-danger">' + row.t_prio + '</div>';
                  }
                  else if (row.t_prio == 'Medium') {

                    return '<div class="badge bg-warning">' + row.t_prio + '</div>';
                  }
                  else {

                    return '<div class="badge bg-success">' + row.t_prio + '</div>';
                  }

                }
              },

              { 'data': 't_comt', 'title': 'Complaint Text' },
              { 'data': 't_rsol', 'title': 'Redressal' },
              { 'data': 't_cldt', 'title': 'Redressal Date' },
              { 'data': 't_cost', 'title': 'Status' },
              { 'data': null, title: 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_cono + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },
            ]
          }).buttons().container().appendTo('#tbltask_wrapper .col-md-6:eq(0)');
      };
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">

    <div class="content">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Customer Complaint List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="CSDashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Customer Complaint List</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </div>

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8">
                        <div class="card card-warning card-outline">
                            <div class="card-header">
                                Customer Complaints
                <div class="card-tools">
                </div>
                            </div>
                            <div class="card-body table-responsive p-0">
                                <table id="example2" class="table table-bordered table-striped">
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <!-- Info Boxes Style 2 -->
                        <div class="info-box mb-3 bg-light color-palette">
                            <span class="info-box-icon"><i class="far fa-folder-open"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Open Complaints</span>
                                <a href="javascript:Bind_Complaint_Lines('1')">
                                    <h3 class="headline text-warning" id="t_open">0</h3>
                                </a>
                            </div>
                        </div>
                        <!-- /.info-box -->
                        <div class="info-box mb-3 bg-light color-palette">


                            <span class="info-box-icon"><i class="fas fa-spinner"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">In Process Complaint</span>
                                <a href="javascript:Bind_Complaint_Lines('2')">
                                    <h3 class="headline text-info" id="t_inpr">0</h3>
                                </a>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <div class="info-box mb-3 bg-light color-palette">

                            <span class="info-box-icon"><i class="far fa-check-square"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Closed Complaints</span>
                                <a href="javascript:Bind_Complaint_Lines('3')">
                                    <h3 class="headline text-success" id="t_clos">0</h3>
                                </a>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->
                        <div class="info-box mb-3 bg-light color-palette">
                            <span class="info-box-icon"><i class="fas fa-hourglass-end"></i></span>

                            <div class="info-box-content">
                                <span class="info-box-text">Awaiting Response from Service</span>
                                <a href="javascript:Bind_Complaint_Lines('C')">
                                    <h3 class="headline text-danger" id="t_pnfs">0</h3>
                                </a>
                            </div>
                            <!-- /.info-box-content -->
                        </div>

                        <!-- /.info-box -->
                        <div class="info-box mb-3 bg-light color-palette">
                            <span class="info-box-icon"><i class="fas fa-hourglass-start"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Awaiting Response from Customer</span>
                                <a href="javascript:Bind_Complaint_Lines('S')">
                                    <h3 class="headline text-muted" id="t_pnfu">0</h3>
                                </a>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <div class="info-box mb-3 bg-light color-palette">
                            <span class="info-box-icon"><i class="fa fa-fw fa-check-square"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Awaiting FOC Approval</span>
                                <a href="javascript:Bind_Complaint_Lines('U')">
                                    <h3 class="headline text-muted" id="t_papr">0</h3>
                                </a>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- ChartJS -->
    <script src="plugins/chart.js/Chart.min.js"></script>
    <!-- Sparkline -->
    <script src="plugins/sparklines/sparkline.js"></script>
    <!-- JQVMap -->
    <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
    <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <!-- daterangepicker -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
    <script src="plugins/summernote/summernote-bs4.min.js"></script>
    <!-- overlayScrollbars -->
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.js"></script>


    <!-- AdminLTE for demo purposes -->

    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="plugins/toastr/toastr.min.js"></script>




    <!-- Select2 -->
    <%--  <script src="../../plugins/select2/js/select2.full.min.js"></script>--%>
    <!-- Bootstrap4 Duallistbox -->
    <script src="../../plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <script src="../../plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="../../plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="../../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Bootstrap Switch -->
    <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <!-- BS-Stepper -->
    <script src="../../plugins/bs-stepper/js/bs-stepper.min.js"></script>
   <!-- DataTables  & Plugins -->
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

</asp:Content>
