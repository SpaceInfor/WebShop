<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="BookingList.aspx.cs" Inherits="WebShop.BookingList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Booking List</title>

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

    <%--<script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script type="text/javascript">
        var userid = '';
        $(document).ready(function () {
            Bind_Booking_Headers();
            userid = '<%= Session["t_usid"] %>';
        });

        function changeform() {
            
            userid = '<%= Session["t_usid"] %>';
            if (userid == "ADMIN") {
                window.location = 'CSDashboard.aspx';
            }
            else {
                window.location = 'BuyerDashboard.aspx';
            }

      }
    </script>

    <script type="text/javascript">
        function Bind_Booking_Headers() {
            userid = '<%= Session["t_usid"] %>';
            if (userid != '') {
                $.ajax({
                    type: "POST",
                    url: "BookingList.aspx/GetBookingHeaders",
                    data: '{t_prbp: "' + userid + '"}',
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
                toastr.success('User id does not found');
            }
        }
        function OnSuccess(response) {
            $("#example1").DataTable(
                {
                    "responsive": false, "lengthChange": true, "autoWidth": false,
                    "deferRender": true, "paging": true,
                    "buttons": ["csv", "excel", "print", "colvis"],
                    data: response.d,
                    columns: [
                        { 'data': 't_link', 'title': '#' },
                        { 'data': 't_bkno', 'title': 'Booking No.' },
                        { 'data': 't_date', 'title': 'Booking Date' },
                        { 'data': 't_prbp', 'title': 'Showroom code' },
                        { 'data': 't_srep', 'title': 'Booking Sales Person Name' },
                        { 'data': 'scbpdesc', 'title': 'Customer Name' },
                        { 'data': 't_tdlg', 'title': 'Tentative date of login' },
                        { 'data': 't_amnt', 'title': 'Total Amount' },
                        { 'data': 't_advc', 'title': 'Advance Received' }

                    ]
                }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
        };
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">

    <%--<div class="block-header">
            <h2>Booking List</h2>
        </div>--%>
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Booked but not logged in</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#" onclick="changeform();">Home</a></li>
                        <li class="breadcrumb-item active">Booking List</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content-header">
        <section class="content">
            <div class="container-fluid">

                <div class="row">

                    <div class="col-md-12">
                        <div class="card card-warning card-outline">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;Booking List</h3>
                                <div class="card-tools">

                                    <a class="btn btn-block bg-gradient-warning" href="AddBooking.aspx">
                                        <i class="fa fa-fw fa-plus-circle"></i>Add
                                    </a>
                                </div>
                            </div>
                            <div class="card-body table-responsive p-0">
                                <table id="example1" class="table table-bordered table-striped ">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
        </section>
    </section>

    <!-- /.container-fluid -->

    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>

    <!-- jQuery -->

    <!-- Page specific script -->

    <%-- <script src="../../plugins/jquery/jquery.min.js"></script>--%>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->

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
    <!-- dropzonejs -->
    <script src="../../plugins/dropzone/min/dropzone.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../../dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="../../dist/js/demo.js"></script>
    <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>

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
    <!-- Page specific script -->

</asp:Content>
