<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="TaskDashboard.aspx.cs" Inherits="WebShop.TaskDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Task Dashboard</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">


    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

    <%-- <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <%-- <script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>--%>

    <script type="text/javascript">
        var userid = '';
        var UserName = '';
        var t_dept = '';
        var t_levl = '';
        $(document).ready(function () {

            const urlParams = new URLSearchParams(window.location.search);
            const lastmoddate = urlParams.get('t_usid');

            userid = '<%= Session["t_usid"] %>';
            UserName = '<%= Session["t_nama"] %>';
            t_dept = '<%= Session["t_dept"] %>';
            t_levl = '<%= Session["t_levl"] %>';

            Get_OpenTask();
            //Get_TotalTask();
            Get_InProgressTask();
            Get_CloseTask();
            Bind_TaskDetails('1')
        });
    </script>


    <script type="text/javascript">
        function Bind_TaskDetails(t_stat) {

            t_levl = '<%= Session["t_levl"] %>';
            var taat = ''
           <%-- t_taat = '<%= Session["t_usid"] %>';--%>
            t_usid = '<%= Session["t_usid"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            t_odep = '<%= Session["t_dept"] %>';

            if (t_levl == 1) {

                $.ajax({

                    type: "POST",
                    url: "TaskDashboard.aspx/GetTaskDetails",
                    data: '{t_stat :' + t_stat + '}',
                    //,t_taat:"'+ t_taat +'" ,t_odep:"' + t_odep + '"
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    processData: false,
                    success: function (data) {


                        var datatableVariable = $('#tbltaskdetail').DataTable({
                            "responsive": true, "lengthChange": false, "autoWidth": true,
                            "buttons": ["excel", "pdf", "print"],
                            "bDestroy": true,
                            data: data.d,
                            columns: [

                                { "data": "t_link", "title": "#" },
                                { "data": "t_tano", "title": "Task ID" },
                                { "data": "t_sord", "title": "Sales Order" },
                                { "data": "t_tnam", "title": "Task Name" },
                                { "data": "t_tdes", "title": "Task Description" },
                                { "data": "t_usid", "title": "Task Origin Id" },
                                { "data": "originname", "title": "Task Origin Name" },
                                { "data": "t_taat", "title": "Task Assign Id" },
                                { "data": "assignname", "title": "Task Assign Name" },
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

                                { "data": "t_odep", "title": "Origin Department Id" },
                                { "data": "orgindept", "title": "Origin Department" },
                                { "data": "t_dept", "title": "Assign Department Id" },
                                { "data": "assigndept", "title": "Assign Department" },
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
                                { "data": "t_rmrk", "title": "Remark" },
                                //{ "data": "ResponseTime", "title": "Response Time" },
                                {

                                    data: null, "title": "Response Time", render: function (data, type, row, meta) {
                                        var ResponseStatus = "";

                                        if (row.t_ipdt == '01-Jan-70 12:00:00 AM') {

                                            ResponseStatus = "Not In-Progress";
                                            return '<div' + ResponseStatus + '" class="badge bg-danger">' + ResponseStatus + '</div>';
                                        }
                                        else {
                                            ResponseStatus = row.ResponseTime;
                                            return '<div' + ResponseStatus + '" class="badge bg-success">' + ResponseStatus + '</div>';
                                        }

                                    }
                                },
                                //{ "data": "CloserTime", "title": "Closer Time" },
                                {

                                    data: null, "title": "Closer Time", render: function (data, type, row, meta) {
                                        var CloseStatus = "";
                                        if (row.t_cldt == '01-Jan-70 12:00:00 AM') {
                                            CloseStatus = "Not Closed";
                                            return '<div' + CloseStatus + '" class="badge bg-danger">' + CloseStatus + '</div>';
                                        }
                                        else {
                                            CloseStatus = row.CloserTime;
                                            return '<div' + CloseStatus + '" class="badge bg-success">' + CloseStatus + '</div>';
                                        }

                                    }
                                },
                                { "data": "OpenTime", "title": "Open Time" }

                            ]

                        }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                    }
                });

            }

            else if (t_levl == 2) {

                if (t_stat == 1) {
                    t_odep = '<%= Session["t_dept"] %>';
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetInOpenTask",
                        data: '{t_odep:"' + t_odep + '",t_stat:"' + t_stat + '"}',
                        //,t_taat:"'+ t_taat +'" ,t_odep:"' + t_odep + '"
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [

                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
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

                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
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
                                    { "data": "t_rmrk", "title": "Remark" },
                                ]

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else if (t_stat == 2) {
                    t_odep = '<%= Session["t_dept"] %>';
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetInProcessTask",
                        data: '{t_odep:"' + t_odep + '",t_stat:"' + t_stat + '"}',
                        //,t_taat:"'+ t_taat +'" ,t_odep:"' + t_odep + '"
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [

                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
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

                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
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
                                    { "data": "t_rmrk", "title": "Remark" },
                                ]

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });

                }
                else if (t_stat == 3) {
                    t_odep = '<%= Session["t_dept"] %>';
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetInCloseTask",
                        data: '{t_odep:"' + t_odep + '",t_stat:"' + t_stat + '"}',
                        //,t_taat:"'+ t_taat +'" ,t_odep:"' + t_odep + '"
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [

                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
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

                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
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
                                    { "data": "t_rmrk", "title": "Remark" },
                                ]

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });

                }
                else {

                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetIntraTaskDetails",
                        data: '{t_odep:"' + t_odep + '"}',
                        //,t_taat:"'+ t_taat +'" ,t_odep:"' + t_odep + '"
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": true,
                                "buttons": ["excel", "pdf", "print"],
                                "bDestroy": true,
                                data: data.d,
                                columns: [

                                    { "data": "t_link", "title": "#" },
                                    { "data": "t_tano", "title": "Task ID" },
                                    { "data": "t_sord", "title": "Sales Order" },
                                    { "data": "t_tnam", "title": "Task Name" },
                                    { "data": "t_tdes", "title": "Task Description" },
                                    { "data": "t_usid", "title": "Task Origin Id" },
                                    { "data": "originname", "title": "Task Origin Name" },
                                    { "data": "t_taat", "title": "Task Assign Id" },
                                    { "data": "assignname", "title": "Task Assign Name" },
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

                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },
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
                                    { "data": "t_rmrk", "title": "Remark" },
                                ]

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }

            }
            else if (t_levl == 3) { //&& t_odep != ''

                userid = '<%= Session["t_usid"] %>';

                if (t_stat == 1) {
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetTaskDetailsLevel3Open",
                        data: '{t_usid :"' + userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {
                            var datatableVariable = $('#tbltaskdetail').DataTable({
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
                                    { "data": "assigndept", "title": "Task Assign Name" },
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
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },

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

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else if (t_stat == 2) {
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetTaskDetailsLevel3InProc",
                        data: '{t_usid :"' + userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
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
                                    { "data": "assigndept", "title": "Task Assign Name" },
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
                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },

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

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else if (t_stat == 3) {
                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetTaskDetailsLevel3InClose",
                        data: '{t_usid :"' + userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
                                "responsive": true, "lengthChange": false, "autoWidth": false,
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
                                    { "data": "assigndept", "title": "Task Assign Name" },
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

                                    { "data": "t_odep", "title": "Origin Department Id" },
                                    { "data": "orgindept", "title": "Origin Department" },
                                    { "data": "t_dept", "title": "Assign Department Id" },
                                    { "data": "assigndept", "title": "Assign Department" },

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

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
                else {

                    $.ajax({

                        type: "POST",
                        url: "TaskDashboard.aspx/GetTaskDetailsLevel3",
                        data: '{t_usid :"' + userid + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        processData: false,
                        success: function (data) {


                            var datatableVariable = $('#tbltaskdetail').DataTable({
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
                                    { "data": "assigndept", "title": "Task Assign Name" },
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

                            }).buttons().container().appendTo('#tbltaskdetail_wrapper .col-md-6:eq(0)');
                        }
                    });
                }
            }
        }
    </script>
    <script type="text/javascript">
        function Get_TotalTask() {
            t_odep = '<%= Session["t_dept"] %>';
         <%--   userid = '<%= Session["t_usid"] %>';--%>
            $.ajax({
                type: "POST",
                url: "TaskDashboard.aspx/GetTotalTaskWise",
                data: "{'t_odep': '" + t_odep + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {

                        document.getElementById("t_ttask").innerHTML = response.d[0].t_ttas;

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
        function Get_OpenTask() {

            t_odep = '<%= Session["t_dept"] %>';
            t_levl = '<%= Session["t_levl"] %>';
            t_usid = '<%= Session["t_usid"] %>';
            if (t_levl == 1) {
                var t_stat = 1;

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetOpenTaskWise1",
                    data: "{'t_stat': '" + t_stat + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_topen").innerHTML = response.d[0].t_open;

                        }
                        else {

                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 2) {

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetOpenTaskWise2",
                    data: "{'t_odep': '" + t_odep + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_topen").innerHTML = response.d[0].t_open;

                        }
                        else {

                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 3) {

                t_usid = '<%= Session["t_usid"] %>';

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetOpenTaskWise3",
                    data: "{'t_usid': '" + t_usid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_topen").innerHTML = response.d[0].t_open;

                        }
                        else {

                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }

        }
    </script>

    <script type="text/javascript">

        function Get_InProgressTask() {

            if (t_levl == 1) {

                var t_stat = 2;
                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetInProgressTaskWise1",
                    //data: "{'t_usid': '" + userid + "'}",
                    data: "{'t_stat': '" + t_stat + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_IProg").innerHTML = response.d[0].t_inpr;

                        }

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 2) {
                t_odep = '<%= Session["t_dept"] %>';

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetInProgressTaskWise2",

                    data: "{'t_odep': '" + t_odep + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_IProg").innerHTML = response.d[0].t_inpr;

                        }

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 3) {

                t_usid = '<%= Session["t_usid"] %>';
                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetInProgressTaskWise3",
                    data: "{'t_usid': '" + userid + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_IProg").innerHTML = response.d[0].t_inpr;

                        }

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
        }
    </script>

    <script type="text/javascript">

        function Get_CloseTask() {

            if (t_levl == 1) {
                var t_stat = 3;

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetCloseTaskWise1",
                    //data: "{'t_usid': '" + userid + "'}",
                    data: "{'t_stat': '" + t_stat + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_tascl").innerHTML = response.d[0].t_clos;
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 2) {
                t_odep = '<%= Session["t_dept"] %>';

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetCloseTaskWise2",
                    //data: "{'t_usid': '" + userid + "'}",
                    data: "{'t_odep': '" + t_odep + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_tascl").innerHTML = response.d[0].t_clos;
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            else if (t_levl == 3) {
                t_usid = '<%= Session["t_usid"] %>';

                $.ajax({
                    type: "POST",
                    url: "TaskDashboard.aspx/GetCloseTaskWise3",
                    data: "{'t_usid': '" + t_usid + "'}",

                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {

                            document.getElementById("t_tascl").innerHTML = response.d[0].t_clos;
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Task List</h1>

                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <%-- <li class="breadcrumb-item"><a href="CSDashboard.aspx">Home</a></li>--%>
                        <li class="breadcrumb-item active">Task List</li>
                    </ol>
                </div>
            </div>
        </div>

    </section>


    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-9">
                <div class="card card-warning card-outline">
                    <div class="card-header">
                        Task List
                         <div class="card-tools">
                             <a class="btn btn-block bg-gradient-warning" href="Task_List.aspx"><i class="fa fa-plus"></i>Go To Task List</a>
                         </div>
                        <div class="card-tools">
                        </div>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table id="tbltaskdetail" class="table table-bordered table-striped">
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <!-- Info Boxes Style 2 -->
                <div class="info-box mb-3 bg-light color-palette">
                    <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Open Task</span>
                        <a href="javascript:Bind_TaskDetails('1')">
                            <h3 class="headline text-warning" id="t_topen">0</h3>
                        </a>
                    </div>
                </div>
                <!-- /.info-box -->
                <div class="info-box mb-3 bg-light color-palette">

                    <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">In Process Task</span>
                        <a href="javascript:Bind_TaskDetails('2')">
                            <h3 class="headline text-info" id="t_IProg">0</h3>
                        </a>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <div class="info-box mb-3 bg-light color-palette">

                    <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Closed Task</span>
                        <a href="javascript:Bind_TaskDetails('3')">
                            <h3 class="headline text-success" id="t_tascl">0</h3>
                        </a>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
                <div class="info-box mb-3 bg-light color-palette">
                    <span class="info-box-icon"><i class="fas fa-hourglass-end"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Awaiting Response<br />
                            From Origin</span>
                        <a href="javascript:Bind_TaskDetails('C')">
                            <h3 class="headline text-danger" id="t_ackn">0</h3>
                        </a>
                    </div>
                    <!-- /.info-box-content -->
                </div>

                <!-- /.info-box -->
                <div class="info-box mb-3 bg-light color-palette">
                    <span class="info-box-icon"><i class="fas fa-hourglass-end"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Awaiting Response<br />
                            From Assignee</span>
                        <a href="javascript:Bind_TaskDetails('S')">
                            <h3 class="headline text-muted" id="t_closer">0</h3>
                        </a>
                    </div>
                    <!-- /.info-box-content -->
                </div>

            </div>

        </div>
    </section>

    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- ChartJS -->
    <script src="plugins/chart.js/Chart.min.js"></script>
    <!-- Sparkline -->
    <script src="plugins/sparklines/sparkline.js"></script>
    <!-- JQVMap -->
    <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
    <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <!-- daterangepicker -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
    <script src="plugins/summernote/summernote-bs4.min.js"></script>
    <!-- overlayScrollbars -->
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.js"></script>


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
    <script src="plugins/summernote/summernote.js"></script>

    <!-- Select2 -->
    <%--  <script src="../../plugins/select2/js/select2.full.min.js"></script>--%>
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
</asp:Content>
