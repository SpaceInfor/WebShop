<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="OrderDashboard.aspx.cs" Inherits="WebShop.OrderDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
  <script type="text/javascript">
    function redirect()
    {
          var url = "https://localhost:44367/WebOrderBooking.aspx";
          window.location(url);
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Sales Quotation</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
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
            
            <div class="card-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                  <tr>
                  <th>#</th>
                  <th>Quot. No</th>
                  <th>Quot. Ref</th>
                  <th>BP</th>
                  <th>Cust Ord No.</th>              
                  <th>Reference</th>
                  <th>Date</th>
                  <th>Amount</th>
                  <th>Status</th>
                  </tr>
                </thead>
                <tbody id="tb1">
                <div id="order" runat="server">
              </tbody>
              <tfoot>
              </tfoot>
            </table>
            </div>
          </div>
        </div>
      </div>
  </section>
</asp:Content>
