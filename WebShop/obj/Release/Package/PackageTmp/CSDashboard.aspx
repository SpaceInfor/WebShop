  <%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSDashboard.aspx.cs" Inherits="WebShop.CSDashboard"  EnableEventValidation="false"  %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:content ID="hdcontent" ContentPlaceHolderID="head" runat="server"> 
  <script>        
        window.onload = function () {
          getLocation();
          //GetUserImage();
        };
        function getLocation()
        {
            if (navigator.geolocation)
            {
                navigator.geolocation.watchPosition(showPosition);
            }
            else
            {
                x.innerHTML = "Geolocation is not supported by this browser.";
            }
        }
        function showPosition(position)
        {
            document.getElementById("lattitude").value = position.coords.latitude;
            document.getElementById("longetude").value = position.coords.longitude;
        }
  </script>
  
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="../plugins/fullcalendar/main.min.css">
  <link rel="stylesheet" href="../plugins/fullcalendar-daygrid/main.min.css">
  <link rel="stylesheet" href="../plugins/fullcalendar-timegrid/main.min.css">
  <link rel="stylesheet" href="../plugins/fullcalendar-bootstrap/main.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
 </asp:content>
  <asp:Content ID="BodyContent" ContentPlaceHolderID="ct1" runat="server">
     <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Dashboard For Kitchen</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">
            <div class="card card-outline card-success">
              <div class="card-header">
                <h3 class="card-title">Approved Order MTD</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="display: block;">
                <center>Total Numbers</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalapnos" runat="server" Text="0.00"/> </a></h4></center>
              </div>
              <div class="card-footer" style="display: block;">
                <center>Total Value.</center>
                <center><h4 class="attachment-heading"><a href="#"><i class="fa fa-fw fa-rupee"></i><asp:label ID="lbl_totalapval" runat="server" Text="0.00"/> </a></h4></center>

              </div>
              <!-- /.card-body -->
            <!-- /.card -->
            </div>
          </div>
          <!-- /.col -->
          <div class="col-md-3">
            <div class="card card-outline card-danger">
              <div class="card-header">
                <h3 class="card-title">Unapproved Orders MTD</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="display: block;">
                <center>Total Numbers</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalunapnos" runat="server" Text="0.00"/> </a></h4></center>
              </div>
              <div class="card-footer" style="display: block;">
                <center>Total Value.</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_totalunapval" runat="server" Text="0.00"/> </a></h4></center>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
          <div class="col-md-3">
            <div class="card card-outline card-success">
              <div class="card-header">
                <h3 class="card-title">Approved Order YTD</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="display: block;">
                <center>Total Numbers</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalapnos_ytd" runat="server" Text="0.00"/> </a></h4></center>
              </div>
              <div class="card-footer" style="display: block;">
                <center>Total Value.</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalunapval_ytd" runat="server" Text="0.00"/> </a></h4></center>
              </div>
              <!-- /.card-body -->
            <!-- /.card -->
            </div>
          </div>
          <!-- /.col -->
          <div class="col-md-3">
            <div class="card card-outline card-danger">
              <div class="card-header">
                <h3 class="card-title">Unapproved Orders YTD</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="display: block;">
                <center>Total Numbers</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalunapnos_ytd" runat="server" Text="0"/> </a></h4></center>
              </div>
              <div class="card-footer" style="display: block;">
                <center>Total Value.</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_totalunapval_ytd" runat="server" Text="0"/> </a></h4></center>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <div class="row">
          <div class="col-md-8">
            <div class="row">
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-shopping-cart"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">CP Orders</span>
                    <a href="CSOrderList.aspx"><span class="info-box-number" id="yourorder" runat="server">
                        0
                      <small></small>
                    </span></a>
                  </div>  
                </div>
              </div>
              <!-- /.col -->
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-success elevation-1"><i class="fa fa-credit-card"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Invoices</span>
                    <a href="CSInvList.aspx"><span class="info-box-number" id="yourinvoice" runat="server">
                      0
                      <small></small>
                    </span></a>
                  </div>  
                </div>
              </div>
              <!-- /.col -->
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-info elevation-1"><i class="fa fa-fw fa-newspaper"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Upcoming Deliveries</span>
                    <a href="SoDelDate.aspx"><span class="info-box-number" id="yourpayables" runat="server">
                      0
                      <small></small>
                    </span></a>
                  </div>  
                </div>
              </div>
              <!-- /.col -->
                
              <!-- /.col -->
            </div>
            <div class="card">
              <div class="card-header border-transparent">
                <h3 class="card-title">Latest Orders</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table m-0">
                    <thead>
                    <tr>
                      <th>Customer Code & Name</th>
                      <th>Order</th>
                      <th>LOB</th>
                      <th>Item</th>
                      <th>Qty</th>
                      <th>Status</th>
                    </tr>
                    </thead>
                    <tbody id="latestordlist" runat="server">                   
                    </tbody>
                  </table>
                </div>
                <!-- /.table-responsive -->
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <a href="CustOrderBooking.aspx?SCP=1" class="btn btn-sm btn-info float-left">Place New Order</a>
                <a href="CustOrderList.aspx" class="btn btn-sm btn-secondary float-right">View All Orders</a>
              </div>
              <!-- /.card-footer -->
            </div>  
          </div>
          <div class="col-md-4">
            <!-- Info Boxes Style 2 -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Order Login</span>
                <a href="CSOrderLoginDrill1.aspx"><span class="info-box-number" id="lblSales_Pending" runat="server">0</span></a> 
              </div>
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="fa fa-fw fa-outdent"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Pre-Planning</span>
                <a href="CSPrePlanDrill1.aspx"><span class="info-box-number" id="lblPre_Plan_Pending" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="fa fa-fw fa-list-alt"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Planning</span>
                <a href="CSPlanDrill1.aspx"><span class="info-box-number" id="lblPlan_Pending" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-industry"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Awaiting Production</span>
                <a href="CSProdDrill1.aspx"><span class="info-box-number" id="lblProd_Pending" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>

            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon" ><i class="fa fa-fw fa-truck"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Despatch</span>
                <a href="CSDespDrill1.aspx"><span class="info-box-number" id ="lblDesp_Pending" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
          </div>
          <div class="col-md-8">
          </div>
        </div>        
     </div>
</section>
<a id="back-to-top" href="#" class="btn btn-primary back-to-top" role="button" aria-label="Scroll to top">
      <i class="fas fa-chevron-up"></i>
    </a>
  
<script src="../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jQuery UI -->
<script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
  
  <script src="dist/js/pages/dashboard2.js"></script>      
  <script src="plugins/chart.js/Chart.min.js"></script>
<!-- fullCalendar 2.2.5 -->
<script src="../plugins/moment/moment.min.js"></script>
  

<!-- PAGE SCRIPTS -->
  
 <div id="sr"srcpt"nat="server"></div>


</asp:Content>  
