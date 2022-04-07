  <%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="INNDashboard.aspx.cs" Inherits="WebShop.INNDashboard"  EnableEventValidation="false"  %>
<%@ MasterType VirtualPath="~/AdminMaster.Master" %>
<asp:content ID="hdcontent" ContentPlaceHolderID="head" runat="server"> 
  <script>        
        window.onload = function () {
          getLocation();
          //GetUserImage();
          BindStatusData();
          BindOrderStatData();
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
    <script type = "text/javascript">

      function BindOrderStatData() {
        debugger
        $.ajax({
          type: "POST",
          url: "INNDashboard.aspx/GetOrderStatDetails",
          data: '{ }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {
            if (response.d != '') {
              var orno = JSON.parse(response.d);
              $('#r_c_redy').html(orno.r_c_redy);
              $('#r_c_part').html(orno.r_c_part);
              $('#f_c_redy').html(orno.f_c_redy);
              $('#f_c_part').html(orno.f_c_part);
              $('#r_v_redy').append(orno.r_v_redy);
              $('#r_v_part').append(orno.r_v_part);
              $('#f_v_redy').append(orno.f_v_redy);
              $('#f_v_part').append(orno.f_v_part);

            }
            else {
              $('#r_c_redy').html('0');
              $('#r_c_part').html('0');
              $('#f_c_redy').html('0');
              $('#f_c_part').html('0');
              $('#r_v_redy').html('0');
              $('#r_v_part').html('0');
              $('#f_v_redy').html('0');
              $('#f_v_part').html('0');
            }
          },
          error: function (response) {
            alert(response.responseText);
          }
        });
      }
    </script>
  <script type = "text/javascript">

    function BindStatusData() {
      debugger
        $.ajax({
        type: "POST",
        url: "INNDashboard.aspx/GetStatusDetails",
        data: '{ }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
          if (response.d != '') {
            var orno = JSON.parse(response.d);
            $('#lblSales_Pending').html(orno.Sales_Pending);
            $('#lblPre_Plan_Pending').html(orno.Pre_Plan_Pending);
            $('#lblPlan_Pending').html(orno.Plan_Pending);
            $('#lblProd_Pending').html(orno.Prod_Pending);
            $('#lblDesp_Pending').html(orno.Desp_Pending);

          }
          else {
            $('#lblSales_Pending').html('0');
            $('#lblPre_Plan_Pending').html('0');
            $('#lblPlan_Pending').html('0');
            $('#lblProd_Pending').html('0');
            $('#lblDesp_Pending').html('0');
          }
        },
        error: function (response) {
          alert(response.responseText);
        }
      });
    }
    </script>
    <script type="text/javascript">
      $(document).ready(function () {
        debugger
        BindStatusData();
      });
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
            <h1 class="m-0 text-dark">Dashboard For Innopan</h1>
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
          <div class="col-md-8">
            <div class="row">
              <div class="col-12 col-sm-6 col-md-4">
                <div class="info-box">
                  <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-shopping-cart"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">INN Orders</span>
                    <a href="InnOrderList.aspx"><span class="info-box-number" id="yourorder" runat="server">
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
                    <a href="INNInvList.aspx"><span class="info-box-number" id="yourinvoice" runat="server">
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
                <h3 class="card-title">Sales Orders</h3>
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
                      <th>Channel</th>
                      <th>Draft</th>
                      <th>Approved</th>
                      <th>Planned</th>
                      <th>Packed</th>
                      <th>Despatched</th>
                  
                    </tr>
                    </thead>
                    <tbody id="latestordlist" runat="server">                   
                    </tbody>
                  </table>
                </div>
                <!-- /.table-responsive -->
              </div>
              <div class="card-footer">
                <div class="row">
                  <div class="col-sm-3 col-6">
                    <div class="description-block border-right">
                      <span class="description-percentage text-success"><i class="fas fa-caret-up"></i>100% Ready</span>
                      <h5 class="description-header" id="r_v_redy"><i class="fas fa-rupee-sign fa-1x"></i>&nbsp;</h5>
                      <span class="description-text" id="r_c_redy"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-3 col-6">
                    <div class="description-block border-right">
                      <span class="description-percentage text-warning"><i class="fas fa-caret-left"></i>Partially Ready</span>
                      <h5 class="description-header" id="r_v_part"><i class="fas fa-rupee-sign fa-1x"></i>&nbsp;</h5>
                      <span class="description-text" id="r_c_part"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-3 col-6">
                    <div class="description-block border-right">
                      <span class="description-percentage text-success"><i class="fas fa-caret-up"></i>100% Ready(FOC)</span>
                      <h5 class="description-header" id="f_v_redy"><i class="fas fa-rupee-sign fa-1x"></i>&nbsp;</h5>
                      <span class="description-text" id="f_c_redy"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-3 col-6">
                    <div class="description-block">
                      <span class="description-percentage text-danger"><i class="fas fa-caret-down"></i>Partially Ready(FOC)</span>
                      <h5 class="description-header" id="f_v_part"><i class="fas fa-rupee-sign fa-1x"></i>&nbsp;</h5>
                      <span class="description-text" id="f_c_part"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                </div>
                <!-- /.row -->
              </div>
              <!-- /.card-body -->
             
              <!-- /.card-footer -->
            </div>  
          </div>
          <div class="col-md-4">
            <!-- Info Boxes Style 2 -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-list"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Order Login</span>
                <a href="INNOrderLoginDrill1.aspx"><h3 class="headline text-warning" id="lblSales_Pending">0</h3></a> 
              </div>
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="fa fa-fw fa-outdent"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Pre-Planning</span>
                <a href="INNPrePlanDrill1.aspx"><h3 class="headline text-info" id="lblPre_Plan_Pending">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <div class="info-box mb-3 bg-light color-palette">
              
              <span class="info-box-icon"><i class="fa fa-fw fa-list-alt"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Planning</span>
                <a href="INNPlanDrill1.aspx"><h3 class="headline text-success" id="lblPlan_Pending">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon"><i class="fa fa-fw fa-industry"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Awaiting Production</span>
                <a href="INNProdDrill1.aspx"><h3 class="headline text-danger" id="lblProd_Pending">0</h3></a>
              </div>
              <!-- /.info-box-content -->
            </div>

            <!-- /.info-box -->
            <div class="info-box mb-3 bg-light color-palette">
              <span class="info-box-icon" ><i class="fa fa-fw fa-truck"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Awaiting Despatch</span>
                <a href="INNDespDrill1.aspx"><h3 class="headline text-muted" id ="lblDesp_Pending" >0</h3></a>
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
