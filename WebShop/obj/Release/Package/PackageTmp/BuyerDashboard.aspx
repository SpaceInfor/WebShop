<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="BuyerDashboard.aspx.cs" Inherits="WebShop._BuyerDashboard" %>
<asp:content ID="hdcontent" ContentPlaceHolderID="head" runat="server">
    <script>        

        window.onload = function () {
            getLocation();
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
    <asp:HiddenField ID="lattitude" runat="server" Value="0"  ClientIDMode="Static"  />
        <asp:HiddenField ID="longetude" runat="server" Value="0"  ClientIDMode="Static" />
     <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Customer Dashboard</h1>
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
          <div class="col-lg-3 col-6">
            <div class="card card-widget widget-user-2">
              <div class="widget-user-header bg-warning">
                <div class="widget-user-image">
                  <img class="img-circle elevation-2" src="../images/kitchen.png" alt="User Avatar">
                </div>
                <h3 class="widget-user-username">Kitchen</h3>
                <a href="CustOrderList.aspx"><h6 class="widget-user-desc">Click For Booking</h6></a>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-6">
            <div class="card card-widget widget-user-2">
              <div class="widget-user-header bg-success">
                <div class="widget-user-image">
                  <img class="img-circle elevation-2" src="../images/home2.png" alt="User Avatar">
                </div>
                <!-- /.widget-user-image -->
                <h3 class="widget-user-username">Home</h3>
                <a href="NonAccessPage.aspx"><h6 class="widget-user-desc">Click For Booking</h6></a>
              </div>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <div class="card card-widget widget-user-2">
              <!-- Add the bg color to the header using any of the bg-* classes -->
              <div class="widget-user-header bg-info">
                <div class="widget-user-image">
                  <img class="img-circle elevation-2" src="../images/buro.jpg" alt="User Avatar">
                </div>
                <h3 class="widget-user-username">BURO</h3>
                <a href="NonAccessPage.aspx"><h6 class="widget-user-desc">Click For Booking</h6></a>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-6">
            <div class="card card-widget widget-user-2">
              <div class="widget-user-header bg-danger disabled">
                <div class="widget-user-image">
                  <img class="img-circle elevation-2" src="../images/door.png" alt="User Avatar">
                </div>
                <h3 class="widget-user-username">DOOR</h3>
                <a href="NonAccessPage.aspx"><h6 class="widget-user-desc">Click For Booking</h6></a>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-8">
            <div class="row">
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-light elevation-1"><i class="fas fa-shopping-cart"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Your Orders</span>
                    <a href="CustOrderList.aspx"><span class="info-box-number" id="yourorder" runat="server">
                        0
                      <small></small>
                    </span></a>
                  </div>  
                </div>
              </div>
              <!-- /.col -->
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-light elevation-1"><i class="fa fa-credit-card"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Your Invoices</span>
                    <a href="CustInvList.aspx"><span class="info-box-number" id="yourinvoice" runat="server">
                      0
                      <small></small>
                    </span></a>
                  </div>  
                </div>
              </div>
              <!-- /.col -->
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-light elevation-1"><i class="fa fa-fw fa-newspaper"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Packing Lists</span>
                    <a href="CustPayables.aspx"><span class="info-box-number" id="yourpayables" runat="server">
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
                      <th>Order</th>
                      <th>Mast.Proj ID</th>
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
                <span class="info-box-text">Total Un-Approved Orders</span>
                <a href="UnAppOrdersDrill1.aspx"><span class="info-box-number" id="lblUnApproved" runat="server">0</span></a>
              </div>
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="fa fa-fw fa-cubes"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Total In Process/To Close Orders</span>
                <a href="InprocDrill1.aspx"><span class="info-box-number" id="lblInProcess" runat="server">0</span></a>
                
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-truck"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Total Shipped Orders</span>
                <a href="ShippedDrill1.aspx"><span class="info-box-number" id="lblShipped" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon" ><i class="fa fa-fw fa-calculator"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Awaiting Shipment</span>
                <a href="NonAccessPage.aspx"><span class="info-box-number" id ="lblAwaitingShip" runat="server">0</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            
            
            <!-- /.card -->

            <!-- PRODUCT LIST -->
            
            <!-- /.card -->
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
  
 <div id="srcpt" runat="server"></div>


</asp:Content>
