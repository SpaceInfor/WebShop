<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="RMPlanningReport.aspx.cs" Inherits="WebShop.RMPlanningReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Warehouse Planning</title>

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
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

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
        function GetWarehouse() {

            var t_cwarcode = $("#t_cwar").val();
            $.ajax({
                url: "RMPlanningReport.aspx/GetWarehouseDes",
                data: '{t_cwar :"' + t_cwarcode + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_cwardesc").html("");
                        $("#t_cwar").val("");

                        //toastr.warning('Record not found...!!!');
                    }
                    else {
                        document.getElementById("t_cwardesc").innerHTML = response.d[0].t_dsca;
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
        function GetSupplier() {

            var t_otbpcode = $("#t_bpid").val();
            $.ajax({
              url: "RMPlanningReport.aspx/GetSupplierDes",
                data: '{t_otbp :"' + t_otbpcode + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_bpiddesc").html("");
                        $("#t_bpid").val("");

                        //toastr.warning('Record not found...!!!');
                    }
                    else {
                        document.getElementById("t_bpiddesc").innerHTML = response.d[0].t_nama;
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

    </script>


    <script type="text/javascript">
        $(document).ready(function () {
           
        });
    </script>
    <script type="text/javascript">
        function ViewReport() {
            
            var t_cwarcode = $("#t_cwar").val();
            var t_bpidcode = $("#t_bpid").val();
            if (t_bpidcode != "") {
                t_bpidcode = t_bpidcode;
            }
            else {
                t_bpidcode = "";
            }
            var checkBeloeMSl = '';
            if($("#chkMsl").prop('checked')) {
               
                checkBeloeMSl = 'B';
            }
            else {
                checkBeloeMSl = "";
            }
            $.ajax({

                type: "POST",
              url: "RMPlanningReport.aspx/GetWPlanningDetails",
                data: '{t_cwar :"' + t_cwarcode + '",t_bpid :"' + t_bpidcode + '",t_bmsl:"' + checkBeloeMSl + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tblWarehousePlanDetails').DataTable({
                        "responsive": false, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            { "data": "ItemGroup", "title": "Item Group" },
                            { "data": "ItemGroupDesc", "title": "Item Group Desc" },
                            { "data": "ItemCode", "title": "Item Code" },
                            { "data": "ItemDescription", "title": "Item Description" },
                            { "data": "UnitOfMeasure", "title": "Unit Of Measure" },
                            { "data": "SupplierCode", "title": "Supplier Code" },
                            { "data": "SupplierName", "title": "Supplier Name" },
                            { "data": "Warehouse", "title": "Warehouse" },
                            { "data": "OnHandInventory", "title": "On Hand Inventory" },
                            { "data": "AMC", "title": "AMC" },
                            { "data": "MSL", "title": "MSL" },
                            { "data": "ReOrderPoint", "title": "Re-Order Point" },
                            { "data": "SupplyTime", "title": "Supply Time" },
                            { "data": "Blocked", "title": "Blocked" },
                            { "data": "Allocated", "title": "Allocated" },
                            { "data": "OnOrder", "title": "On Order" },

                        ]
                      ,
                      "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                        if (parseFloat(aData['OnHandInventory']) < parseFloat(aData['MSL'])) {
                          
                          $('td', nRow).css('background-color', '#dc3545')
                          
                        }
                      }
                    }).buttons().container().appendTo('#tblWarehousePlanDetails_wrapper .col-md-6:eq(0)');
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
          <h1>RM Planning Report</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">RM Planning Report</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

  <section class="content">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="card card-outline card-warning">
                    <div class="card-header">
                        <h3 class="card-title">RM Planning Report Input Parameters</h3>
                    </div>
                    
                        <div class="card-body">
                          <div class="row">
                            <div class="col-sm-3">
                                <label for="exampleInputEmail1">Warehouse</label>
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="text" class="form-control" placeholder="Enter Warehouse" onchange="GetWarehouse();" id="t_cwar">
                                    </div>
                                    <div class="input-group-append">
                                        <button id="btnWarehouse" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_cwar','HelpPages/WarehouseList')"><i class="fa fa-fw fa-search"></i></button>
                                    </div>
                                </div>
                                <label id="t_cwardesc" for="css"></label>
                            </div>
                            <div class="col-sm-3">
                                <label for="exampleInputPassword1">Supplier</label>
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="text" class="form-control" placeholder="Enter Supplier" onchange="GetSupplier();" id="t_bpid">
                                    </div>
                                    <div class="input-group-append">
                                        <button id="btnSupplier" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_bpid','HelpPages/SupplierList')"><i class="fa fa-fw fa-search"></i></button>
                                    </div>
                                </div>
                                <label id="t_bpiddesc" for="css"></label>
                            </div>
                          </div>    
                          <div class="row">
                            <div class="col-sm-6">
                              <div class="form-group">
                                <div class="form-check">
                                  <input class="form-check-input" type="checkbox" id="chkMsl">
                                  <label class="form-check-label">Below MSL</label>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class="card-footer">
                            <button type="button" class="btn btn-warning" onclick="ViewReport();">View  Report</button>
                        </div>  
                </div>
              </div>
          </div>
          <div class="row">
            <div class="col-md-12">
               <div class="card card-outline card-warning">
                  <div class="card-header">
                      <h3 class="card-title">RM Planning Report</h3>
                  </div>
                
                <div class="card-body table-responsive p-0">
                    <table id="tblWarehousePlanDetails" class="table table-bordered table-striped ">
                    </table>
                </div>
              </div>
            </div>
        </div>
  </section>

    <!-- /.container-fluid -->
   <%-- <script>
        $(function () {
            bsCustomFileInput.init();
        });
    </script>--%>
    <!-- /.container-fluid -->
    <script src="plugins/daterangepicker/daterangepicker.js"></script>

    <!-- jQuery -->

    <!-- Page specific script -->

     <script src="../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
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
    <%--<script src="../../dist/js/demo.js"></script>--%>
    <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>

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
</asp:Content>
