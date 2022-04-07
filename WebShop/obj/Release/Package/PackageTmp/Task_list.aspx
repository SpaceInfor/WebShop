<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Task_list.aspx.cs" Inherits="WebShop.Task_list" %>

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
    <style>
        .high {
            color: palevioletred;
        }

        .low {
            color: skyblue;
        }
    </style>


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

        function GetDepartment(t_dept) {

            var t_dept = $("#t_dept").val();

            if (t_levl == 3) {
                t_dept = '<%= Session["t_dept"] %>';
                document.getElementById("t_dept").value = t_dept;
            }
            $.ajax({
                url: "Task_list.aspx/GetDepartmentDes",
                data: '{t_dept :"' + t_dept + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_deptdesc").html("");
                        $("#t_dept").val("");
                        toastr.warning('Department not found...!!!');
                    }
                    else {
                        document.getElementById("t_deptdesc").innerHTML = response.d[0].t_desc;
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
        function GetAssignuser(t_taat) {

            var t_taatcode = $("#t_taat").val();
            $.ajax({
                url: "Task_list.aspx/GetUserName",
                data: '{t_taat :"' + t_taatcode + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_userdesc").html("");
                        $("#t_taat").val("");

                        toastr.warning('Record not found...!!!');
                    }
                    else {
                        document.getElementById("t_userdesc").innerHTML = response.d[0].t_nama;
                        //document.getElementById("t_dept").value = response.d[0].t_dept;
                        //document.getElementById("t_deptdesc").innerHTML = response.d[0].t_desc;

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
        function GetSalesOrder() {

            var t_ornocode = $("#t_sord").val();
            $.ajax({
                url: "Task_list.aspx/CheckSalesOrderExist",
                data: '{t_orno :"' + t_ornocode + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {

                        $("#t_sord").val("");
                        toastr.warning('Record not found...!!!');
                    }
                    else if ($("#t_sord").val == "Other") {
                        $("#t_sord").val != "";
                    }
                    //else {
                    //    document.getElementById("t_orno").innerHTML = response.d[0].t_orno;
                    //}
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
    </script>


    <script type="text/javascript">
        var userid = '';
        var UserName = '';
        var t_comm = '';
        var t_levl = '';
        var t_dept = '';
        var t_tano = '';
        $(document).ready(function () {

            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            userid = '<%= Session["t_usid"] %>';
            UserName = '<%= Session["t_nama"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            t_dept = '<%= Session["t_dept"] %>';
            var t_comm = document.getElementById('t_comm').value;

            if (t_levl == 1) {
                $("#lblassigndept").css('display', 'none');
                $("#t_taat").css('display', 'none');
                //$("#t_taat").css('display', 'block');
                $("#btnAssignUser").css('display', 'none');
            }
            else if (t_levl == 2 && t_comm == 1) {

                $("#lblassigndept").css('display', 'none');
                $("#t_taat").css('display', 'none');
                $("#btnAssignUser").css("display", "none");

            }
            else if (t_levl == 2 && t_comm == 2) {
                $("#lblassigndept").css('display', 'block');
                $("#t_taat").css('display', 'block');
                $("#btnAssignUser").css('display', 'block');
                $("#btnAssignUser").css("display", "block");

            }
            else if (t_levl == 3 && t_comm == 2) {

                $('select option[value="2"]').attr("selected", true);
                $("#lblassigndept").css('display', 'block');
                $("#t_taat").css('display', 'block');
                $("#btnAssignUser").css('display', 'block');
                var t_comm = document.getElementById('t_comm').value;

            }

            $("#username").html(UserName);

            var today = new Date();

            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            // today = yyyy + '/' + mm + '/' + dd;
            today = dd + '-' + mm + '-' + yyyy;
            // alert(today);
            //console.log(today);
            document.getElementById("t_crdate").value = today.toString();
            $("#t_crdate").prop("disabled", true);

            if (t_tano != null) {
                Bind_TaskNoWiseDetails();
            }
            else {
                Bind_TaskDetails();
            }

            Get_CommunicationValue();

        });
    </script>


    <script type="text/javascript">

        function AddInput(Action) {
            $("#btnAdd").prop("disabled", true);
            userid = '<%= Session["t_usid"] %>';
            t_dept = '<%= Session["t_dept"] %>';
            var t_comm = document.getElementById('t_comm').value;
            t_levl = '<%= Session["t_levl"] %>';

            var res = validate();
            if (res == false) {
                return false;
            }
            if (userid != "" && t_dept != "") {
                var profilephotofiles = $("#postedFiles").get(0).files;
                var formdata = new FormData();

                for (var i = 0; i < profilephotofiles.length; i++) {
                    formdata.append("postedFiles", profilephotofiles[i]);
                }

                //Add the input element values
                formdata.append("t_usid", userid);
                formdata.append("t_tnam", $('#t_tnam').val());


                if (t_comm == 2 && t_levl == 3) {

                    formdata.append("t_taat", $('#t_taat').val());

                }
                else if (t_comm == 1 && t_levl == 2) {

                    formdata.append("t_taat", "");

                }
                else if (t_comm == 2 && t_levl == 2) {

                    formdata.append("t_taat", $('#t_taat').val());
                }
                else if (t_comm == 1 && t_levl == 1) {
                    formdata.append("t_taat", "");
                }
                else if (t_comm == 2 && t_levl == 1) {
                    formdata.append("t_taat", "");
                }

                //formdata.append("t_taat", $('#t_taat').val());
                formdata.append("t_comm", document.getElementById('t_comm').value);
                formdata.append("t_dept", document.getElementById('t_dept').value);
                formdata.append("t_crdt", $('#t_crdt').val());
                formdata.append("t_codt", $('#t_codt').val());
                //formdata.append("t_stat", 1);
                formdata.append("t_rmrk", $('#t_rmrk').val());
                formdata.append("t_sord", $('#t_sord').val());
                formdata.append("t_tdes", $('#t_tdes').val());
                formdata.append("t_flag", Action);
                formdata.append("t_odep", t_dept)


                $.ajax({
                    type: "POST",
                    //url: "Task_list.aspx/saveTask",
                    url: "../UploadHandler.ashx",
                    contentType: false,
                    processData: false,
                    data: formdata,

                    success: function (result) {

                        $('#TaskModal').modal('hide');
                        $('#t_tnam').val("");
                        $('#t_tdes').val("");
                        $('#t_taat').val("");
                        //$('#t_comm').val("");
                        $('#t_dept').val("");
                        $('#t_crdt').val("");
                        $('#t_codt').val("");
                        $('#t_rmrk').val("");
                        $('#t_tnam').focus();
                        $("#btnAdd").attr("onclick", "AddInput('I',0)");
                        $("#btnAdd").attr("value", "Add");
                        Bind_TaskDetails();
                        
                        toastr.success(result);
                       

                    },
                    error: function (xhr, status, error) {
                        var err = eval(xhr.responseText);
                        //alert(err);
                        toastr.error("Error while uploading files!");
                    }
                });
            }
            else {
                toastr.Error("User id does not found!");
            }
        }

        function validate() {

            var isValid = true;
            if ($('#t_tnam').val() == "") {
                $('#t_tnam').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_tnam').css('border-color', 'lightgrey');
            }
            //if ($('#t_taat').val() == "") {
            //    $('#t_taat').css('border-color', 'Red');
            //    isValid = false;
            //}
            //else {
            //    $('#t_taat').css('border-color', 'lightgrey');
            //}
            if ($('#t_dept').val() == "") {
                $('#t_dept').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_dept').css('border-color', 'lightgrey');
            }
            //if ($('#t_rmrk').val() == "") {
            //    $('#t_rmrk').css('border-color', 'Red');
            //    isValid = false;
            //}
            //else {
            //    $('#t_rmrk').css('border-color', 'lightgrey');
            //}
            if ($('#t_sord').val() == "") {
                $('#t_sord').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_sord').css('border-color', 'lightgrey');
            }
            if ($('#t_tdes').val() == "") {
                $('#t_tdes').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_tdes').css('border-color', 'lightgrey');
            }

            return isValid;
        }
            /////////////////////////////End/////////////////

    </script>

    <script type="text/javascript">
        function Bind_TaskDetails() {

            userid = '<%= Session["t_usid"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            t_odep = '<%= Session["t_dept"] %>';
            if (userid != '') {

                if (t_levl == 1) {
                    $.ajax({

                        type: "POST",
                        url: "Task_list.aspx/GetTaskDetails",
                        //data: '{t_usid :"' + userid + '",t_dept:"' + t_dept + '"}',
                        data: '{t_odep:"' + t_odep + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskDetails').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [


                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_usid", "title": "Task Origin Id" },
                                    { "data": "originname", "title": "Task Origin Name" },
                                    { "data": "t_taat", "title": "Task Assign Id" },
                                    { "data": "assignname", "title": "Task Assign Name" },

                                    //{ "data": "t_comm", "title": "Communication" },

                                    {

                                        data: null, "title": "Task Type", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_usid == userid) {
                                                CommStatus = "Raised";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Received";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
                                    {

                                        data: null, "title": "Communication", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_comm == 1) {
                                                CommStatus = "Inter Department";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Intra Department";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_crdt", "title": "Creation date" },
                                    { "data": "t_codt", "title": "Expected Date" },

                                    {

                                        data: null, "title": "Status", render: function (data, type, row, meta) {
                                            var taskStatus = "";
                                            if (row.t_stat == 1) {
                                                taskStatus = "Open";
                                                return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                            }
                                            else if (row.t_stat == 2) {
                                                taskStatus = "In-Process";
                                                return '<div' + taskStatus + '" class="badge bg-danger">' + taskStatus + '</div>';
                                            }
                                            else {
                                                taskStatus = "Closed";
                                                return '<div' + taskStatus + '" class="badge bg-success">' + taskStatus + '</div>';
                                            }

                                        }
                                    },

                                    { 'data': null, title: "Delete", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_tano + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                                ]

                            }).buttons().container().appendTo('#tbltaskDetails_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else if (t_levl == 2) {

                    $.ajax({

                        type: "POST",
                        url: "Task_list.aspx/GetDeptwiseTaskDetails",
                        data: '{t_odep :"' + t_odep + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskDetails').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [


                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_usid", "title": "Task Origin Id" },
                                    { "data": "originname", "title": "Task Origin Name" },
                                    { "data": "t_taat", "title": "Task Assign Id" },
                                    { "data": "assignname", "title": "Task Assign Name" },
                                    {

                                        data: null, "title": "Task Type", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_usid == userid) {
                                                CommStatus = "Raised";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Received";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
                                    {

                                        data: null, "title": "Communication", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_comm == 1) {
                                                CommStatus = "Inter Department";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Intra Department";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_crdt", "title": "Creation date" },
                                    { "data": "t_codt", "title": "Expected Date" },
                                    //{ "data": "t_stat", "title": "Status" },
                                    {

                                        data: null, "title": "Status", render: function (data, type, row, meta) {
                                            var taskStatus = "";
                                            if (row.t_stat == 1) {
                                                taskStatus = "Open";
                                                return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                            }
                                            else if (row.t_stat == 2) {
                                                taskStatus = "In-Process";
                                                return '<div' + taskStatus + '" class="badge bg-danger">' + taskStatus + '</div>';
                                            }
                                            else {
                                                taskStatus = "Closed";
                                                return '<div' + taskStatus + '" class="badge bg-success">' + taskStatus + '</div>';
                                            }

                                        }
                                    },

                                    { 'data': null, title: "Delete", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_tano + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                                ]

                            }).buttons().container().appendTo('#tbltaskDetails_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else if (t_levl == 3) {

                    $.ajax({

                        type: "POST",
                        url: "Task_list.aspx/GetTaskDetailsLevel3",
                        data: '{t_usid :"' + userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskDetails').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [


                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_usid", "title": "Task Origin Id" },
                                    { "data": "originname", "title": "Task Origin Name" },
                                    { "data": "t_taat", "title": "Task Assign Id" },
                                    { "data": "assignname", "title": "Task Assign Name" },
                                    {

                                        data: null, "title": "Task Type", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_usid == userid) {
                                                CommStatus = "Raised";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Received";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
                                    {

                                        data: null, "title": "Communication", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_comm == 1) {
                                                CommStatus = "Inter Department";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Intra Department";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_crdt", "title": "Creation date" },
                                    { "data": "t_codt", "title": "Expected Date" },
                                    //{ "data": "t_stat", "title": "Status" },
                                    {

                                        data: null, "title": "Status", render: function (data, type, row, meta) {
                                            var taskStatus = "";
                                            if (row.t_stat == 1) {
                                                taskStatus = "Open";
                                                return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                            }
                                            else if (row.t_stat == 2) {
                                                taskStatus = "In-Process";
                                                return '<div' + taskStatus + '" class="badge bg-danger">' + taskStatus + '</div>';
                                            }
                                            else {
                                                taskStatus = "Closed";
                                                return '<div' + taskStatus + '" class="badge bg-success">' + taskStatus + '</div>';
                                            }

                                        }
                                    },

                                    { 'data': null, title: "Delete", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_tano + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                                ]

                            }).buttons().container().appendTo('#tbltaskDetails_wrapper .col-md-6:eq(0)');
                        }
                    });

                }
            }
            else {
                //toastr.success('Record not found');
            }
        }


    </script>


    <script type="text/javascript">
        function Bind_TaskNoWiseDetails() {

            userid = '<%= Session["t_usid"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            t_dept = '<%= Session["t_dept"] %>';

            if (userid != '') {
                if (t_tano != "") {

                    $.ajax({

                        type: "POST",
                        url: "Task_list.aspx/GetTaskNowiseDetails",
                        data: '{t_tano :"' + t_tano + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskDetails').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [


                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_usid", "title": "Task Origin Id" },
                                    { "data": "originname", "title": "Task Origin Name" },
                                    { "data": "t_taat", "title": "Task Assign Id" },
                                    { "data": "assignname", "title": "Task Assign Name" },

                                    //{ "data": "t_comm", "title": "Communication" },
                                    {

                                        data: null, "title": "Communication", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_comm == 1) {
                                                CommStatus = "Inter Department";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Intra Department";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    {

                                        data: null, "title": "Task Type", render: function (data, type, row, meta) {
                                            var CommStatus = "";
                                            if (row.t_usid == userid) {
                                                CommStatus = "Raised";
                                                return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                            }
                                            else {
                                                CommStatus = "Received";
                                                return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                            }

                                        }
                                    },
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
                                    //{ "data": "assigndept", "title": "Department" },
                                    { "data": "t_crdt", "title": "Creation date" },
                                    { "data": "t_codt", "title": "Expected Date" },
                                    //{ "data": "t_stat", "title": "Status" },
                                    {

                                        data: null, "title": "Status", render: function (data, type, row, meta) {
                                            var taskStatus = "";
                                            if (row.t_stat == 1) {
                                                taskStatus = "Open";
                                                return '<div' + taskStatus + '" class="badge bg-warning">' + taskStatus + '</div>';
                                            }
                                            else if (row.t_stat == 2) {
                                                taskStatus = "In-Process";
                                                return '<div' + taskStatus + '" class="badge bg-danger">' + taskStatus + '</div>';
                                            }
                                            else {
                                                taskStatus = "Closed";
                                                return '<div' + taskStatus + '" class="badge bg-success">' + taskStatus + '</div>';
                                            }

                                        }
                                    },

                                    { 'data': null, title: "Delete", wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_tano + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                                ]

                            }).buttons().container().appendTo('#tbltaskDetails_wrapper .col-md-6:eq(0)');
                        }
                    });
                }

                else {
                    //toastr.success('Record not found');
                }
            }
        }
    </script>
    <script type="text/javascript">
        function Get_CommunicationValue() {
            
            var t_comm = document.getElementById('t_comm').value;
            t_dept = '<%= Session["t_dept"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            if (t_comm == 1 && t_levl == 3) {

                //toastr.warning("You have no permission to select Inter Department Communication.");
                document.getElementById("t_comm").value = 2;
                t_comm = document.getElementById('t_comm').value;
                GetDepartment(t_dept);
            }
            else if (t_comm == 2 && t_levl == 3) {
                $('select option[value="2"]').attr("selected", true);
                t_comm = document.getElementById('t_comm').value;
            }

            else if (t_comm == 1 && t_levl == 2) {
                $("#lblassigndept").css('display', 'none');
                $("#t_taat").css('display', 'none');
                $("#btnAssignUser").css("display", "none");
                document.getElementById("t_dept").value = t_dept;
                GetDepartment(t_dept);

            }
            else if (t_comm == 2 && t_levl == 2) {
                $("#lblassigndept").css('display', 'block');
                $("#t_taat").css('display', 'block');
                $("#btnAssignUser").css("display", "block");
                document.getElementById("t_dept").value = t_dept;
                GetDepartment(t_dept);

            }
            else if (t_comm == 2 && t_levl == 3) {
                GetDepartment(t_dept);
            }
            else {
                document.getElementById("t_dept").value = "";
            }

            if (t_comm != '') {
                $.ajax({

                    type: "POST",
                    url: "Task_list.aspx/SetCommunication",
                    data: '{t_comm :"' + t_comm + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    processData: true,
                    success: function (data) {

                    }
                });
            }
        }
    </script>
    <script type="text/javascript">
        function formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2)
                month = '0' + month;
            if (day.length < 2)
                day = '0' + day;

            return [year, month, day].join('-');
        }

        function checkExpectedDate() {

            var expectDate = document.getElementById("t_codt").value;
            var newdate = expectDate.split("-").reverse().join("-");
            var expDate = formatDate(newdate);

            var today = new Date();
            var today1 = '';

            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            // today = yyyy + '/' + mm + '/' + dd;
            today = yyyy + '-' + mm + '-' + dd;
            today1 = dd + '-' + mm + '-' + yyyy;

            if (expDate < today) {
                toastr.warning('You can not select date before today date.');
                document.getElementById("t_codt").value = today1.toString();
            }
        }
    </script>
    <script type="text/javascript">
        function delete_row(t_tano) {

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
                            url: "Task_list.aspx/deleteTask",
                            data: "{'t_tano': '" + t_tano + "'}",
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

            Bind_TaskDetails();
        }
    </script>
    <script type="text/javascript">
        function clearTextBox() {


            $("#t_tnam").val('');
            $("#t_tdes").val('');
            $("#t_taat").val('');
            //$("#t_comm").val('');
            $("#t_dept").val('');
            $("#t_crdt").val('');
            $("#t_codt").val('');
            $("#t_rmrk").val('');
            $("#t_sord").val('');
            $("#t_deptdesc").html('');
            $("#t_userdesc").html('');
            $('#TaskModal').modal('show');
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");
            $("#btnAdd").prop("disabled", false);


            t_dept = '<%= Session["t_dept"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            if (t_levl == 3) {

                GetDepartment(t_dept);
            }
            $("#checkother").prop("checked", false);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="block-header">
                <h2>Task List</h2>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-outline card-warning">
                        <div class="card-header">

                            <div class="card-tools">

                                <%--<div class="row">--%>

                                    <%-- <div class="col-2">
                                        <input type="button" class="btn btn-warning waves-effect" onclick="RaiseTask()" id="btnRaise" value="Raised " />
                                    </div>
                                    <div class="col-3">
                                        <input type="button" class="btn btn-warning waves-effect" onclick="ReceivedTask()" id="btnReceive" value="Received" />
                                    </div>--%>
                                    <%--<div class="col-5" style="width: 100px">--%>

                                        <a class="btn btn-block bg-gradient-warning" data-toggle="modal" data-target="#TaskModal" onclick="clearTextBox();">
                                            <i class="fa fa-fw fa-plus-circle"></i>Create New Task
                                        </a>
                                   <%-- </div>--%>

                                <%--</div>--%>
                            </div>
                        </div>

                        <div class="card-body table-responsive p-0">
                            <table class="table table-bordered table-striped" id="tbltaskDetails">
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="modal fade" id="TaskModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg card card-secondary" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title">
                                        <i class="fas fa-tasks"></i>&nbsp;&nbsp;Task Details
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
                                                <label>Task Name</label>
                                                <input type="text" class="form-control" placeholder="Task Name" id="t_tnam">
                                                <input type="hidden" class="form-control" id="t_tano">
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <label for="exampleInputEmail1">Sales Order</label>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Sales Order" onchange="GetSalesOrder(this.Value)" id="t_sord">
                                                </div>
                                                <div class="input-group-append">
                                                    <button id="btnSalesOrder" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_sord','SalesOrderList')"><i class="fa fa-fw fa-search"></i></button>
                                                </div>

                                            </div>
                                            <div class="form-check">
                                                <input id="checkother" class="form-check-input" type="checkbox">
                                                <label class="form-check-label">Check for other</label>
                                            </div>


                                            <%--<div class="custom-control custom-checkbox">
                                                <input class="custom-control-input check" type="checkbox" id="customCheckbox1" value="option1">
                                                <label for="customCheckbox1" class="custom-control-label">For Other</label>
                                            </div>--%>
                                        </div>
                                        <%-- <div class="col-sm-2">
                                            
                                        </div>--%>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Task Description</label>

                                                <textarea class="form-control" name="description" rows="3" cols="30" id="t_tdes">
                                            </textarea>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Expected Delivery Date</label>
                                                <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                                    <input type="text" class="form-control datetimepicker-input DOBdtpicker" data-target="#reservationdate1" onblur="checkExpectedDate();" id="t_codt">
                                                    <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Task Date</label>
                                                <input type="text" class="form-control" id="t_crdate">
                                                <%--<div class="input-group date" id="reservationdate" data-target-input="nearest">
                                                <input type="text" class="form-control datetimepicker-input DOBdtpicker" data-target="#reservationdate" id="t_crdt">
                                                <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                </div>
                                            </div>--%>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Communication</label>
                                                <select class="custom-select rounded-0" data-dropdown-css-class="select2-danger" style="width: 100%;" onchange="Get_CommunicationValue();" id="t_comm">
                                                    <option value="1">Inter Department</option>
                                                    <option value="2">Intra Department</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="exampleInputEmail1">Assign Department</label>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Department" onchange="GetDepartment(this.Value)" id="t_dept">
                                                </div>
                                                <div class="input-group-append">
                                                    <button id="btnDepartment" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_dept','HelpPages/DepartmentList')"><i class="fa fa-fw fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_deptdesc" for="css"></label>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Attachment</label>
                                                <input type="file" class="form-control" multiple="multiple" id="postedFiles">
                                                <input type="hidden" class="form-control" id="t_fnam">
                                                <input type="hidden" class="form-control" id="t_fpat">
                                            </div>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Remark</label>

                                                <input type="text" class="form-control" placeholder="Enter Remark" autocomplete="off" value="" id="t_rmrk">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="exampleInputEmail1" id="lblassigndept">Assign to user</label>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Assign User" onchange="GetAssignuser(this.Value)" id="t_taat">
                                                </div>
                                                <div class="input-group-append">
                                                    <button id="btnAssignUser" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_taat','HelpPages/UserList')"><i class="fa fa-fw fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_userdesc" for="css"></label>
                                        </div>

                                    </div>
                                    <div class="card-footer">
                                        <div class="form-group" style="text-align: right">
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
        </div>
    </section>
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
                toastr.error('Excel sheet imported sucessfully...')
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
    <script type="text/javascript">
        $('#checkother').change(function () {

            if (this.checked) {
                //var salord = $('#t_sord').val();
                $('#t_sord').val('Other');
            } else {
                $('#t_sord').val('');
            }
        });

    </script>
    <!-- /.row -->
    <!-- /.container-fluid -->

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

    <!-- Datatable -->
    <%--<script src="plugins/datatables/jquery.dataTables.min.js"></script>
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
    <script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>--%>
</asp:Content>
