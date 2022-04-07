<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Department_Master.aspx.cs" Inherits="WebShop.Department_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Department Master</title>
  
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">

    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <%-- <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">--%>
    <!-- Theme style -->

    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

    <%--<script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">


    <script type="text/javascript">
        $(document).ready(function () {

            Bind_DepartmentDetails();
        });
    </script>
    <script type="text/javascript">
        function Bind_DepartmentDetails() {

            $.ajax({

                type: "POST",
                url: "Department_Master.aspx/GetDepartmentDetails",

                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tblDeptDetails').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            { "data": "t_dept", "title": "Department ID" },
                            { "data": "t_desc", "title": "Department Description" },
                            { 'data': null, title: "Edit", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="Get_DepartmentDet(' + "'" + item.t_dept + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                            { 'data': null, title: "Delete", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_dept + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                        ]
                    }).buttons().container().appendTo('#tblDeptDetails_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>

    <script type="text/javascript">
        function delete_row(t_dept) {

            Swal.fire({
                title: 'Do you want to delete the line?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Delete',
                denyButtonText: 'Do not delete',
            }).then((result) => {

                if (result.isConfirmed) {

                    $.ajax(
                        {
                            type: "POST",
                            url: "Department_Master.aspx/deleteDepartment",
                            data: "{'t_dept': '" + t_dept + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: GetLineData_Delete,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    Swal.fire('Line is deleted!', '', 'success')
                } else if (result.isDenied) {
                    Swal.fire('Line is not deleted', '', 'info')
                }
            })
        }
        function GetLineData_Delete(response) {

            Bind_DepartmentDetails();
        }
    </script>

    <script type="text/javascript">

        function Get_DepartmentDet(t_dept) {
            $.ajax({
                type: "POST",
                url: "Department_Master.aspx/GetDepartmentWise",
                data: "{'t_dept': '" + t_dept + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {

                        document.getElementById("t_dept").value = response.d[0].t_dept;
                        document.getElementById("t_desc").value = response.d[0].t_desc;
                        $("#t_dept").attr('readonly', true);
                        $('#DepartmentModal').modal('show');
                        $('#t_dept').focus();
                        $("#btnAdd").attr("onclick", "AddInput('U')");
                        $("#btnAdd").attr("value", "Update");
                    }
                    else {

                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function AddInput(Action) {
            var res = validate();
            if (res == false) {
                return false;
            }
            var t_dept = $("#t_dept").val();

            $.ajax(
                {
                    type: "POST",
                    url: "Department_Master.aspx/saveDepartment",
                    data: '{t_dept: "' + t_dept + '",t_desc: "' + document.getElementById('t_desc').value + '",t_flag:"' + Action + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d[0].toString() === "success") {
                            $('#t_colr').val("");
                            $('#t_desc').val("");
                            $('#DepartmentModal').modal('hide');
                            $('#t_colr').focus();
                            $("#btnAdd").attr("onclick", "AddInput('I',0)");
                            $("#btnAdd").attr("value", "Add");
                            Bind_DepartmentDetails();
                            toastr.success('Record added successfully');
                        }
                        else {
                            toastr.warning(response.d[0].toString());

                        }
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
        }
        function validate() {
            var isValid = true;
            if ($('#t_dept').val().trim() == "") {
                $('#t_dept').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_dept').css('border-color', 'lightgrey');
            }
            if ($('#t_desc').val().trim() == "") {
                $('#t_desc').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_desc').css('border-color', 'lightgrey');
            }

            return isValid;
        }

    </script>
    <script type="text/javascript">
        function clearTextBox() {
            $("#t_dept").attr('readonly', false);
            $("#t_dept").val('');
            $("#t_desc").val('');
            $('#DepartmentModal').modal('show');
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
     <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Department Master</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="TaskDashboard.aspx">Home</a></li>
                        <%--<li class="breadcrumb-item"><a href="CustOrderList.aspx">Order Booking List</a></li>--%>
                        <li class="breadcrumb-item active">Department Master</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <div class="container-fluid">
        <%-- <div class="block-header">
            <h2>Department Master</h2>
        </div>--%>
       <%-- <div class="row mb-2">
            <div class="col-sm-6">
                <h2>Department Master</h2>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="./Home.aspx">Home</a></li>

                </ol>
            </div>
        </div>--%>
    
    <div class="row">

        <div class="col-md-12">
            <div class="card card-warning card-outline">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;Department List</h3>
                    <div class="card-tools">

                        <a class="btn btn-block bg-gradient-warning" data-toggle="modal" data-target="#DepartmentModal" onclick="clearTextBox();">
                            <i class="fa fa-fw fa-plus-circle"></i>Add
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table id="tblDeptDetails" class="table table-bordered table-striped ">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="modal fade" id="DepartmentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog card card-secondary" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-drafting-compass"></i>Department Details

                            </h3>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <div class="modal-tools">
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Department code</label>
                                <input type="text" class="form-control" placeholder="Enter Department code" id="t_dept">
                            </div>

                            <div class="form-group">
                                <label>Department Description</label>
                                <input type="text" class="form-control" placeholder="Enter Department Description" id="t_desc">
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-warning waves-effect" onclick="AddInput('I')" id="btnAdd" value="Add" />
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

    </div>
    <!-- /.row -->

    <!-- /.container-fluid -->

    <!-- /.container-fluid -->
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <%-- <script src="../plugins/jquery/jquery.min.js"></script>--%>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
    <!-- Bootstrap4 Duallistbox -->
    <script src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Bootstrap Switch -->
    <%-- <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>--%>
    <!-- BS-Stepper -->
    <script src="plugins/bs-stepper/js/bs-stepper.min.js"></script>
    <!-- dropzonejs -->
    <script src="plugins/dropzone/min/dropzone.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->

    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="plugins/toastr/toastr.min.js"></script>

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
