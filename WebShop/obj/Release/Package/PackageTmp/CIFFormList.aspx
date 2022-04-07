<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCIF.Master" AutoEventWireup="true" CodeBehind="CIFFormList.aspx.cs" Inherits="AdminCIF.CIFFormList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CIF Form List</title>

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
   
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker.css">
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>
     <script type="text/javascript">
        var t_crus = '';
        $(document).ready(function () {
         
          
            t_crus = '<%= Session["t_usid"] %>';

            if (t_crus != null) {
                Bind_CIFFormDetails(t_crus);
            }
           

        });
    </script>
    <script type="text/javascript">
        function Bind_CIFFormDetails(t_crus) {
            debugger


            $.ajax({

                type: "POST",
                url: "CIFFormList.aspx/BindCIFForm",
                data: '{t_crus:"' + t_crus + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {

                    var datatableVariable = $('#tblCIFFormdetails').DataTable({

                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,

                        data: data.d,
                        columns: [
                            
                            { "data": "t_link", "title": "#" },
                            { "data": "t_bpid", "title": "Customer Id" },
                            { "data": "t_nama", "title": "Customer Name" },
                            //{ "data": "t_cbrn", "title": "LOB Line" },
                            {

                                data: null, "title": "LOB Line", render: function (data, type, row, meta) {
                                    var LOBStatus = "";
                                    if (row.t_cbrn == 1) {
                                        LOBStatus = "Home";
                                        return '<div' + LOBStatus + '" class="badge bg-success">' + LOBStatus + '</div>';
                                    }
                                    else {
                                        LOBStatus = "Kitchen";
                                        return '<div' + LOBStatus + '" class="badge bg-warning">' + LOBStatus + '</div>';
                                    }

                                }
                            },
                            { "data": "t_phne", "title": "Phone" },
                            { "data": "t_mail", "title": "E-Mail" },
                            { "data": "t_chan", "title": "Channel Code" },
                            { "data": "t_chandesc", "title": "Channel Name" },
                            { "data": "t_ln01", "title": "Billing Address 1" },
                            { "data": "t_ln02", "title": "Billing Address 2" },
                            { "data": "t_ccty", "title": "Billing Country code" },
                            { "data": "t_cctydesc", "title": "Billing Country" },
                            { "data": "t_cste", "title": "Billing State code" },
                            { "data": "t_cstedesc", "title": "Billing State" },
                            { "data": "t_ccit", "title": "Billing City code" },
                            { "data": "t_ccitdesc", "title": "Billing City" },
                            { "data": "t_pstc", "title": "Billing Pin Code" },
                            { "data": "t_bgst", "title": "Billing GST" },
                            { "data": "t_panu", "title": "PAN Number" },
                            { "data": "t_badd", "title": "Shipping  Address 1" },
                            { "data": "t_sadd", "title": "Shipping Address 2" },
                            { "data": "t_cntr", "title": "Shipping Country code" },
                            { "data": "t_cntrdesc", "title": "Shipping Country" },
                            { "data": "t_stte", "title": "Shipping State code" },
                            { "data": "t_sttedesc", "title": "Shipping State" },
                            { "data": "t_city", "title": "Shipping City code" },
                            { "data": "t_citydesc", "title": "Shipping City" },
                            { "data": "t_spin", "title": "Shipping Pin Code" },
                            { "data": "t_sgst", "title": "Shipping GST" },
                            { "data": "t_shsz", "title": "Showroom size" },
                            { "data": "t_prdd", "title": "Products Displayed" },
                            { "data": "t_brdd", "title": "Brands present" },
                            { "data": "t_find", "title": "Finishes Displayed" },
                            { "data": "t_swdi", "title": "Spacewood Display" },
                            { "data": "t_keye", "title": "Key Empolyees" },
                            { "data": "t_shfr", "title": "Showroom Frontage" },
                            { "data": "t_tofl", "title": "Total Floors" },
                            { "data": "t_cpay", "title": "Payment Terms Code" },
                            { "data": "t_cpaydesc", "title": "Payment Terms" },
                            { "data": "t_paym", "title": "Payment Mode Code" },
                            { "data": "t_paymdesc", "title": "Payment Mode" },
                            { "data": "t_crli", "title": "Credit Limit" },
                            { "data": "t_cday", "title": "Credit Days" },
                            { "data": "t_sals", "title": "Sales Segment Code" },
                            { "data": "t_salsdesc", "title": "Sales Segment" },
                            { "data": "t_crep", "title": "DH Coll Responsible Code" },
                            { "data": "t_crepdesc", "title": "DH Coll Responsible" },
                            { "data": "t_osrp", "title": "Sales Coll Responsible Code" },
                            { "data": "t_osrpdesc", "title": "Sales Coll Responsible" },
                            { "data": "t_emsr", "title": "Email Sales Representative" },
                            { "data": "t_cntp", "title": "Contact Person" },
                            { "data": "t_cnmo", "title": "Contact Person Mobile No." },
                            { "data": "t_cnem", "title": "Contact Person Email" },
                            { "data": "t_namd", "title": "Name Of Director" },
                            { "data": "t_remk", "title": "Remark" },
                            //{ 'data': null, "title": 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" data-toggle="modal" data-target="#exampleModal" onclick="Bind_CIFForm_Lines(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                            { 'data': null, "title": 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-danger btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } }

                        ]

                    }).buttons().container().appendTo('#tblCIFFormdetails_wrapper .col-md-6:eq(0)');
                }
            }
            );
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
   <div class="container-fluid">
        <div class="block-header">
            <h2>CIF Form Details</h2>
        </div>

        <div class="row">

            <div class="col-md-12">
                <div class="card card-warning card-outline">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;CIF Form List</h3>
                        <div class="card-tools">

                            <a class="btn btn-block bg-gradient-warning" href="LOBCIFForm.aspx">
                                <i class="fa fa-fw fa-plus-circle"></i>Add
                            </a>
                        </div>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table id="tblCIFFormdetails" class="table table-bordered table-striped ">
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
    </div>
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
   <%-- <script src="../../dist/js/demo.js"></script>--%>
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
