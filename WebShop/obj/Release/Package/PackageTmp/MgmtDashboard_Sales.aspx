<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="MgmtDashboard_Sales.aspx.cs" Inherits="WebShop.MgmtDashboard_Sales" %>
<asp:content ID="hdcontent" ContentPlaceHolderID="head" runat="server">
  
    <script type="text/javascript">
      $(document).ready(function () {
        $(document).ajaxStart(function () {
          Pace.restart()
        })
      });
</script>
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
            <h1 class="m-0 text-dark">Home</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Info boxes -->
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
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="lbl_tltalunapnos_ytd" runat="server" Text="0.00"/> </a></h4></center>
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
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="Label3" runat="server" Text="0"/> </a></h4></center>
              </div>
              <div class="card-footer" style="display: block;">
                <center>Total Value.</center>
                <center><h4 class="attachment-heading"><a href="#"><asp:label ID="Label4" runat="server" Text="0"/> </a></h4></center>
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
              <div class="col-md-3 col-sm-6 col-12">
              <div class="info-box">
                <span class="info-box-icon"><i class="fa fa-fw fa-industry"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">In Production</span>
                  <a href="Packing_Details.aspx"><span class="info-box-number" id="tobepacked" runat="server"></span></a>
                </div>
                <!-- /.info-box-content -->
              </div>
              <!-- /.info-box -->
            </div>
              <!-- /.col -->
              <div class="col-md-3 col-sm-6 col-12">
              <div class="info-box">
                <span class="info-box-icon"><i class="fa fa-fw fa-truck"></i></span>

                <div class="info-box-content">
                  <span class="info-box-text">Ready Stock</span>
                  <a href="Shipping_Details.aspx"><span class="info-box-number" id="tobeshipped" runat="server"></span></a>
                </div>
                <!-- /.info-box-content -->
              </div>
              <!-- /.info-box -->
            </div>
              <!-- /.col -->
              <div class="col-md-3 col-sm-6 col-12">
              <div class="info-box">
                <span class="info-box-icon"><i class="fa fa-fw fa-newspaper"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">Dispatched</span>
                  <a href="Invoice_Details.aspx"><span class="info-box-number" id="tobeinvoiced" runat="server"></span></a>
                </div>
                <!-- /.info-box-content -->
              </div>
              <!-- /.info-box -->
            </div>
              <!-- /.col -->
              <div class="col-md-3 col-sm-6 col-12">
              <div class="info-box">
                <span class="info-box-icon"><i class="fa fa-fw fa-check-circle"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">To be Received</span>
                  <a href="RecOpen_Details.aspx"><span class="info-box-number" id="tobereceived" runat="server"></span></a>
                </div>
                <!-- /.info-box-content -->
              </div>
              <!-- /.info-box -->
            </div>
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
                <a href="WebOrderBooking.aspx" class="btn btn-sm btn-info float-left">Place New Order</a>
                <a href="javascript:void(0)" class="btn btn-sm btn-secondary float-right">View All Orders</a>
              </div>
              <!-- /.card-footer -->
            </div>
            
          </div>
          <div class="col-md-4">
            <!-- Info Boxes Style 2 -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-cubes"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Inventory on hand</span>
                <a href="inventory.aspx"><span class="info-box-number" id="invonhand" runat="server">5,200</span></a>
              </div>
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-truck"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Inventory In Transit</span>
                <a href="Inventory_Intransit.aspx"><span class="info-box-number" id="invonord" runat="server">92,050</span></a>
                
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Inventory Allocated</span>
                <a href="Inventory_Alloc.aspx"><span class="info-box-number" id="invalloc" runat="server">114,381</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon" ><i class="fa fa-fw fa-calculator"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Economic Stock</span>
                <a href="Inventory_Econ"><span class="info-box-number" id ="inveco" runat="server">163,921</span></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Stock By Type</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="row">
                  <div class="col-md-8">
                    <div class="chart-responsive">
                      <canvas id="pieChart" height="150"></canvas>
                    </div>
                    <!-- ./chart-responsive -->
                  </div>
                  <!-- /.col -->
                  <div class="col-md-4" runat="server" id="pielist">
                  </div>
                  <!-- /.col -->
                </div>
                <!-- /.row -->
              </div>
              <!-- /.card-body -->
              <div class="card-footer bg-white p-0">
                <ul class="nav nav-pills flex-column" runat="server" id="whperc">
                  <li class="nav-item">
                    <a href="#" class="nav-link">
                      United States of America
                      <span class="float-right text-danger">
                        <i class="fas fa-arrow-down text-sm"></i>
                        12%</span>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="#" class="nav-link">
                      India
                      <span class="float-right text-success">
                        <i class="fas fa-arrow-up text-sm"></i> 4%
                      </span>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="#" class="nav-link">
                      China
                      <span class="float-right text-warning">
                        <i class="fas fa-arrow-left text-sm"></i> 0%
                      </span>
                    </a>
                  </li>
                </ul>
              </div>
              <!-- /.footer -->
            </div>
            
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

  <script type="text/javascript">
    // To make Pace works on Ajax calls
    $(document).ajaxStart(function () {
      Pace.restart()
    })
    $('.ajax').click(function () {
      $.ajax({
        url: '#', success: function (result) {
          $('.ajax-content').html('<hr>Ajax Request Completed !')
        }
      })
    })
 </script>
</asp:Content>
