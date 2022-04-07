<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="ComplaintClientReport.aspx.cs" Inherits="WebShop.ComplaintClientReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Datewise Complaint Report</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>


    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- daterange picker -->
    <%-- <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">--%>
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    da
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="../../plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- Bootstrap4 Duallistbox -->
    <link rel="stylesheet" href="../../plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
    <!-- BS Stepper -->
    <link rel="stylesheet" href="../../plugins/bs-stepper/css/bs-stepper.min.css">
    <!-- dropzonejs -->
    <link rel="stylesheet" href="../../plugins/dropzone/min/dropzone.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <!-- Toastr -->
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <script type="text/javascript">

        function Bind_ComplaintDetails() {
            
            var t_crus = '<%= Session["t_usid"] %>';
            var t_codtF = document.getElementById("t_codtF").value;
            var t_codtT = document.getElementById("t_codtT").value;
            //if (t_crus != "" && t_codtF != "" && t_codtT != "") {
            if (t_crus != "" && t_codtF != "" && t_codtT != "") {

                $.ajax({

                    type: "POST",
                    url: "ComplaintClientReport.aspx/GetComplaintDetails",
                    data: '{t_prbp:"' + t_crus + '",t_codtF:"' + t_codtF + '",t_codtT:"' + t_codtT + '"}',
                    //
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $("#viewdatatable").css('display', 'block');
                        var datatableVariable = $('#tblComplaintDetails').DataTable({

                            "responsive": true, "lengthChange": false, "autoWidth": true,
                            "buttons": ["excel", "pdf", "print"],
                            "bDestroy": true,

                            data: data.d,
                            columns: [


                                { "data": "t_cono", "title": "Complaint No" },
                                { "data": "t_codt", "title": "Complaint Date" },
                                { "data": "t_worn", "title": "CPS Order No" },
                                { "data": "t_orno", "title": "Sales Order" },
                                { "data": "t_prbp", "title": "Customer Id" },
                                { "data": "t_nama", "title": "Customer Name" },
                                { "data": "t_comt", "title": "Complaint Text" },
                                { "data": "t_rsol", "title": "Complaint Redressal" },
                                //{ "data": "t_cost", "title": "Complaint Status" },
                                {
                                    data: null, "title": "Complaint Status", render: function (data, type, row, meta) {
                                        return '<div' + row.t_cost + '" class="badge bg-warning">' + row.t_cost + '</div>';
                                    }
                                },
                                //{ "data": "t_prio", "title": "Priority" },
                                {
                                    data: null, "title": "Priority", render: function (data, type, row, meta) {
                                        return '<div' + row.t_prio + '" class="badge bg-danger">' + row.t_prio + '</div>';
                                    }
                                },
                                { "data": "t_cldt", "title": "Closure Date" },
                                { "data": "t_user", "title": "User Id" },
                                { "data": "t_namauser", "title": "User Name" },
                                //{ "data": "t_ackn", "title": "Acknowledge" },
                                { "data": "t_lmdt", "title": "Last Modification Date" },
                                //{ "data": "t_appr", "title": "Status" },
                                //{ "data": "t_reco", "title": "Recommend For FOC" },
                                { "data": "t_pono", "title": "Position" },
                                //{ "data": "t_date", "title": "Update Date" },
                                {

                                    data: null, "title": "Update Date", render: function (data, type, row, meta) {
                                        var udateStatus = "";
                                        if (row.t_date == "") {

                                            udateStatus = "Not Updated";
                                            return '<div' + udateStatus + '" class="badge bg-warning">' + udateStatus + '</div>';
                                        }
                                        else {
                                            udateStatus = row.t_date;
                                            return '<div' + udateStatus + '" class="badge bg-success">' + udateStatus + '</div>';
                                        }

                                    }
                                },
                                { "data": "t_rsolLine", "title": "Complaint Redressal Line" },
                                { "data": "t_userd", "title": "Closed By User Id" },
                                { "data": "updatedUser", "title": "Closed By User" },

                                //{ 'data': null, "title": 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" data-toggle="modal" data-target="#exampleModal" onclick="Bind_CIFForm_Lines(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                                //{ 'data': null, "title": 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-danger btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } }

                            ]

                        }).buttons().container().appendTo('#tblComplaintDetails_wrapper .col-md-6:eq(0)');
                    }
                });

            }
            else {
                toastr.error("Please select From date and To date");
            }
        }
    </script>

    <script type="text/javascript">
        function checkFromDate() {

            var FromDate = document.getElementById("t_codtF").value;
            var ToDate = document.getElementById("t_codtT").value;
            
            if (FromDate != "" && ToDate != "") {
                if (FromDate > ToDate) {
                    toastr.error('From date should not be greater than To date.');
                    document.getElementById("t_codtF").value = "";
                }
            }


        }
        function checkToDate() {
            if (FromDate != "" && ToDate != "") {
                var FromDate = document.getElementById("t_codtF").value;
                var ToDate = document.getElementById("t_codtT").value;
                if (ToDate < FromDate) {
                    toastr.error('To date should not be Less than From date.');
                    document.getElementById("t_codtT").value = "";
                }
            }
        }
    </script>

    <script type="text/javascript">
        var t_crus = '';
        $(document).ready(function () {
            t_crus = '<%= Session["t_usid"] %>';
            $("#viewdatatable").css('display', 'none');
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Complaint report</h1>

                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="BuyerDashboard.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Complaint Report</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <section class="content-header">
            <div class="container-fluid">

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;View Complaint Report</h3>
                                <div class="card-tools">
                                    <%--  <span class="badge badge-warning">Customer Id :</span>&nbsp; <span class="float-right username">
                                        <label id="t_bpid_id" style="color: darkblue"></label>
                                    </span>--%>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="0">
                                            <label>From date</label>
                                            <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                                <input type="date" class="form-control" data-target="#reservationdate" id="t_codtF" onchange="checkFromDate();"/>
                                                <%-- <input type="text" class="form-control datetimepicker-input DOBdtpicker" data-target="#reservationdate" id="t_codtF">
                                                <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                </div>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">

                                        <div class="form-group" tabindex="0">
                                            <label>To date</label>
                                            <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                                <input type="date" class="form-control" data-target="#reservationdate" id="t_codtT" onchange="checkToDate();"/>
                                                <%--<input type="text" class="form-control datetimepicker-input DOBdtpicker" data-target="#reservationdate1" id="t_codtT">
                                                <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                </div>--%>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <input type="button" class="btn btn-warning waves-effect" onclick="Bind_ComplaintDetails();" id="btnViewReport" value="View" tabindex="2" />
                            </div>

                        </div>
                    </div>
                    <div class="col-md-12" id="viewdatatable">
                        <div class="card card-outline card-warning">
                            <div class="card-header">

                                <h3 class="card-title"><b><span id="t_taskname1"></span>View Complaint Details</b></h3>
                                <div class="card-tools">
                                    <%--  <span class="float-right username"><a href="#" id="taskid"></a></span>--%>
                                </div>
                            </div>
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card card-outline">
                                            <div class="card-header">
                                                <div class="card-tools">
                                                </div>
                                            </div>

                                            <div class="card-body table-responsive p-0">
                                                <table class="table table-bordered table-striped" id="tblComplaintDetails">
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </section>
    </section>
    <script>
        $(function () {
            //$('.summernote').summernote();
            //Initialize Select2 Elements
            $('.select2').select2()

            //Initialize Select2 Elements
            $('.select2bs4').select2({
                theme: 'bootstrap4'
            })

            //Date picker
            $('#reservationdate').datetimepicker({
                //format: 'L'
                format: "DD-MM-YYYY"
            });
            $('#reservationdate1').datetimepicker({
                //format: 'L'
                format: "DD-MM-YYYY"
            });
            //Date and time picker
            $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });
        })

    </script>
    <!-- jQuery -->
    <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->
    <script src="../../plugins/select2/js/select2.full.min.js"></script>
    <!-- Bootstrap4 Duallistbox -->
    <script src="../../plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <script src="../../plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <%--<script src="../../plugins/daterangepicker/daterangepicker.js"></script>--%>
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

    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- date-range-picker -->
    <!-- Toastr -->
    <script src="plugins/toastr/toastr.min.js"></script>
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
</asp:Content>


