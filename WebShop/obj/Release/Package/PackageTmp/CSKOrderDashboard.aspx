<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSKOrderDashboard.aspx.cs" Inherits="WebShop.CSKOrderDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  <script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function () {
      debugger
      get_all_orders();

    });

</script>
      
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>ChartJS</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">ChartJS</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <!-- AREA CHART -->
            
            <!-- /.card -->

            <!-- DONUT CHART -->
            <div class="card card-danger">
              <div class="card-header">
                <h3 class="card-title">Donut Chart</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <canvas id="donutChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          <!-- /.col (RIGHT) -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
  <script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="../../plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->
  
      <script type="text/javascript">
        function get_all_orders() {
          $.ajax({
            type: "POST",
            url: "CSKOrderDashboard.aspx/GetOrders",
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

          debugger

          var data = response.d;
          var result = data.map(function (val) {
            return val.location_id;
          }).join(',');

          var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
          var donutData = {
            labels: [
              'FullReady_Qty',
              'FullReady_Val',
              'BalPartReady_Qty',
              'BalPartReady_Val',
              'PartReady_Qty',
              'PartReady_Val',
              'WIP_Qty',
              'WIP_Val',
              'Planning_Qty',
              'Planning_Val',
              'FOC_FullReady_Qty',
              'FOC_PartReady_Qty',
              'FOC_WIP_Qty',
              'FOC_Login_Nos',
            ],
            //labels: [
            //  'Chrome',
            //  'IE',
            //  'FireFox',
            //  'Safari',
            //  'Opera',
            //  'Navigator',
            //],
            datasets: [
              {

                data: google.visualization.arrayToDataTable(response.d),
               // data: [700, 500, 400, 600, 300, 100],
                backgroundColor: ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de', '#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de', '#3c8dbc', '#d2d6de'],
              }
            ]
          }
          var donutOptions = {
            maintainAspectRatio: false,
            responsive: true,
          }
          //Create pie or douhnut chart
          // You can switch between pie and douhnut using the method below.
          new Chart(donutChartCanvas, {
            type: 'doughnut',
            data: donutData,
            options: donutOptions
          })

        }
      </script>
</asp:Content>
