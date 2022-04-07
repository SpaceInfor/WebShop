<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="TaskDetail.aspx.cs" Inherits="WebShop.TaskDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Task Detail</title>

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
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- dropzonejs -->
    <link rel="stylesheet" href="../../plugins/dropzone/min/dropzone.min.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">

    <%--<script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link href="plugins/summernote/summernote.css" rel="stylesheet" />


    <script type="text/javascript">

        var userid = '';
        var UserName = '';
        var t_tano = '';
        var t_dept = '';
        var t_levl = '';
        $(document).ready(function () {

            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            //const lastmoddate = urlParams.get('userId');
            userid = '<%=Session["t_usid"] %>';
            UserName = '<%=Session["t_nama"] %>';
            t_dept = '<%= Session["t_dept"] %>';
            t_levl = '<%= Session["t_levl"] %>';

            if (t_levl == 3) {
                $("#assignuserdiv").css('display', 'none');

            }
            else {
                $("#assignuserdiv").css('display', 'block');
            }

            Get_TaskDet(t_tano);
            //document.getElementById('ct1_t_rmrk').focus();
            Bind_TaskDetails(t_tano);
            Bind_TaskHeaderDetails(t_tano);
            GetCheckTaskSatus(t_tano);


        });
    </script>
    <script language="javascript">
        var ctrl;
        function openChildProcess(control, form) {

            ctrl = control

            frm = form + ".aspx?param1=" + username + "";
            //frm = form + ".aspx";
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

        function UpdateStatus() {

            var t_tano = '';
            var taskStatus = '';
            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            //var t_stat = document.getElementById('t_stat').value;
            Swal.fire({
                title: 'Do you want to close the task?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Save',
                denyButtonText: `Don't save`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    $.ajax(
                        {
                            type: "POST",
                            url: "TaskDetail.aspx/UpdateAcknowledgeStatus",
                            data: '{t_tano: "' + t_tano + '",t_stat:"' + 3 + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                if (response.d[0].toString() === "success") {

                                    toastr.success('Your task is closed.');
                                    $("#btnupdate").prop("disabled", true);
                                }
                                else {
                                    toastr.warning(response.d[0].toString());

                                }

                                if (response.d[1].toString() == 1) {
                                    taskStatus = 'Open';
                                }
                                else if (response.d[1].toString() == 2) {
                                    taskStatus = 'In-Process';
                                }
                                else {
                                    taskStatus = 'Closed';
                                }
                                //toastr.success('Record updated successfully');
                                document.getElementById("t_stat").innerHTML = taskStatus;


                            },
                            failure: function (response) {
                                alert(response.d);
                            }
                        })
                    Swal.fire('Saved!', '', 'success')
                } else if (result.isDenied) {
                    Swal.fire('Changes are not saved', '', 'info')
                }
            })
        }


        function UpdateAcknowledge() {

            var t_tano = '';
            var taskStatus = '';
            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            //var t_stat = document.getElementById('t_stat').value;

            Swal.fire({
                title: 'Do you want to change the status In-Process?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Save',
                denyButtonText: `Don't save`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {

                    $.ajax(
                        {
                            type: "POST",
                            url: "TaskDetail.aspx/UpdateHeaderStatus",
                            data: '{t_tano: "' + t_tano + '",t_stat:"' + 2 + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                if (response.d[0].toString() === "success") {


                                    toastr.success('Your task is In-Process.');
                                    $("#btnacknowledge").prop("disabled", true);

                                }
                                else {
                                    toastr.warning(response.d[0].toString());

                                }
                                if (response.d[1].toString() == 1) {
                                    taskStatus = 'Open';
                                }
                                else if (response.d[1].toString() == 2) {
                                    taskStatus = 'In-Process';
                                }
                                else {
                                    taskStatus = 'Closed';
                                }
                                //toastr.success('Record updated successfully');
                                document.getElementById("t_stat").innerHTML = taskStatus;
                            },
                            failure: function (response) {
                                alert(response.d);
                            }
                        })
                    Swal.fire('Saved!', '', 'success')
                } else if (result.isDenied) {
                    Swal.fire('Changes are not saved', '', 'info')
                }
            })
        }
    </script>
    <script type="text/javascript">
        function CheckAssignUser() {

            var t_taatcode = document.getElementById("t_taat").innerHTML;
            var t_usidcode = document.getElementById("t_usid").value;
            userid = '<%= Session["t_usid"] %>';
            if (userid == t_usidcode) {

            }
            else if (t_taatcode == "") {
                toastr.error('User does not assigned to this task,You can not send message.');
                $("#ct1_t_rmrk").val('');
            }

        }
    </script>


    <script type="text/javascript">
        function GetAssignuser(t_taat1) {
            var t_taatcode = $("#t_taat1").val();

            if (t_taatcode == "") {
                $("#t_userdesc").html("");
                $("#t_taat1").val("");
            }
            else {

                $.ajax({
                    url: "TaskDetail.aspx/GetUserName",
                    data: '{t_taat :"' + t_taatcode + '"}',
                    type: "POST",
                    contentType: "application/json;charset=UTF-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d.length === 0) {
                            $("#t_userdesc").html("");

                            //$("#t_taat1").val("");

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

            }
            //return false;
        }
    </script>
    <script type="text/javascript">

        function AddNewInput(Action) {

            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            userid = '<%= Session["t_usid"] %>';

            var isValid = true;
            if ($('#ct1_t_rmrk').val() == "") {
                $('#ct1_t_rmrk').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ct1_t_rmrk').css('border-color', 'lightgrey');
            }

            //isValid = validate();
            if (isValid == false) {
                return false;
            }

            if (t_tano != "") {
                if (userid != "") {

                    var profilephotofiles = $("#postedFiles").get(0).files;
                    var formdata = new FormData();

                    for (var i = 0; i < profilephotofiles.length; i++) {
                        formdata.append("postedFiles", profilephotofiles[i]);
                    }

                    //Add the input element values
                    formdata.append("t_tano", t_tano);
                    formdata.append("t_usid", userid);
                    formdata.append("t_rmrk", document.getElementById('ct1_t_rmrk').value);
                    formdata.append("t_stat", 1);
                    formdata.append("t_flag", Action);


                    $.ajax({
                        type: "POST",
                        //url: "Task_list.aspx/saveTask",
                        url: "TaskDetailHandler.ashx",
                        contentType: false,
                        processData: false,
                        data: formdata,

                        success: function (result) {

                            //$('#t_usid').val("");
                            $('#ct1_t_rmrk').val('');
                            document.getElementById("postedchoose").value = '';
                            //$(".custom-file-label").val(''); 
                            //$('#t_taat').val("");
                            $("#btnAdd").attr("onclick", "AddInput('I',0)");
                            $("#btnAdd").attr("value", "Add");
                            //For Remove the Input File from Uploader

                            Bind_TaskDetails(t_tano);
                            Bind_TaskHeaderDetails(t_tano);


                            if (result == 'This task is already closed') {
                                toastr.error(result);
                            }
                            else {
                                toastr.success(result);
                            }
                        },
                        error: function (xhr, status, error) {
                            var err = eval(xhr.responseText);
                            alert(err);
                            toastr.e("There was error uploading files!");
                        }
                    });
                }
                else {
                    toastr.warning("User id is not found");
                }
            }
            else {
                toastr.warning("Task no. is not found");
            }
        }


        function validate() {

            var isValid = true;
            if ($('#ct1_t_rmrk').val() == "") {
                $('#ct1_t_rmrk').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ct1_t_rmrk').css('border-color', 'lightgrey');
            }
        }

    </script>

    <script type="text/javascript">
        function Bind_TaskDetails(t_tano) {

            $.ajax({

                type: "POST",
                url: "TaskDetail.aspx/GetTaskDetails",
                data: "{'t_tano': '" + t_tano + "'}",
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


                            { "data": "t_tano", "title": "Task ID" },
                            { "data": "t_nama", "title": "User Name" },
                            { "data": "t_rpdt", "title": "Date" },
                            { "data": "t_rmrk", "title": "Message" },
                            //{ "data": "t_fpat", "title": "File Path" },
                            //{
                            //    data: null, "title": "File", render: function (data, type, row, meta) {
                            //        return '<a href="' + row.t_fpat + '" <i class="fas fa-download badge bg-primary" download></i>Download File</a>'
                            //    }
                            //},
                            {

                                data: null, "title": "View", render: function (data, type, row, meta) {
                                    if (row.t_fpat == "") {
                                        return '<div><a href="#" onclick="Bind_ViewAttachment(' + "'" + row.t_tano + "'" + ',' + "'" + row.t_pono + "'" + ')" value="0" data-toggle="modal" data-target="#myModalDetailAttachment"></a></div>';
                                    }
                                    else {
                                        return '<div><a href="#" onclick="Bind_ViewAttachment(' + "'" + row.t_tano + "'" + ',' + "'" + row.t_pono + "'" + ')" value="0" data-toggle="modal" data-target="#myModalDetailAttachment"><i class="fas fa-paperclip"></i></a></div>';
                                    }
                                }
                            },
                        ]
                    }).buttons().container().appendTo('#tbltaskDetails_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>

    <script type="text/javascript">
        function Bind_TaskHeaderDetails(t_tano) {

            $.ajax({

                type: "POST",
                url: "TaskDetail.aspx/GetHeaderDetails",
                data: "{'t_tano': '" + t_tano + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: false,
                success: function (data) {
                    var datatableVariable = $('#tbltaskAttachDetails').DataTable({
                        "responsive": true, "lengthChange": false, "autoWidth": false,
                        "buttons": ["excel", "pdf", "print"],
                        "bDestroy": true,
                        data: data.d,
                        columns: [

                            { "data": "t_tsrn", "title": "Sr.No" },
                            //{ "data": "t_pono", "title": "Task Status" },
                            {

                                data: null, "title": "Status", render: function (data, type, row, meta) {
                                    var CommStatus = "";
                                    if (row.t_pono == 0) {
                                        CommStatus = "Header";
                                        return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                    }
                                    else {
                                        CommStatus = "Details";
                                        return '<div' + CommStatus + '" class="badge bg-danger">' + CommStatus + '</div>';
                                    }

                                }
                            },
                            { "data": "t_fnam", "title": "t_fnam" },
                            {

                                data: null, "title": "File", render: function (data, type, row, meta) {
                                    if (row.t_fpat == "") {
                                        return '<a href="' + row.t_fpat + '" id="viewdownload"</a>'
                                    }
                                    else {
                                        return '<a href="' + row.t_fpat + '" id="viewdownload" <i class="fas fa-download" Download></i></a>'
                                    }
                                }
                            }

                        ]
                    }).buttons().container().appendTo('#tbltaskAttachDetails_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>
    <script type="text/javascript">
        function GetCheckTaskSatus(t_tano) {

            var checkStatus = '';
            var originuserid = '';
            var comm = '';
            var AssignId = '';
            //var OriginDept = '';
            //var AssignDept = ''
            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            t_levl = '<%= Session["t_levl"] %>';
            t_usid = '<%= Session["t_usid"] %>';

            $.ajax({
                url: "TaskDetail.aspx/GetTaskStatus",
                data: '{t_tano :"' + t_tano + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {

                        checkStatus = response.d[0].t_stat;
                        originuserid = response.d[0].t_usid;
                        OriginDept = response.d[0].t_odep;
                        AssignDept = response.d[0].t_dept;
                        comm = response.d[0].t_comm;
                        AssignId = response.d[0].t_taat;
                        //For Level 1
                        //Task cretaed by Own Orgin Task
                        if (t_levl == 1 && (comm == 1 || 2) && t_usid == originuserid) {

                            if (checkStatus == 1) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }

                        }
                        else if (t_levl == 1 && comm == 1 && t_usid != originuserid) {
                            if (checkStatus == 1 || 2 || 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);
                            }
                        }
                        //Task Given to other Level 1 person(Received Task)
                        else if (t_levl == 1 && comm == 2 && t_usid != originuserid) {
                            if (checkStatus == 1) {

                                $("#btnacknowledge").prop("enabled", true);
                                $("#btnupdate").prop("disabled", true);
                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);
                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);
                            }
                        }
                        //Finished level 1
                        //For Level 2
                        //Task created by Own Department

                        if (t_levl == 2 && (comm == 1 || 2) && t_usid == originuserid) {
                            //if (t_levl == 2 && (comm == 1 || 2) && t_dept == OriginDept || t_dept == AssignDept) {
                            if (checkStatus == 1) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }

                        }
                        else if (t_levl == 2 && (comm == 1 || 2) && t_usid != originuserid) {
                            if (checkStatus == 1) {

                                if (AssignId == '') {
                                    $("#btnacknowledge").prop("disabled", true);
                                    $("#btnupdate").prop("disabled", true);
                                }
                                else {
                                    $("#btnacknowledge").prop("enabled", true);
                                    $("#btnupdate").prop("disabled", true);
                                }

                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }

                        }
                        //Task Given to other department  Level 1 or Level 3 person(Received Task)
                        //else if (t_levl == 2 && (comm == 1 || 2) && t_dept != OriginDept) {
                        //    if (checkStatus == 1 || 2 || 3) {

                        //        $("#btnacknowledge").prop("disabled", true);
                        //        $("#btnupdate").prop("disabled", true);

                        //    }
                        //}
                        //For Level 3
                        //Task created by Own Department

                        if (t_levl == 3 && (comm == 1 || 2) && t_usid == originuserid) {
                            if (checkStatus == 1) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("enabled", true);

                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }
                        }
                        else if (t_levl == 3 && (comm == 1 || 2) && t_usid != originuserid) {
                            if (checkStatus == 1) {

                                $("#btnacknowledge").prop("enabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }
                            else if (checkStatus == 2) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }
                            else if (checkStatus == 3) {

                                $("#btnacknowledge").prop("disabled", true);
                                $("#btnupdate").prop("disabled", true);

                            }
                        }
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
                        "responsive": true, "lengthChange": false, "autoWidth": false,
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
                                        CommStatus = "Header";
                                        return '<div' + CommStatus + '" class="badge bg-warning">' + CommStatus + '</div>';
                                    }
                                    else {
                                        CommStatus = "Details";
                                        return '<div' + CommStatus + '" class="badge bg-success">' + CommStatus + '</div>';
                                    }

                                }
                            },
                            { "data": "t_fnam", "title": "File Name" },
                            {
                                data: null, "title": "File", render: function (data, type, row, meta) {
                                    return '<a href="' + row.t_fpat + '" <i class="fas fa-download" Download></i></a>'
                                }
                            },

                        ]
                    }).buttons().container().appendTo('#tblViewAttachDetails_wrapper .col-md-6:eq(0)');
                }
            });
        }
    </script>
    <script type="text/javascript">
        function Get_TaskDet(t_tano) {

            var taskStatus = '';
            t_dept = '<%= Session["t_dept"] %>';
            userid = '<%= Session["t_usid"] %>';
            t_levl = '<%= Session["t_levl"] %>';

            $.ajax({
                type: "POST",
                url: "TaskDetail.aspx/GetTaskWise",
                data: "{'t_tano': '" + t_tano + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {

                        document.getElementById("taskid").value = response.d[0].t_tnam;
                        document.getElementById("t_tano").innerHTML = t_tano;
                        document.getElementById("t_tnam").innerHTML = response.d[0].t_tnam;
                        document.getElementById("t_sord").innerHTML = response.d[0].t_sord;
                        document.getElementById("t_tdes").innerHTML = response.d[0].t_tdes;
                        /*document.getElementById("t_comm").value = response.d[0].t_comm;*/
                        document.getElementById("t_crdt").innerHTML = response.d[0].t_crdt;
                        document.getElementById("t_codt").innerHTML = response.d[0].t_codt;
                        document.getElementById("t_deptdesc").innerHTML = response.d[0].assigndept;
                        document.getElementById("t_usid").value = response.d[0].t_usid;
                        //document.getElementById("t_stat").value = response.d[0].t_stat;


                        if (response.d[0].t_stat == 1) {
                            taskStatus = 'Open';
                        }
                        else if (response.d[0].t_stat == 2) {
                            taskStatus = 'In-Process';
                        }
                        else {
                            taskStatus = 'Closed';
                        }
                        document.getElementById("t_stat").innerHTML = taskStatus;
                        document.getElementById("t_rmrk").innerHTML = response.d[0].t_rmrk;

                        //For Departmentwise block hide and show div 
                        if (t_dept == response.d[0].t_dept && t_levl == 2 && response.d[0].t_taat == '') {
                            $("#assignuserdiv").css('display', 'block');
                        }
                        else {
                            $("#assignuserdiv").css('display', 'none');
                        }


                        if (response.d[0].t_taat != '') {

                            document.getElementById("t_taat").innerHTML = (response.d[0].t_taat) + ' ' + '(' + response.d[0].assignname + ')';
                            $("#btnacknowledge").prop("disabled", false);
                        }

                        //if (t_levl == 1 && userid == response.d[0].t_usid) {
                        //     $("#btnupdate").prop("enabled", true);
                        //    $("#btnacknowledge").prop('disabled', true);
                        //}
                        //if (t_levl == 2 && t_dept == response.d[0].t_dept) {
                        //    debugger
                        //     $("#btnupdate").prop("disabled", true);
                        //    $("#btnacknowledge").prop('enabled', true);
                        //}
                        // if (t_levl == 3 && userid == response.d[0].t_usid) {
                        //     $("#btnupdate").prop("disabled", true);
                        //    $("#btnacknowledge").prop('enabled', true);
                        //}
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function AssignUser(t_flag) {

            const urlParams = new URLSearchParams(window.location.search);
            t_tano = urlParams.get('t_tano');
            var t_taat1 = $("#t_taat1").val();
            if (t_taat1 != "") {

                $.ajax(
                    {
                        type: "POST",
                        url: "TaskDetail.aspx/updateAssignUser",
                        data: '{t_tano: "' + t_tano + '",t_taat1: "' + document.getElementById('t_taat1').value + '",t_flag:"' + t_flag + '"}',
                        //,t_cwoc: "' + document.getElementById('t_cwoc').value + '",t_mcrt: "' + document.getElementById('t_mcrt').value + '",t_mccp: "' + document.getElementById('t_mccp').value + '",t_mdcp: "' + document.getElementById('t_mdcp').value + '"
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        ////success: GetLineData,
                        success: function (response) {
                            if (response.d[0].toString() === "success") {

                                //$('#MachineModal').modal('hide');
                                $('#t_taat1').val("");
                                $('#t_userdesc').html("");
                                Get_TaskDet(t_tano);
                                //$("#btnacknowledge").prop("enabled", true);
                                toastr.success('User assigned successfully');
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
            else {
                toastr.error('Please Select User Before Assign.');
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">


    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Task Detail</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="TaskDashboard.aspx">Home</a></li>

                        <li class="breadcrumb-item active">Task Details</li>
                    </ol>
                </div>
            </div>
        </div>

    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <%-- <div class="callout callout-info">--%>
                    <div class="card card-outline card-warning">
                        <div class="card-header">
                            <h3 class="card-title"><b><span id="t_taskid"></span></b>Task Detail</h3>
                            <div class="card-tools">
                                <a class="btn-warning btn-xs" href="Task_list.aspx"><i class="fas fa-backward"></i></a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="not-bold">Task Id :</label>

                                                <label for="exampleInputEmail1" style="color: gray" class="" id="t_tano"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="not-bold">Task Name :</label>
                                                <%-- <p>Task Name :</p>--%>
                                                <label for="exampleInputEmail1" style="color: gray" class="" id="t_tnam"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Task Description :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_tdes"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="not-bold">Assign Department  :</label>
                                                <%-- <p>Task Name :</p>--%>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_deptdesc"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Remark :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_rmrk"></label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Sales Order :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_sord"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Creation Date :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_crdt"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Expected Delivery Date :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_codt"></label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Task Assigned User :</label>
                                                <label for="exampleInputEmail1" style="color: gray" id="t_taat"></label>
                                                <input type="hidden" class="form-control" id="t_usid">
                                            </div>

                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Status :</label>
                                                <label for="exampleInputEmail1" style="color: gold" id="t_stat"></label>
                                                <%--<select class="custom-select rounded-0" data-dropdown-css-class="select2-danger" style="width: 50%" id="t_stat">
                                                    <option value="1">Pending</option>
                                                    <option value="2">In-Process</option>
                                                    <option value="3">Close</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">


                            <div class="form-group" id="assignuserdiv" style="display: none">
                                <div class="col-md-4">
                                    <label for="exampleInputEmail1" id="lblassigndept">Assign user</label>
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Enter Assign User" onchange="GetAssignuser(this.Value)" id="t_taat1">
                                        </div>
                                        <div class="input-group-append">
                                            <%-- <div class="col-4">--%>
                                            <button id="btnAssignUser" type="button" class="btn btn-block btn-warning" onclick="openChildProcess('t_taat1','HelpPages/UserList')"><i class="fa fa-fw fa-search"></i></button>
                                            <%-- </div>--%>
                                        </div>
                                        <div class="col-2">
                                            <input type="button" class="btn btn-warning waves-effect" onclick="AssignUser('U')" id="btnAssign" value="Assign User" />
                                        </div>
                                    </div>
                                    <label id="t_userdesc" for="css"></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6">
                                    <input type="button" class="btn btn-warning" onclick="UpdateAcknowledge();" id="btnacknowledge" value="Acknowledge" />
                                    <input type="button" class="btn btn-warning" onclick="UpdateStatus();" id="btnupdate" value="Close Task" />
                                    <input type="button" class="btn btn-warning" id="btnViewAttach" value="View Attachment" data-toggle="modal" data-target="#myModalHeaderAttachment" />
                                    <%--<input type="button" class="btn btn-secondary" id="btnback" onclick="window.open('Task_list.aspx', 'Task_list');" value="Back" />--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--   /////////////////////////////--%>
        </div>
        <%-- </div>--%>
    </section>


    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="callout callout-warning">
                        <%-- <div class="card direct-chat direct-chat-primary">--%>
                        <div class="card-header">

                            <h3 class="card-title"><i class="fas fa-comments"></i>Task Support</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">
                                        <textarea class="form-control" rows="4" cols="75" id="ct1_t_rmrk" placeholder="Enter reply here...!!!" onchange="CheckAssignUser()"></textarea>
                                        <label for="exampleInputFile">File Attachement</label>
                                        <div class="input-group">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" multiple="multiple" name="postedFiles" id="postedFiles">
                                                <label class="custom-file-label" for="exampleInputFile" id="postedchoose">Choose file</label>
                                                <input type="hidden" class="form-control" id="t_fnam">
                                                <input type="hidden" class="form-control" id="t_fpat">
                                            </div>
                                            <div class="input-group-append">
                                                <input type="button" class="btn btn-warning" onclick="AddNewInput('I')" id="btnsend" value="Send" />

                                            </div>

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
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-outline card-warning">
                        <div class="card-header">

                            <h3 class="card-title"><b><span id="t_taskname1"></span>Reply of Task Details</b></h3>
                            <div class="card-tools">
                                <span class="float-right username"><a href="#" id="taskid"></a></span>
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="ct1_UpdatePanel1">

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card card-outline">
                                            <div class="card-header">
                                                <div class="card-tools">
                                                </div>
                                            </div>

                                            <div class="card-body table-responsive p-0">
                                                <table class="table table-bordered table-striped" id="tbltaskDetails">
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
        </div>
    </section>

    <div class="modal fade" id="myModalHeaderAttachment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">

        <div class="modal-dialog modal-lg" tabindex="-1">
            <div class="modal-content" tabindex="-1">
                <div class="modal-header" tabindex="-1">
                    <h4 class="modal-title" id="myModalLabel1">View Attachment</h4>
                    <button type="button" class="close" data-dismiss="modal">×</button>

                </div>
                <div class="modal-body" tabindex="-1">
                    <div class="card-body">
                        <div class="card-body table-responsive p-0">
                            <table class="table table-bordered table-striped" id="tbltaskAttachDetails">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModalDetailAttachment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">

        <div class="modal-dialog modal-lg" tabindex="-1">
            <div class="modal-content" tabindex="-1">
                <div class="modal-header" tabindex="-1">
                    <h4 class="modal-title" id="myModalLabel2">View Detail Attachment</h4>
                    <button type="button" class="close" data-dismiss="modal">×</button>

                </div>
                <div class="modal-body" tabindex="-1">
                    <div class="card-body">
                        <div class="card-body table-responsive p-0">
                            <table class="table table-bordered table-striped" id="tblViewAttachDetails">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            bsCustomFileInput.init();
        });
    </script>

    <!-- /.container-fluid -->
    <script>
        $(function () {
            //$('.summernote').summernote();
            //Initialize Select2 Elements
            //$('.select2').select2()

            //Initialize Select2 Elements
            //$('.select2bs4').select2({
            //    theme: 'bootstrap4'
            //})

            //Datemask dd/mm/yyyy
            $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
            //Datemask2 mm/dd/yyyy
            $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
            //Money Euro
            $('[data-mask]').inputmask()

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

            // DropzoneJS Demo Code Start
            //Dropzone.autoDiscover = false

            //// Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
            //var previewNode = document.querySelector("#template")
            //previewNode.id = ""
            //var previewTemplate = previewNode.parentNode.innerHTML
            //previewNode.parentNode.removeChild(previewNode)

            //var myDropzone = new Dropzone(document.body, { // Make the whole body a dropzone
            //    url: "/target-url", // Set the url
            //    thumbnailWidth: 80,
            //    thumbnailHeight: 80,
            //    parallelUploads: 20,
            //    previewTemplate: previewTemplate,
            //    autoQueue: false, // Make sure the files aren't queued until manually added
            //    previewsContainer: "#previews", // Define the container to display the previews
            //    clickable: ".fileinput-button" // Define the element that should be used as click trigger to select files.
            //})

            //myDropzone.on("addedfile", function (file) {
            //    // Hookup the start button
            //    file.previewElement.querySelector(".start").onclick = function () { myDropzone.enqueueFile(file) }
            //})

            //// Update the total progress bar
            //myDropzone.on("totaluploadprogress", function (progress) {
            //    document.querySelector("#total-progress .progress-bar").style.width = progress + "%"
            //})

            //myDropzone.on("sending", function (file) {
            //    // Show the total progress bar when upload starts
            //    document.querySelector("#total-progress").style.opacity = "1"
            //    // And disable the start button
            //    file.previewElement.querySelector(".start").setAttribute("disabled", "disabled")
            //})

            //// Hide the total progress bar when nothing's uploading anymore
            //myDropzone.on("queuecomplete", function (progress) {
            //    document.querySelector("#total-progress").style.opacity = "0"
            //})

            //// Setup the buttons for all transfers
            //// The "add files" button doesn't need to be setup because the config
            //// `clickable` has already been specified.
            //document.querySelector("#actions .start").onclick = function () {
            //    myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED))
            //}
            //document.querySelector("#actions .cancel").onclick = function () {
            //    myDropzone.removeAllFiles(true)
            //}
            // DropzoneJS Demo Code End



        })

    </script>

    <script src="plugins/daterangepicker/daterangepicker.js"></script>

    <script src="../../plugins/select2/js/select2.full.min.js"></script>
    <!-- jQuery -->

    <!-- Page specific script -->

    <script src="../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/summernote/summernote.js"></script>
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
