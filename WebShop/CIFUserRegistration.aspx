<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCIF.Master" AutoEventWireup="true" CodeBehind="CIFUserRegistration.aspx.cs" Inherits="WebShop.CIFUserRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Registration Form</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css" />
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet" />
    <%--  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css" />
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css" />

    <script type="text/javascript">
        $(document).ready(function () {
            document.getElementById("t_usid").focus();

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-md-6">
                    <h1>CIF User Registration</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="CIFFormList.aspx">Home</a></li>
                        <li class="breadcrumb-item active">User Registration</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <%--  <div class="register-box">--%>


    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card card-warning">
                            <%--  <div class="card-body register-card-body">--%>
                            <div class="card card-outline card-warning">
                                <div class="card-header">
                                    <h3 class="card-title"><i class="fas fa-user-plus"></i>&nbsp; Add User</h3>

                                    <div class="card-tools">
                                        <span class="float-right username"><a href="#" id="userid"></a></span>
                                    </div>
                                </div>
                                <div class="card-body">

                                    <div class="form-group">
                                        <div class="input-group">
                                            <input id="t_usid" type="text" class="form-control" placeholder="User Id" />
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-user"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="input-group mb-3">
                                            <input id="t_nama" type="text" class="form-control" placeholder="Enter name of user" />
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-user"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="input-group mb-3">
                                            <input id="t_pass" type="password" class="form-control" placeholder="Password" />
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-lock"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">

                                        <div class="input-group mb-3">
                                            <input id="t_pas2" type="password" class="form-control" placeholder="Confirm password" />
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-lock"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="input-group mb-3">
                                            <input id="t_emai" type="text" class="form-control" placeholder="Enter User Email" />
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-envelope"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="modal-footer ">

                            <div class="col-3">
                                <input type="button" name="btnregister" value="Register" id="btnregister" class="btn btn-warning btn-block text-center" />
                            </div>
                            <div class="col-3">
                                <input type="button" name="btnback" value="Back" id="btnback" class="btn btn-warning btn-block" />
                            </div>
                            <!-- /.col -->
                        </div>
                        <%--<div class="col-md-3"></div>--%>
                    </div>
                </div>
            </div>
        </div>
    </section>




    <%--<div class="row">

                <div class="col-md-12">
                    <div class="card card-warning card-outline">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;User List</h3>
                            <div class="card-tools">

                            </div>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table id="tblUserDetails" class="table table-bordered table-striped ">
                            </table>
                        </div>
                    </div>
                </div>
            </div>--%>
    <%-- </div>--%>
    <%-- </section>--%>

    <script type="text/javascript">
        $(function () {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 2000
            });

            $('.swalDefaultSuccess').click(function () {
                Toast.fire({
                    icon: 'success',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.swalDefaultInfo').click(function () {
                Toast.fire({
                    icon: 'info',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.swalDefaultError').click(function () {
                Toast.fire({
                    icon: 'error',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.swalDefaultWarning').click(function () {
                Toast.fire({
                    icon: 'warning',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.swalDefaultQuestion').click(function () {
                Toast.fire({
                    icon: 'question',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });

            $('.toastrDefaultSuccess').click(function () {
                //toastr.success('Record saved sucessfully.....!!!')
            });
            $('.toastrDefaultInfo').click(function () {
                toastr.info('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
            });
            $('.toastrDefaultError').click(function () {
                toastr.error('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
            });
            $('.toastrDefaultWarning').click(function () {
                //toastr.warning('Record is saved sucessfully....')
            });

            $('.toastsDefaultDefault').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultTopLeft').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    position: 'topLeft',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultBottomRight').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    position: 'bottomRight',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultBottomLeft').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    position: 'bottomLeft',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultAutohide').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    autohide: true,
                    delay: 750,
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultNotFixed').click(function () {
                $(document).Toasts('create', {
                    title: 'Toast Title',
                    fixed: false,
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultFull').click(function () {
                $(document).Toasts('create', {
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    icon: 'fas fa-envelope fa-lg',
                })
            });
            $('.toastsDefaultFullImage').click(function () {
                $(document).Toasts('create', {
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    image: '../../dist/img/user3-128x128.jpg',
                    imageAlt: 'User Picture',
                })
            });
            $('.toastsDefaultSuccess').click(function () {
                $(document).Toasts('create', {
                    class: 'bg-success',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultInfo').click(function () {
                $(document).Toasts('create', {
                    class: 'bg-info',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultWarning').click(function () {
                //$(document).Toasts('create', {
                //    class: 'bg-warning',
                //    title: 'Loading Scan',
                //    //subtitle: 'Subtitle',
                //    body: 'Record is saved sucessfully.....'
                //})
            });
            $('.toastsDefaultDanger').click(function () {
                $(document).Toasts('create', {
                    class: 'bg-danger',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
            $('.toastsDefaultMaroon').click(function () {
                $(document).Toasts('create', {
                    class: 'bg-maroon',
                    title: 'Toast Title',
                    subtitle: 'Subtitle',
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
                })
            });
        });
    </script>
    <script type="text/javascript">

        $('#btnregister').click(function () {

            var res = validate();
            if (res == false) {
                return false;
            }

            var t_usid = $('#t_usid').val();
            var t_pass = $('#t_pass').val();
            var t_nama = $('#t_nama').val();
            var t_emai = $('#t_emai').val();

            var password1 = $("#t_pass").val();
            var password2 = $("#t_pas2").val();

            if (password1 == password2) {

                //$("#validate-status").text("Valid");
                $.ajax({
                    url: "NewRegistration.aspx/AddUser",
                    //data: JSON.stringify(userObj),
                    //data: '{emp:' + JSON.stringify(userObj) + '}',
                    data: '{t_usid: "' + t_usid + '",t_pass: "' + t_pass + '",t_nama: "' + t_nama + '",t_emai: "' + t_emai + '"}',
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        //var output = result;

                        if (result.d[0].toString().trim() === 'success') {

                            toastr.success('User registered successfully.');

                            $('#t_usid').val('');
                            $('#t_pass').val('');
                            $('#t_pas2').val('');
                            $('#t_nama').val('');
                            $('#t_emai').val('');


                        }
                        else {

                            toastr.error(result.d[0].toString().trim());
                        }

                    },
                    error: function (errormessage) {
                        alert(errormessage.responseText);
                    }
                });
            }
            else {

                //$("#validate-status").text("Invalid");
                toastr.warning('The password and confirmation password does not match.');
            }

        });

        $('#btnback').click(function () {
            var url = 'CIFFormList.aspx';
            window.location.href = url;
        });

        //Valdidation using jquery
        function validate() {
            var isValid = true;
            if ($('#t_usid').val().trim() == "") {
                $('#t_usid').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_usid').css('border-color', 'lightgrey');
            }
            if ($('#t_pass').val().trim() == "") {
                $('#t_pass').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_pass').css('border-color', 'lightgrey');
            }
            if ($('#t_pas2').val().trim() == "") {
                $('#t_pas2').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_pas2').css('border-color', 'lightgrey');
            }
            if ($('#t_nama').val().trim() == "") {
                $('#t_nama').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_nama').css('border-color', 'lightgrey');
            }
            if ($('#t_emai').val().trim() == "") {
                $('#t_emai').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_emai').css('border-color', 'lightgrey');
            }

            return isValid;
        }

    </script>

    <script src="../../plugins/toastr/toastr.min.js"></script>


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
