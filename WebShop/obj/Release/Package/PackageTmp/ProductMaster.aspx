<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="ProductMaster.aspx.cs" Inherits="WebShop.ProductMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product Master</title>
    <!-- Google Font: Source Sans Pro -->


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Theme style -->


    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

    <%--<script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>

    <%--  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <script type="text/javascript">

        $(document).ready(function () {
            debugger
            //$("#t_cbrn").val(1);
            document.getElementById("t_cbrn").value = 1;
            Bind_Product_Headers();
            
        });

    </script>
    <script type="text/javascript">
        function clearTextBox() {
            $('#t_pdid').attr('readonly', false);
            $("#t_pdid").val('');
            $("#t_cbrn").val(1);
            $("#t_item").val('');
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");
            //$('#btnUpdate').hide();
            $('#ProductModal').modal('show');

        }
   </script>

    <script type="text/javascript">
        function Bind_Product_Headers() {

            $.ajax({

                type: "POST",
                url: "ProductMaster.aspx/GetProductDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var datatableVariable = $('#tblproductdisplay').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": true,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: response.d,
                        columns: [

                            { "data": "t_pdid", "title": "Product Id." },
                            //{ "data": "t_cbrn", "title": "Product Line" },
                            {

                                data: null, "title": "Product Line", render: function (data, type, row, meta) {
                                    var prodStatus = "";
                                    if (row.t_cbrn == 1) {
                                        prodStatus = "Home";
                                        return '<div' + prodStatus + '" class="badge bg-success">' + prodStatus + '</div>';
                                    }
                                    else {
                                        prodStatus = "Kitchen";
                                        return '<div' + prodStatus + '" class="badge bg-danger">' + prodStatus + '</div>';
                                    }

                                }
                            },

                            { "data": "t_item", "title": "Item" },
                            { 'data': null, title: 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="Bind_Product_Lines(' + "'" + item.t_pdid + "'" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                            { 'data': null, title: 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_pdid + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },


                        ]
                    }).buttons().container().appendTo('#tblproductdisplay_wrapper .col-md-6:eq(0)');

                }
            });
        };
 </script>
    <script type="text/javascript">
        function delete_row(t_pdid) {

            Swal.fire({
                title: 'Do you want to delete the line?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Delete',
                denyButtonText: 'Do not delete',
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {

                    $.ajax(
                        {
                            type: "POST",
                            url: "ProductMaster.aspx/deleteProduct",
                            data: "{'t_pdid': '" + t_pdid + "'}",
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

            Bind_Product_Headers();
        }
   </script>
    <script type="text/javascript">

        function Bind_Product_Lines(t_pdid) {
            $.ajax({
                type: "POST",
                url: "ProductMaster.aspx/GetProductLines",

                data: "{'t_pdid': '" + t_pdid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {
                        $('#t_pdid').attr('readonly', true);
                        document.getElementById("t_pdid").value = response.d[0].t_pdid;
                        document.getElementById("t_cbrn").value = response.d[0].t_cbrn;
                        document.getElementById("t_item").value = response.d[0].t_item;


                        $('#ProductModal').modal('show');
                        $('#t_pdid').focus();
                        $("#btnAdd").attr("onclick", "AddInput('U')");
                        $("#btnAdd").attr("value", "Update");
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
            debugger
            var t_pdid = '';
            t_pdid = $("#t_pdid").val();
            var res = validate();
            if (res == false) {
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    url: "ProductMaster.aspx/saveInputProduct",
                    data: '{t_pdid: "' + t_pdid + '",t_cbrn: "' + document.getElementById('t_cbrn').value + '",t_item: "' + document.getElementById('t_item').value + '",Action:"' + Action + '"}',

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    ////success: GetLineData,
                    success: function (response) {
                        if (response.d[0].toString() === "SUCCESS") {
                            $('#ProductModal').modal('hide');
                            $('#t_pdid').val("");
                            $('#t_cbrn').val("");
                            $('#t_item').val("");

                            $('#ProductModal').modal('hide');
                            $('#t_pdid').focus();
                            $("#btnAdd").attr("onclick", "AddInput('I')");
                            $("#btnAdd").attr("value", "Add");

                            Bind_Product_Headers();
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
            if ($("#t_pdid").val() == "") {
                $('#t_pdid').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_pdid').css('border-color', 'lightgrey');
            }
            if ($("#t_cbrn option:selected").text() == "--Select--") {
                $('#t_cbrn').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_cbrn').css('border-color', 'lightgrey');
            }

            if ($('#t_item').val() == "") {
                $('#t_item').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_item').css('border-color', 'lightgrey');
            }
            
            return isValid;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="block-header">
                <h2>Products Display Master</h2>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">

                <div class="col-md-12">
                    <div class="card card-warning card-outline">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;Product Displyed List</h3>
                            <div class="card-tools">

                                <a class="btn btn-block bg-gradient-warning" data-toggle="modal" data-target="#ProductModal" onclick="clearTextBox();">
                                    <i class="fa fa-fw fa-plus-circle"></i>Add
                                </a>
                            </div>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table id="tblproductdisplay" class="table table-bordered table-striped ">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="modal fade" id="ProductModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg card card-secondary" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title">
                                        <i class="fas fa-drafting-compass"></i>Product Display Details

                                    </h3>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <div class="modal-tools">
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Product Code</label>
                                                <input type="text" class="form-control" placeholder="Enter Product Code" id="t_pdid">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Product</label>
                                                <select class="form-control custom-select rounded-0" id="t_cbrn" data-dropdown-css-class="select2-danger" style="width: 100%;">
                                                    <%--  <option value="0">--Select--</option>--%>
                                                    <option value="1">Home</option>
                                                    <option value="2">Kitchen</option>

                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Product Item</label>
                                                <input type="text" class="form-control" placeholder="Enter Product Item" id="t_item">
                                            </div>
                                        </div>
                                    </div>

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
            <!-- /.row -->
        </div>
    </section>
    <!-- /.container-fluid -->
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
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
    <%-- <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>--%>
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
