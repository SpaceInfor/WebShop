<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="CustOrderList.aspx.cs" Inherits="WebShop.CustOrderList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

  <script type = "text/javascript">
    function BindCustOrders() {
      $.ajax({
        type: "POST",
        url: "CustOrderList.aspx/GetOrderList_WM",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: BindTable,
        failure: function (response)
        {
          document.getElementById('ct1_order').innerHTML = response.d;
        }
      });
    }
    function BindTable(response)
    {
      document.getElementById('ct1_order').innerHTML = response.d;
    }
  </script> 
  <script type = "text/javascript">
    function ApproveDeviation(orno) {
      $.ajax(
        {
          type: "POST",
          url: "CustOrderList.aspx/ApproveDeviation",
          data: '{t_orno: "' + orno + '" }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: OnSuccess,
          failure: function (response) {
            alert(response.d);
          }
        });
    }
    function OnSuccess(response) {
      if (response.d.trim() == 'EXIST') {
        alert('Record already added for the sales order');
      }
      else {
        alert('Deviation Approved successfully!');
      //  BindCustOrders();
        __doPostBack('not sure what goes here', 'or here');
        } 
      
      }
  </script> 
  <script type="text/javascript">
      $(document).ready(function () {
       //BindCustOrders();
      });
  </script>

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script type="text/javascript">
    function redirect() {
      
      var url = "https://localhost:44367/WebOrderBooking.aspx";
      window.location(url);
    }
  </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Sales Quotation</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="BuyerDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Sales Quotations</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Sales Quotations</h3>
              <div class="card-tools">
                <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-block btn-warning btn-sm" OnClick="btnAddNew_Click"><i class="fa fa-fw fa-plus-circle"></i>Add New</asp:LinkButton>
              </div>
            </div>  
            <div class="card-body table-responsive p-0">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Quot. No</th>
                    <th>Approve Deviation</th>
                    <th>Deviation</th>
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Master Project</th>
                    <th>Secondary Customer</th>
                    <th>Innocal Ref</th>
                    <th>DeltaCadd Ref</th>
                    <th>Order Ref</th>
                    <th>Remarks</th>
                    <th>Date</th>              
                    <th>Type</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Login Team Status</th>
                    <th>Sales Order No</th>
                    <th>Sales Order Amt</th>
                    <th>Pre Planning Stat</th>
                    <th>Pre Planned Qty</th>
                    <th>Planning Stat</th>
                    <th>Planned Qty</th>
                    <th>Production Stat</th>
                    <th>Produced Qty</th>
                    <th>Despatch Stat</th>
                    <th>Despatch Qty</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Get Packing List</th>
                    <th>Raise Grivances</th>
                  </tr>
                  </thead>
                  <tbody id="order" runat="server">
                  <tr>
                    <td>Trident</td>
                    <td>Internet Explorer 4.0</td>
                    <td>Win 95+</td>
                    <td>4</td>
                    <td>X</td>
                    <td>Trident</td>
                    <td>Internet Explorer 4.0</td>
                    <td>Win 95+</td>
                    <td>4</td>
                    <td>X</td>
                    <td>Win 95+</td>
                    <td>4</td>
                    <td>X</td>
                  </tr>
                  </tbody>
                  <tfoot>
                  <tr>
                    <th>#</th>
                    <th>Quot. No</th>
                    <th>Approve Deviation</th>
                    <th>Deviation</th>
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Master Project</th>
                    <th>Secondary Customer</th>
                    <th>Innocal Ref</th>
                    <th>DeltaCadd Ref</th>
                    <th>Order Ref</th>
                    <th>Remarks</th>
                    <th>Date</th>              
                    <th>Type</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Login Team Status</th>
                    <th>Sales Order No</th>
                    <th>Sales Order Amt</th>
                    <th>Pre Planning Stat</th>
                    <th>Pre Planned Qty</th>
                    <th>Planning Stat</th>
                    <th>Planned Qty</th>
                    <th>Production Stat</th>
                    <th>Produced Qty</th>
                    <th>Despatch Stat</th>
                    <th>Despatch Qty</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Get Packing List</th>
                    <th>Raise Grivances</th>
                  </tr>
                  </tfoot>
                </table>
              </div>
          </div>
        </div>
      </div>
  </section>

  <script src="../../plugins/jquery/jquery.min.js"></script>
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
<!-- Page specific script -->
<script>
  $(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": true, "autoWidth": false,
      "buttons": ["csv", "excel", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
    });
  });
</script>

</asp:Content>

