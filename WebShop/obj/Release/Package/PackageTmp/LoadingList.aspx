  <%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="LoadingList.aspx.cs" Inherits="WebShop.LoadingList" %>
   <!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
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
      <script type="text/javascript">
       $(document).ready(function () {
         Bind_Loading_Headers();
       });
      </script>
  <script type="text/javascript">
    function btnNew_Click()
    {
    
      location.replace("https://localhost:44367/LoadingSlip.aspx")
    }
      </script>
     <script type="text/javascript">
       function Bind_Loading_Headers() {
         $.ajax({
           type: "POST",
           url: "LoadingList.aspx/GetLoadingHeader",
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
             "responsive": false, "lengthChange": true, "autoWidth": false,
             "deferRender": true, "paging": true,
             "buttons": ["csv", "excel", "print", "colvis"],
             data: response.d,
             columns: [
                {'data': 't_link', 'title': '#' },
                {'data': 't_load', 'title': 'Load ID'},
                {'data': 't_stat', 'title': 'Status' },
                {'data': 't_orno', 'title': 'Sales Order'},
                {'data': 't_ofbp', 'title': 'Customer'},
                {'data': 't_stbp', 'title': 'Consignee'},
                {'data': 't_carp', 'title': 'Transporter'},
                {'data': 't_date', 'title': 'Load Date'},
                {'data': 't_dest', 'title': 'Destination'},
                {'data': 't_lyno', 'title': 'Vehicle No'},
                {'data': 't_lrno', 'title': 'LR No'},
                {'data': 't_lrdt', 'title': 'LR Date'},
                {'data': 't_npak', 'title': 'No Of Packets'},
                {'data': 't_lopk', 'title': 'No of Loaded Packets'}
              ]
           }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
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
  <div class="content-wrapper">
    <div class="content-header">
      <div class="container">
          
      </div>
    </div>
    <div class="content">
      <div class="container">
        <div class="row">
          <!-- /.col-md-6 -->
 
          <div class="col-lg-12">
            <div class="card card-warning card-outline">
              <div class="card-header">
                <h3 class="card-title"><i class="fas fa-table"></i> &nbsp;Loading List</h3>
                <div class="card-tools">
                  <a class="btn btn-block bg-gradient-warning" href="ViewLoadingSlip.aspx">
                    <i class="fas fa-binoculars"></i> View Loading Slip
                  </a>
                  <a class="btn btn-block bg-gradient-warning" href="LoadingSlip.aspx">
                    <i class="fa fa-fw fa-plus-circle"></i> Add
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
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="float-right d-none d-sm-inline">

    </div>
    <!-- Default to the left -->
   
  </footer>
  </form>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.3/highlight.min.js"></script>
      <script src="Scripts/html5-qrcode.min.js"></script>
      <script type="text/javascript">

        function onScanSuccess(qrCodeMessage) {
          document.getElementById("t_boxs").value = qrCodeMessage;

          document.getElementById("t_boxs").focus();
          AddLoad();
          //   SaveLoadingHeaderLiner();


          html5QrCode.stop().then((ignore) => {
            // QR Code scanning is stopped.
          }).catch((err) => {
            // Stop failed, handle it.
          });
          const config = { fps: 20, qrbox: 200 };

          // If you want to prefer front camera
          html5QrCode.start({ facingMode: "environment" }, config, onScanSuccess); //// IMPORTANT CODE
          html5QrCode.clear();
          // If you want to prefer back camera
          //html5QrCode.start({ facingMode: "environment" }, config, qrCodeSuccessCallback);

          //}
        }
        function onScanError(errorMessage) {
          //handle scan error
        }
        //var html5QrcodeScanner = new Html5QrcodeScanner(  sameer commented this
        //    "reader", { fps: 30, qrbox: 100 });

        const html5QrCode = new Html5Qrcode("reader");

        const qrCodeSuccessCallback = (decodedText, decodedResult) => {
          /* handle success */
        };
        const config = { fps: 20, qrbox: 200 };

        // If you want to prefer front camera
        html5QrCode.start({ facingMode: "environment" }, config, onScanSuccess); //// IMPORTANT CODE
        html5QrCode.clear();
      </script>
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    
        <!-- jQuery -->

    <!-- Page specific script -->

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
    <script>
    $(function () {
      //Initialize Select2 Elements
      $('.select2').select2()

      //Initialize Select2 Elements
      $('.select2bs4').select2({
        theme: 'bootstrap4'
      })

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
    //Money Euro
    $('[data-mask]').inputmask()

    //Date picker
    //$('#reservationdate').datetimepicker({
    //  format: 'L'

    //});

    $("#reservationdate").datepicker("setDate", new Date());
    //Date and time picker
    $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });

    //Date range picker
    $('#reservation').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        format: 'MM/DD/YYYY hh:mm A'
      }
    })
    //Date range as a button
    $('#daterange-btn').daterangepicker(
      {
        ranges: {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days': [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment().subtract(29, 'days'),
        endDate: moment()
      },
      function (start, end) {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
      }
    )

    //Timepicker
    $('#timepicker').datetimepicker({
      format: 'LT'
    })

    //Bootstrap Duallistbox
    $('.duallistbox').bootstrapDualListbox()

    //Colorpicker
    $('.my-colorpicker1').colorpicker()
    //color picker with addon
    $('.my-colorpicker2').colorpicker()

    $('.my-colorpicker2').on('colorpickerChange', function (event) {
      $('.my-colorpicker2 .fa-square').css('color', event.color.toString());
    })

    $("input[data-bootstrap-switch]").each(function () {
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    })

  })
  // BS-Stepper Init
  document.addEventListener('DOMContentLoaded', function () {
    window.stepper = new Stepper(document.querySelector('.bs-stepper'))
  })

  // DropzoneJS Demo Code Start
  Dropzone.autoDiscover = false

  // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
  var previewNode = document.querySelector("#template")
  previewNode.id = ""
  var previewTemplate = previewNode.parentNode.innerHTML
  previewNode.parentNode.removeChild(previewNode)

  var myDropzone = new Dropzone(document.body, { // Make the whole body a dropzone
    url: "/target-url", // Set the url
    thumbnailWidth: 80,
    thumbnailHeight: 80,
    parallelUploads: 20,
    previewTemplate: previewTemplate,
    autoQueue: false, // Make sure the files aren't queued until manually added
    previewsContainer: "#previews", // Define the container to display the previews
    clickable: ".fileinput-button" // Define the element that should be used as click trigger to select files.
  })

  myDropzone.on("addedfile", function (file) {
    // Hookup the start button
    file.previewElement.querySelector(".start").onclick = function () { myDropzone.enqueueFile(file) }
  })

  // Update the total progress bar
  myDropzone.on("totaluploadprogress", function (progress) {
    document.querySelector("#total-progress .progress-bar").style.width = progress + "%"
  })

  myDropzone.on("sending", function (file) {
    // Show the total progress bar when upload starts
    document.querySelector("#total-progress").style.opacity = "1"
    // And disable the start button
    file.previewElement.querySelector(".start").setAttribute("disabled", "disabled")
  })

  // Hide the total progress bar when nothing's uploading anymore
  myDropzone.on("queuecomplete", function (progress) {
    document.querySelector("#total-progress").style.opacity = "0"
  })

  // Setup the buttons for all transfers
  // The "add files" button doesn't need to be setup because the config
  // `clickable` has already been specified.
  document.querySelector("#actions .start").onclick = function () {
    myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED))
  }
  document.querySelector("#actions .cancel").onclick = function () {
    myDropzone.removeAllFiles(true)
  }
  // DropzoneJS Demo Code End
    </script>
</body>
</html>
