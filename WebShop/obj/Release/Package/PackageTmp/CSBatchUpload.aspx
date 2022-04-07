<%@ Page Title="Sales Quotation List" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CSBatchUpload.aspx.cs" Inherits="WebShop.CSBatchUpload" %>
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
      get_ageing();
    });
  </script>
  <script type="text/javascript">
    

    function get_ageing() {
      $.ajax({
          type: "POST",
          url: "CSBatchUpload.aspx/GetBatchNo",
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
         "responsive": false, "lengthChange": true, "autoWidth": true,
          "deferRender": true, "paging": true,
          "pageLength": 50,
          "buttons": ["csv", "excel", "print", "colvis"],
          destroy: true,
          data: response.d,
          columns: [
           
            { 'data': 't_orno', 'title': 'Sales Order No' },
            { 'data': 't_btno', 'title': 'Batch No'},
            { 'data': 't_date', 'title': 'Batch Creation Date'}
            
           ]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');;
        };
    
  </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Sales Order Batches</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a  href="CSDashboard.aspx">Home</a></li>
            <li class="breadcrumb-item active">Sales Order Batches</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
       <div class="col-md-6">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title"> <i class="fas fa-edit"></i>Upload Batch</h3>
              <div class="card-tools"></div>
            </div>  
            <div class="card-body">
              <div class="form-group">
                <label>File Upload</label>  
                  <div class="input-group">
              <div class="custom-file">
                <asp:FileUpload runat="server" ID="UploadBatch" AllowMultiple="false" cssclass="form-control"/>
              </div>
              <div class="input-group-append">
                <asp:Button runat="server" ID="uploadedFile" Text="Upload" OnClick="uploadFile_Click" class="btn btn-block btn-warning" />
              </div>
            </div>                      
                  <asp:Label ID="listofuploadedfiles" runat="server" />
                </div>
            </div>
            <div class="card-footer">
              <a href="FileUpload/SalesOrderBatch.xlsx">Click Here</a> to download excel template 
            </div>
          </div>
        </div>
       <div class="col-6">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title"> <i class="fas fa-edit"></i>List of Errors </h3>
              <div class="card-tools"></div>
            </div>  
            <div class="card-body">
              <table id="example2" class="table table-bordered table-striped ">
                <tr>
                  
                    <th>Sales Order</th>
                    <th>Batch</th>
                    <th>Error Msg</th>
                  
                </tr>
                <tbody id="tbl1" runat="server"></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
          <div class="col-md-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title"> <i class="fas fa-edit"></i>List of Sales Orders Batches </h3>
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
