  <%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="LoadingSlip.aspx.cs" Inherits="WebShop.LoadingSlip" %>
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
           debugger
           const urlParams = new URLSearchParams(window.location.search);
           const myParam = urlParams.get('t_stat');
           const loadid = urlParams.get('load');
           if (myParam == 'F')
           {
             $('#form1 :input').attr('readonly', 'readonly');
           }

           if (loadid != null)
           {
             Bind_Loading_Headers(loadid);
             $("#t_orno").prop("disabled", true);
             $("#btnMorn").prop("disabled", true);
           }
         });
  </script>

  <script type="text/javascript">
    function validate()
    {
      if (document.getElementById("t_orno").value == '')
      {
        toastr.error('Please select Sales Order No');
        return false;
      }
      return true;
    }
  </script>
    <script type="text/javascript">
       function Bind_Loading_Lines() {
         $.ajax({
           type: "POST",
           url: "LoadingSlip.aspx/GetLoadingLines",
           data: '{t_orno: "' + document.getElementById("t_orno").value + '"}',
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
             destroy: true,
             "responsive": true, "lengthChange": true, "autoWidth": false,
             "deferRender": true, "paging": true,
             "buttons": ["csv", "excel", "print", "colvis"],
             "order": [[3, 'asc']],
             data: response.d,
             columns: [
               { 'data': 't_desc', 'title': 'Item' },
               { 'data': 't_bqty', 'title': 'Qty' },
              
               { 'data': 't_boxn', 'title': 'Box No' },
                { 'data': 't_cuni', 'title': 'UOM' }
             ]
             ,
             "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
               switch (aData['t_scst']) {
                 case 'Y':
                   $('td', nRow).css('background-color', '#218838')
                   break;
               }
             }
           }).buttons().container().appendTo('#example1_wrapper .col-lg-6:eq(0)');;
       };

    </script>

    <script type = "text/javascript">
            function FinalizeLoad() {
              $.ajax(
                {
                  type: "POST",
                  url: "LoadingSlip.aspx/FinalizeLoading",
                  data: '{t_load: "' + document.getElementById("loadid").innerHTML.toString() + '"}',

                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: ShowFinalizeData,
                  failure: function (response) {
                    alert(response.d);
                  }
                });
            }
            function ShowFinalizeData(response) {
              
              toastr.success(response.d.toString());
              $('#form1 :input').attr('readonly', 'readonly');
             
            }
     </script>  
    
    <script type = "text/javascript">
      function AddLoad() {
        var load_id = $("#loadid").text();
         $.ajax(
           {
             type: "POST",
             url: "LoadingSlip.aspx/ProcessIT",
             data: '{t_load: "' + load_id + '",t_orno: "' + document.getElementById("t_orno").value + '",t_carp: "' + document.getElementById("t_carp").value + '",t_lyno:"' + document.getElementById("t_lyno").value.toString() + '",t_lrno:"' + document.getElementById("t_lrno").value + '",t_lrdt:"' + document.getElementById("t_lrdt").value + '",t_boxs:"' + document.getElementById("t_boxs").value + '"}',

             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: ShowLoadingData,
             failure: function (response) {
               alert(response.d);
             }
           });
       }
       function ShowLoadingData(response) {
         $('#loadid').html(response.d[0].toString());
         $('#lblt_lopk').html(response.d[2].toString());
         if (response.d[1].toString().trim() != 'Scanned Successfully') {
           toastr.error(response.d[1].toString());

         }
         else {
           toastr.success(response.d[1].toString());
           $("#t_orno").prop("disabled", true);
           $("#btnMorn").prop("disabled", true);
         }
         Bind_Loading_Lines();

       }
    </script> 
    <script type="text/javascript">
    function getSoDetails(salesorderno) {

      var name = salesorderno
      $.ajax({
        type: "POST",
        url: "LoadingSlip.aspx/GetSalesOrderDetails",
        data: '{t_orno: "' + name + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
          if (response.d != '') {
            var orno = JSON.parse(response.d);
            $('#lblt_ofbp').html(orno.t_ofbp);
            $('#lblt_stbp').html(orno.t_stbp);
            $('#lblt_dest').html(orno.t_dest);
            $('#lblt_nopk').html(orno.t_nopk);
            Bind_Loading_Lines();
          }
          else {
            $('#lblt_ofbp').html('no datafound');
          }
        },
        error: function (response) {
          alert(response.responseText);
        }
      });
    }
  </script>
    <script type="text/javascript">
      function getcarriername(t_cfrw) {
        $.ajax({
          type: "POST",
          url: "LoadingSlip.aspx/getcarriername",
          data: '{t_cfrw: "' + t_cfrw + '" }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {
            if (response.d != '') {
              // var cfrw = JSON.parse(response.d);
              $('#t_carp_nama').html(response.d.toString());
            }
            else {
              $('#t_carp_nama').html('no datafound');
            }
          },
          error: function (response) {
            alert(response.responseText);
          }
        });
      }

  </script>
    <script language="javascript">
    var ctrl
    function openChild(control, form) {
      ctrl = control
      frm = form + ".aspx?param1=" + document.getElementById("t_carp").value.toString();
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
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
  </script>
    <script type="text/javascript">
        function Bind_Loading_Headers(loadno) {
          $.ajax({
            type: "POST",
            url: "LoadingSlip.aspx/GetLoadingHeader",
            data: '{t_load: "' + loadno + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response)
            {
              if (response.d != '')
              {
                var orno = JSON.parse(response.d);
                $('#loadid').html(orno.t_load);
                document.getElementById("t_orno").value = orno.t_orno;
                $('#lblt_ofbp').html(orno.t_ofbp);
                $('#lblt_stbp').html(orno.t_stbp);
                $('#lblt_date').html(orno.t_date);
                $('#lblt_dest').html(orno.t_dest);
                $('#lblt_nopk').html(orno.t_npak);
                $('#lblt_lopk').html(orno.t_lopk);
                document.getElementById("t_carp").value = orno.t_carp;
                document.getElementById("t_lyno").value = orno.t_lyno;
                document.getElementById("t_lrno").value = orno.t_lrno;
                document.getElementById("t_lrdt").value = orno.t_lrdt;
                Bind_Loading_Lines();
              }
            },
            failure: function (response) {
              alert(response.d);
            },
            error: function (response) {
              alert(response.d);
            }
          });
        }


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
  <form id="form1">
  <div class="content-wrapper">

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
    <div class="content">
      <div class="container">
        <div class="row">
          <!-- /.col-md-6 -->
          <div class="col-lg-6">
              <div class="card card-warning card-outline">
                <div class="card-header">
                  <h3 class="card-title"><i class="fas fa-truck-loading"></i>&nbsp;Details</h3>
                  <div class="card-tools">
                 <span class="badge badge-warning"> Load No :</span>&nbsp; <span class="float-right username"><label id="loadid"></label></span>
                  </div>
                </div>
                <div class="card-body">
                  <div class="col-lg-6">
                    <div class="form-group">
                      <label>Sales Order</label>  
                      <div class="input-group">
                        <input type="text" id="t_orno" onChange='getSoDetails(this.value)' class="form-control"/>
                        <div class="input-group-append">
                          <button id="btnMorn" type="button"  class="btn btn-block btn-warning" onclick="openChild('t_orno','HelpPages/tdsls4500m001')"><i class="fa fa-fw fa-search"></i></button>
                        </div>  
                      </div>
                    </div>
                  </div>
                
                </div>
                <div class="card">
             
                <!-- /.card-header -->
                <div class="card-body table-responsive p-0">
                  <table class="table table-sm table table-striped">
                  
                    <tbody>
                      <tr>
                        <td><i class="fab fa-intercom"></i></td>
                        <td> <label for="lblt_ofbp">Customer</label></td>
                        <td>
                          <div class="badge bg-warning">
                           <label id="lblt_ofbp" ></label>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td><i class="fas fa-shipping-fast"></i></td>
                        <td> <label for="lblt_stbp">Consignee</label> </td>
                        <td>
                           <div class="badge bg-warning">
                            <label id="lblt_stbp" ></label>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td><i class="fas fa-map-marker-alt"></i></td>
                        <td> <label for="lblt_dest">Dest</label> </td>
                        <td>
                            <div class="badge bg-warning">
                              <label id="lblt_dest" ></label>
                            </div>
                        </td>
                      </tr>
                      <tr>
                        <td><i class="fas fa-box"></i></td>
                        <td><label for="lblt_nopk">Packets</label></td>
                        <td>
                          <div class="badge bg-warning">
                           <label id="lblt_nopk" ></label>
                          </div>
                        </td>
                       
                      </tr>
                    </tbody>
                  </table>
                </div>
                <!-- /.card-body -->
              </div>
              </div>
            </div>
          <div class="col-lg-6">
              <div class="card card-warning card-outline">
                 <div class="card-header">
                  <h3 class="card-title"><i class="fas fa-truck-moving"></i>&nbsp;LR Details</h3>
                  <div class="card-tools">
                    <span class="float-right username"><a href="#" id="asssa"></a></span>
                  </div>
                </div>
                <div class="card-body">
                <div class="row">
                  <div class="col-5">
                      <div class="form-group">
                        <label>Transporter</label>  
                        <div class="input-group">
                          <input type="text" id="t_carp" class="form-control" onChange='getcarriername(this.value)'  placeholder="Add Transporter Here" />
                          <div class="input-group-append">
                            <button id="btnofbp" type="button" class="btn btn-block btn-warning" onclick="openChild('t_carp','HelpPages/tcmcs0580m000')"><i class="fa fa-fw fa-search"></i></button>
                          </div>  
                        </div> 
                        &nbsp;<label id="t_carp_nama" class="link-black text-sm"></label>
                      </div>
                    </div>   
                  <div class="col-5">
                    <div class="form-group">
                      <label>Vehicle No</label>  
                      <div class="input-group">
                        <input type="text" ID="t_lyno"  class="form-control" placeholder="Add Lorry No"/>
                      </div>                      
                 
                    </div>
                  </div>
                  </div>
                <div class="row">
                  <div class="col-5">
                    <div class="form-group">
                      <label>LR Number</label>  
                      <div class="input-group">
                       <input type="text" ID="t_lrno"  class="form-control" placeholder="Add Lorry No"/>
                    </div>                      
                  </div>
                </div>
                  <div class="col-5">
                    <div class="form-group">
                    <label>LR Date</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                        </div>  
                        <input id="t_lrdt" type="date" class="form-control">
                      </div>
                    </div>
            
                  </div>
                  </div>
                </div>
                 <div class="card-footer">
                   <i class="fas fa-boxes"></i> &nbsp;<span class="badge badge-success">Total Loaded Packets : </span>&nbsp;<label id="lblt_lopk" ></label>
                 </div>
             </div>
            </div>
          <div class="col-lg-6">
              <div class="card card-warning card-outline">
              <div class="card-header">
                  <h3 class="card-title"><i class="fas fa-qrcode"></i> &nbsp; Scan</h3>
                  <div class="card-tools">
                    <label for="t_boxs">Box No</label> &nbsp;<input type="text" value="" id="t_boxs"  maxlength="12"/>
                  </div>
              </div>
              <div class="card-body">
			          <div id="reader"></div>
			          <div class="empty"></div>
			          <div id="scanned-result"></div>
                </div>
              </div>

		      </div>
          <div class="col-lg-6">
            <div class="card card-warning card-outline">
              <div class="card-header">
                <h3 class="card-title"><i class="fas fa-table"></i> &nbsp;Scanned Lines</h3>
                <div class="card-tools">

                </div>
              </div>
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped ">
                </table>
              </div>
            </div>
           </div>
          <div class="col-md-12">

            <div class="card card-warning card-outline">
               <div class="card-body">
                <button  id="btnAdd" type="button" class="btn btn-warning float-left toastrDefaultSuccess" onclick = "FinalizeLoad();">Finalize Loading</button>
                </div>
            </div>
          </div>

          <!-- /.col-md-6 -->
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
          if (validate() == true)
          {
          
            AddLoad();
          }
          //   SaveLoadingHeaderLiner();


          html5QrCode.stop().then((ignore) => {
            // QR Code scanning is stopped.
          }).catch((err) => {
            // Stop failed, handle it.
          });
          const config = { fps: 100, qrbox: 250 };

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
        const config = { fps: 100, qrbox: 250 };

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
