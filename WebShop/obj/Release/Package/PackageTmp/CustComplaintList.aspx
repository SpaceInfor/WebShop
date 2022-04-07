<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="CustComplaintList.aspx.cs" Inherits="WebShop.CustComplaintList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  <script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
  <script src="Scripts/sum.js"></script>
  <title>ORDER DASHBOARD REPORT</title>
      <script type="text/javascript">
        $(document).ready(function () {
          debugger
          
          Bind_Complaint_Lines('A');
          BindStatusData();
        });
      </script>
  <script type = "text/javascript">
    function BindStatusData() {
      debugger
      $.ajax({
        type: "POST",
        url: "CustComplaintList.aspx/GetStatusDetails",
        data: '{ }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
          if (response.d != '') {
            var orno = JSON.parse(response.d);
            $('#t_open').html(orno.t_open);
            $('#t_inpr').html(orno.t_inpr);
            $('#t_clos').html(orno.t_clos);
            $('#t_pnfs').html(orno.t_pnfs);
            $('#t_pnfu').html(orno.t_pnfu);

          }
          else {
            $('#t_open').html('0');
            $('#t_inpr').html('0');
            $('#t_clos').html('0');
            $('#t_pnfs').html('0');
            $('#t_pnfu').html('0');
          }
        },
        error: function (response) {
          alert(response.responseText);
        }
      });
    }
    </script>
  
      <script type="text/javascript">
        function Bind_Complaint_Lines(flag) {
              debugger
              $.ajax(
                {
                  type: "POST",
                  url: "CustComplaintList.aspx/GetComplaintLines",
                  data: '{t_flag: "' + flag + '" }',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: BindTable,
                  failure: function (response) {
                    alert(response.d);
                  },
                  error: function (response) {
                    alert(response.d);
                  }
                });
            }
            function BindTable(response) {
              debugger
              $("#example1").DataTable(
                {
                  destroy: true,
                  "responsive": true, "lengthChange": true, "autoWidth": false,
                  "deferRender": true, "paging": true,
                  "buttons": ["csv", "excel", "print", "colvis"],
                  data: response.d,
                  columns: [
                    { 'data': null, title: 'Select', wrap: true, "render": function (item) { return '<a href="CustComplaints.aspx?t_cono='+item.t_cono+'"><i class="far fa-plus-square"></i></a>' } },
                    { 'data': 't_cono', 'title': 'Complaint No' },
                    { 'data': 't_codt', 'title': 'Complaint Date' },
                    { 'data': 't_worn', 'title': 'CPS No' },
                    { 'data': 't_orno', 'title': 'Sales Order' },
                    { 'data': 't_prbp', 'title': 'Branch' },
                    { 'data': 't_comt', 'title': 'Complaint Text' },
                    { 'data': 't_rsol', 'title': 'Redressal' },
                    { 'data': 't_cldt', 'title': 'Redressal Date' },
                    { 'data': 't_cost', 'title': 'Status' },
                    { 'data': null, title: 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_cono + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },
                  ]
                }).buttons().container().appendTo('#example1_wrapper .col-lg-6:eq(0)');;
            };
      </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Customer Complaint List</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Customer Complaint List</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-8">
          <div class="card">
            <div class="card-header">
         
              <div class="card-tools">
                
                <a  class="btn btn-warning waves-effect float-right" id="btnAddNew" href="CustComplaints.aspx" ><i class="fas fa-plus"></i> Add New</a>
              </div>
            </div>  
            <div class="card-body table-responsive p-0">
                <table id="example1" class="table table-bordered table-striped">
              
                </table>
            </div>
          </div>
        </div>
        <div class="col-md-4">
            <!-- Info Boxes Style 2 -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="far fa-folder-open"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Open Complaints</span>
                <a href="javascript:Bind_Complaint_Lines('1')"><h3 class="headline text-warning" id="t_open">0</h3></a> 
              </div>
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              
              
              <span class="info-box-icon"><i class="fas fa-spinner"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">In Process Complaint</span>
                <a href="javascript:Bind_Complaint_Lines('2')"><h3 class="headline text-info" id="t_inpr">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="far fa-check-square"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Closed Complaints</span>
                <a href="javascript:Bind_Complaint_Lines('3')"><h3 class="headline text-success" id="t_clos">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fas fa-hourglass-end"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Awaiting Response from Service</span>
                <a href="javascript:Bind_Complaint_Lines('C')"><h3 class="headline text-danger" id="t_pnfs">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>

            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon" ><i class="fas fa-hourglass-start"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Response from Customer</span>
                <a href="javascript:Bind_Complaint_Lines('S')"><h3 class="headline text-muted" id ="t_pnfu" >0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>
          </div>
      </div>
      
  </section>
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
   <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
   <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<%--    <script src="../../plugins/jquery/jquery.min.js"></script>--%>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
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
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

</asp:Content>
