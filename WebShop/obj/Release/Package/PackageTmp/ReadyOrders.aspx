<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ReadyOrders.aspx.cs" Inherits="WebShop.ReadyOrders" %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
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

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <script type="text/javascript">
      function redirect() {
          debugger
          var url = "https://localhost:44367/WebOrderBooking.aspx";
          window.location(url);
      }
</script>
  <script type="text/javascript">
    $(document).ready(function () {
      
      const urlParams = new URLSearchParams(window.location.search);
      const myParam = urlParams.get('type');
      if (myParam == 'REG') {
        get_all_orders();
      }
      else
      {
        get_foc_orders();
      }
      
    });
</script>
    <script type="text/javascript">
      function get_all_orders()
      {
       $.ajax({
         type: "POST",
         url: "ReadyOrders.aspx/GetCustomers",
         data: '{}',
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
     function OnSuccess(response) {
       $("#example1").DataTable(
         {
           "responsive": true, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": true,
           "buttons": ["csv", "excel", "print", "colvis"],
           data: response.d,
           columns: [
             { 'data': 'ord_link', 'title': '#' },
             { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
             { 'data': 't_scbp', 'title': 'Secondary Customer' },
             { 'data': 't_date', 'title': 'Quotation Date' },
             { 'data': 'Sales_Order', 'title': 'Sales Order No' },
             { 'data': 'Sales_Qty', 'title': 'Sales Order Qty' },
             { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
             { 'data': 'Sales_Order_Date', 'title': 'Sales Order Date' },
             { 'data': 'Pl_Release_Date', 'title': 'Planning Release Date' }]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };

</script>
    <script type="text/javascript">
   function get_foc_orders()
   {
       $.ajax({
         type: "POST",
         url: "ReadyOrders.aspx/GetFOCOrders",
         data: '{}',
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
      function OnSuccess(response) {
       $("#example1").DataTable(
         {
           "responsive": true, "lengthChange": true, "autoWidth": false,
           "deferRender": true, "paging": true,
           "buttons": ["csv", "excel", "print", "colvis"],
           data: response.d,
           columns: [
             { 'data': 'ord_link', 'title': '#' },
             { 'data': 'bp_code_name', 'title': 'BP Code & Name' },
             { 'data': 't_scbp', 'title': 'Secondary Customer' },
             { 'data': 't_date', 'title': 'Quotation Date' },
             { 'data': 'Sales_Order', 'title': 'Sales Order No' },
             { 'data': 'Sales_Qty', 'title': 'Sales Order Qty' },
             { 'data': 'Sales_Amount', 'title': 'Sales Order Amt' },
             { 'data': 'Sales_Order_Date', 'title': 'Sales Order Date' },
             { 'data': 'Pl_Release_Date', 'title': 'Planning Release Date' }]
         }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
     };

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Ready Orders List</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
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
              <h3 class="card-title">100% Ready Orders List</h3>
              <div class="card-tools">
               
              </div>
            </div>  
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped ">
                  <%--<thead>
                  <tr>
                    <th>#</th>
                    <th>BP Code & Name</th>
                    <th>Quot. No</th>
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
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Deviation</th>
                    <th>Deviation Staus</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Add Shortages</th>
                    <th>Get Packing List</th>
                  </tr>
                  </thead>
                  <tbody>
                  <asp:Literal ID="order" runat="server"></asp:Literal>
                  </tbody>
                  <tfoot>
                  <tr>
                    <th>#</th>
                    <th>BP Code & Name</th>
                    <th>Quot. No</th>
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
                    <th>Shortages</th>
                    <th>Tentative Desp Date</th>
                    <th>Deviation</th>
                    <th>Deviation Staus</th>
                    <th>Files</th>
                    <th>Chat</th>
                    <th>Add Shortages</th>
                    <th>Get Packing List</th>
                  </tr>
                  </tfoot>--%>
                </table>
            </div>
          </div>
        </div>
      </div>
  </section>
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">



</asp:Content>
