<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="BookedbutnotloggedIn.aspx.cs" Inherits="WebShop.BookedbutnotloggedIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Booking Status Report</title>
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

    <%-- <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <!-- Font Awesome -->

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <script type="text/javascript">
      var userid = '';
      var UserName = '';
      $(document).ready(function () {

        //const urlParams = new URLSearchParams(window.location.search);
          //const bkno = urlParams.get('t_bkno');
          
          userid = '<%= Session["t_usid"] %>';
          if (userid != '' && userid !='ADMIN') {

              Bind_BookingWiseItemList(userid);
          }
          if (userid == 'ADMIN') {

              Bind_AdminBookingWiseItemList();
          }

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


    <script language="javascript">
      var ctrl;
      var username = '';
      function openChildProcess(control, form) {

        ctrl = control

        frm = form + ".aspx?param1=" + username + "";
        var left = (screen.width - 800) / 2;
        var top = (screen.height - 400) / 4;
        childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
      }
      function setValue(myVal) {
        //alert(myVal);

        document.getElementById(ctrl).value = myVal.replace("@", " ").replace("@", " ");

        $(document).ready(function () {

          document.getElementById(ctrl).onchange();
        });
      }

    </script>
    <script type="text/javascript">
      function Bind_BookingWiseItemList(t_usid) {
        
        $.ajax({

          type: "POST",
          url: "BookedbutnotloggedIn.aspx/BindBookingItemDetails",
          data: "{'t_prbp': '" + t_usid + "'}",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          //processData: false,
          success: function (data) {
            var datatableVariable = $('#tblBookingItems').DataTable({
              "responsive": true, "lengthChange": false, "autoWidth": false,
              "buttons": ["excel", "pdf", "print"],
              "bDestroy": true,
              data: data.d,
              columns: [
                  {
                    data: null, "title": "#", render: function (data, type, row, meta) {
                      return '<a href="AddBooking.aspx?t_bkno=' + row.t_bkno + '"><i class="far fa-plus-square"></i></a>';
                    }
                  },
                  //{ 'data': 't_link', 'title': '#' },
                  { "data": "t_bkno", "title": "Booking Number" },
                  { "data": "t_item", "title": "Item Code" },
                  { "data": "t_itemdsca", "title": "Item Description" },
                  { "data": "t_qoor", "title": "Quantity." },
                  { "data": "t_pric", "title": "Price" },
                  { "data": "t_oamt", "title": "Amount" },
                  { "data": "t_qtno", "title": "QTN Number" },
               
              

              ]
            }).buttons().container().appendTo('#tblBookingItems_wrapper .col-md-6:eq(0)');
          }
        });
      }

       function Bind_AdminBookingWiseItemList() {
        
        $.ajax({

          type: "POST",
          url: "BookedbutnotloggedIn.aspx/BindAllBookingDetails",
          //data: "{'t_prbp': '" + t_usid + "'}",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          //processData: false,
          success: function (data) {
            var datatableVariable = $('#tblBookingItems').DataTable({
              "responsive": true, "lengthChange": false, "autoWidth": false,
              "buttons": ["excel", "pdf", "print"],
              "bDestroy": true,
              data: data.d,
              columns: [
                  {
                    data: null, "title": "#", render: function (data, type, row, meta) {
                      return '<a href="AddBooking.aspx?t_bkno=' + row.t_bkno + '"><i class="far fa-plus-square"></i></a>';
                    }
                  },
                  //{ 'data': 't_link', 'title': '#' },
                  { "data": "t_bkno", "title": "Booking Number" },
                  { "data": "t_nama", "title": "Branch Name" },
                  { "data": "t_item", "title": "Item Code" },
                  { "data": "t_itemdsca", "title": "Item Description" },
                  { "data": "t_qoor", "title": "Quantity." },
                  { "data": "t_pric", "title": "Price" },
                  { "data": "t_oamt", "title": "Amount" },
                  { "data": "t_qtno", "title": "QTN Number" },
                  //{ "data": "BookStatus", "title": "Booking Status" },
                  //{

                  //  data: null, "title": "Booking Status", render: function (data, type, row, meta) {
                  //    //var CommStatus = "";
                  //    if (row.BookStatus == 'Logged') {

                  //      return '<div' + row.BookStatus + '" class="badge bg-warning">' + row.BookStatus + '</div>';
                  //    }
                  //    else if (row.BookStatus == 'Booked') {

                  //      return '<div' + row.BookStatus + '" class="badge bg-success">' + row.BookStatus + '</div>';
                  //    }
                  //  }
                  //},

              ]
            }).buttons().container().appendTo('#tblBookingItems_wrapper .col-md-6:eq(0)');
          }
        });
      }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Booked but not logged in</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#" onclick="changeform();">Home</a></li>
                        <li class="breadcrumb-item active">Booked but not logged in</li>
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
                                <h3 class="card-title">Booked but not logged in details</h3>
                                <div class="card-tools">
                                </div>
                            </div>

                            <div class="card-body">
                                <div class="row">
                                    <div class="card-body table-responsive p-0">
                                        <table id="tblBookingItems" class="table table-bordered table-striped ">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
    
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <script src="../../plugins/jquery/jquery.min.js"></script>
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
</asp:Content>



