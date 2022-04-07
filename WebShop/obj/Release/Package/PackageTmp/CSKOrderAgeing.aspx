<%@ Page Title="Sales Quotation List" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSKOrderAgeing.aspx.cs" Inherits="WebShop.CSKOrderAgeing" %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:Content ID="hd" ContentPlaceHolderID="head" runat="server">
   
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables  & Plugins -->

<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>


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

  <script type="text/javascript">
    $(document).ready(function () {
      debugger
     // get_ageing();
    });
  </script>
  <script type="text/javascript">
    function clear_table()
    {
      var table = $('#example1').DataTable();

      table
        .clear()
        .draw();
    }

    function get_ageing() {
      $.ajax({
          type: "POST",
          url: "CSKOrderAgeing.aspx/GetCustomers",
        data: '{basis: "' + document.getElementById('basis').value + '",t_frdt:"' + document.getElementById("t_frdt").value + '",t_todt:"' + document.getElementById("t_todt").value + '"}',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: OnSuccess,
          failure: function (response) {
            alert(response.d);
          },
          error: function (response) {
            alert(response.d);
          }
        });
     
    }
    function OnSuccess(response)
    {
     // clear_table();
      if (document.getElementById('basis').value == 'ORD') {
        $('#title').html("Ageing Based on Invoice to Sales Order");
      
        $("#example1").DataTable(
          {
            destroy: true,
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': 'Less than 7 days', className: 'text-right'},
              { 'data': 'b2', 'title': '7 To 21 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '22 To 30 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '31 To 35 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '36 To 40 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '41 To 45 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '46 To 60 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '61 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'CPS')
      {
        $('#title').html("Ageing Based on Invoice to CPS Order");
        $("#example1").DataTable(
          {
            destroy: true,
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': 'Less than 7 days', className: 'text-right' },
              { 'data': 'b2', 'title': '7 To 21 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '22 To 30 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '31 To 35 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '36 To 45 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '46 To 60 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '61 To 90 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '91 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'FGMT') {
        $('#title').html("Ageing Based on Sales Order to FGMT");
        $("#example1").DataTable(
          {
            destroy: true,
            "processing": 'Loading...',
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': '0 To 15 Days', className: 'text-right' },
              { 'data': 'b2', 'title': '16 To 20 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '21 To 25 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '26 To 30 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '31 To 35 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '36 To 40 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '41 To 45 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '46 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'PLRS') {
        $('#title').html("Ageing Based on FGMT to Planning Release");
        $("#example1").DataTable(
          {
            destroy: true,
            "processing": 'Loading...',
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': 'Less than 3 Days', className: 'text-right' },
              { 'data': 'b2', 'title': '4 To 7 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '8 To 10 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '11 To 15 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '16 To 21 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '22 To 30 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '31 To 40 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '41 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'PLPO') {
        $('#title').html("Ageing Based on Planning Release to PO");
        $("#example1").DataTable(
          {
            destroy: true,
            "processing": 'Loading...',
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': 'Less than 3 Days', className: 'text-right' },
              { 'data': 'b2', 'title': '4 To 5 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '6 To 7 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '8 To 10 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '11 To 15 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '16 To 21 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '22 To 30 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '31 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'PLCP') {
        $('#title').html("Ageing Based on PO to CPS");
        $("#example1").DataTable(
          {
            destroy: true,
            "processing": 'Loading...',
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': 'Less than 3 Days', className: 'text-right' },
              { 'data': 'b2', 'title': '4 To 5 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '6 To 7 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '8 To 10 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '11 To 15 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '16 To 21 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '22 To 30 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '31 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }

      if (document.getElementById('basis').value == 'SOCP') {
        $('#title').html("Ageing Based on SO to CPS");
        $("#example1").DataTable(
          {
            destroy: true,
            "processing": 'Loading...',
            "responsive": false, "lengthChange": true, "autoWidth": true,
            "deferRender": true, "paging": true,
            "pageLength": 50,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,

            columns: [

              { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
              { 'data': 'b1', 'title': '1 Day', className: 'text-right' },
              { 'data': 'b2', 'title': '2 Days', className: 'text-right' },
              { 'data': 'b3', 'title': '3 Days', className: 'text-right' },
              { 'data': 'b4', 'title': '4 To 7 Days', className: 'text-right' },
              { 'data': 'b5', 'title': '8 To 10 Days', className: 'text-right' },
              { 'data': 'b6', 'title': '11 To 15 Days', className: 'text-right' },
              { 'data': 'b7', 'title': '16 To 21 Days', className: 'text-right' },
              { 'data': 'b8', 'title': '21 Days & Above', className: 'text-right' }
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
      }
      //else
     
    };
    
  </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Order Ageing Report</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
              <li class="breadcrumb-item active">Order Ageing</li>
            </ol>
          </div>
        </div>
    </div><!-- /.container-fluid -->
  </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="card">
          <div class="card-body">
            <div class="row"> 
              <div class="col-sm-3">
                <div class="form-group">
                  <label>From Date</label>
                  <input type="date" class="form-control" id="t_frdt"/>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <label>To Date</label>
                  <input type="date" class="form-control" id="t_todt"/>
                </div>
              </div>
              <div class="col-sm-3">
                  <div class="form-group">
                    <label>Ageing Base</label>
                    <select class="form-control select2" style="width: 100%;" id="basis">
                      <option selected="selected" value="CPS">Invoice to CPS Ageing</option>
                      <option value="ORD">Invoice to Sales Order Ageing</option>
                      <option value="FGMT">FGMT to Sales Order</option>
                      <option value="PLRS">FGMT to Planning release</option>
                      <option value="PLPO">Planning Release to PO</option>
                      <option value="PLCP">PO to CPS</option>
                      <option value="SOCP">SO to CPS</option>
                    </select>
                  </div>
              </div>
            </div>
          </div>
          <div class="card-footer">
            <div class="form-group">
              <button  id="btnReport" type="button" class="btn btn-warning float-left toastrDefaultSuccess" onclick = "get_ageing();">Get Report</button>
            </div>
          </div>
        </div>
        </div>
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title" id="title"> <i class="fas fa-edit"></i>List of Sales Orders ageing </h3>
              <div class="card-tools"></div>
            </div>  
            <div class="card-body">
              <table id="example1" class="table table-bordered table-striped ">
              </table>
            </div>
          </div>
        </div>
      </div>
    </section>


<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->

<!-- Page specific script -->
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
    
    
</asp:Content>
