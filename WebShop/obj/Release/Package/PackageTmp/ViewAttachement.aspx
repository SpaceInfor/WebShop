<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ViewAttachement.aspx.cs" Inherits="WebShop.ViewAttachement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Task Header</title>
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
    <script type="text/javascript">
        var taskno = '';
        var positionno = '';
        debugger
        $(document).ready(function () {
            debugger
            const urlParams = new URLSearchParams(window.location.search);
            taskno = urlParams.get('t_tano');
            positionno = urlParams.get('t_pono');
            Bind_ViewAttachment(taskno, positionno);
        });
    </script>
     <script type="text/javascript">
         function GoToBack() {
             debugger
            const urlParams = new URLSearchParams(window.location.search);
            taskno = urlParams.get('t_tano');
            window.location.href = "TaskDetail.aspx?t_tano="+taskno+"";
            
         }
    </script>
    <script type="text/javascript">
        function Bind_ViewAttachment(t_tano, t_pono) {

            $.ajax({

                type: "POST",
                url: "ViewAttachement.aspx/GetAttachDetails",
                data: "{'t_tano': '" + t_tano + "','t_pono': '" + t_pono + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tblViewAttachDetails').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [


                            { "data": "t_tano", "title": "Task No." },
                            { "data": "t_tsrn", "title": "Sr No." },
                            {

                                data: null, "title": "Status", render: function (data, type, row, meta) {
                                    var CommStatus = "";
                                    if (row.t_pono == 0) {
                                        CommStatus = "Task Header File";
                                        return '<div' + CommStatus + '" class="badge bg-warning">' + CommStatus + '</div>';
                                    }
                                    else {
                                        CommStatus = "Task Details File";
                                        return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                    }

                                }
                            },
                            //{ "data": "t_fpat", "title": "Download" },
                            {
                                data: null, "title": "File", render: function (data, type, row, meta) {
                                    return '<a href="' + row.t_fpat + '" <i class="fas fa-download badge bg-primary" download></i>Download File</a>'
                                }
                            },

                        ]
                    }).buttons().container().appendTo('#tblViewAttachDetails_wrapper .col-md-6:eq(0)');
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
                    <h1>View File</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Task_list.aspx">Home</a></li>
                       
                        <li class="breadcrumb-item active">View Attachment</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <%--<section class="content-header">
        <div class="container-fluid">
            <div class="block-header">
                <h2>View Attachment</h2>
            </div>
        </div>
    </section>--%>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-outline card-warning">
                        <div class="card-header">
                            <div class="card-tools">
                                <%--<a class="btn btn-block bg-gradient-warning" href="./Sales_Order.aspx"><i class="fa fa-plus"></i>Add New</a>--%>
                                <%--<a class="btn btn-block bg-gradient-warning" data-toggle="modal" data-target="#TaskModal" onclick="clearTextBox();">
                                    <i class="fa fa-fw fa-plus-circle"></i>Add New
                                </a>--%>
                            </div>
                        </div>

                        <div class="card-body table-responsive p-0">
                            <table class="table table-bordered table-striped" id="tblViewAttachDetails">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                   <%--  <a class="btn btn-secondary"><i class="fas fa-step-backward" onclick="GoToBack()"></i>Back</a>--%>
                    <input type="button" class="btn btn-secondary" onclick="GoToBack();" id="btngoback" value="Back" />
                  
                </div>
            </div>
        </div>
    </section>


    <!-- jQuery -->
    <%-- <script src="../../plugins/jquery/jquery.min.js"></script>--%>
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
</asp:Content>
