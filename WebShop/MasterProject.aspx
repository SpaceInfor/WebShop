<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="MasterProject.aspx.cs" Inherits="WebShop.MasterProject" %>
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
  <script type = "text/javascript">
      function BindProject(prbp)
      {
          
          $.ajax({
            type: "POST",
            url: "MasterProject.aspx/bind_MasterProject",
            data: '{t_prbp: "' + prbp + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: BindTable,
            failure: function (response)
            {
                document.getElementById('tb1').innerHTML = response.d;
            }
        });
      }
      function BindTable(response)
      {
          document.getElementById('tb1').innerHTML = response.d;
      }
  </script> 
  <script type = "text/javascript">
      function AddProject()
      {
        $.ajax(
            {
              type: "POST",
              url: "MasterProject.aspx/ProcessIT",
              data: '{t_pnam: "' + $("#<%=t_pnam.ClientID%>")[0].value + '",t_pinf: "' + $("#<%=t_pinf.ClientID%>")[0].value + '" }',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: OnSuccess,
              failure: function (response)
              {
                alert(response.d);
              }
          });
      }
      function OnSuccess(response)
      {
          //document.getElementById('tb1').innerHTML  =   response.d;
          alert('Master Project added successfully!');
          $("#<%=t_pnam.ClientID%>")[0].value = "";
          $("#<%=t_pinf.ClientID%>")[0].value = "";
         
          var username = '<%= Session["t_usid"] %>';
          
          BindProject(username);
      }
</script> 
  <script type="text/javascript">

      $(document).ready(function () {
          var username = '<%= Session["t_usid"] %>';
          BindProject(username);
      });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <asp:ScriptManager ID="scriptmanager1" runat="server" EnablePageMethods="true" AjaxFrameworkMode="Enabled">  
</asp:ScriptManager>
  <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Master Project Information Form</h1>
          </div>          
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="BuyerDashboard.aspx">Home</a></li>
              <li class="breadcrumb-item"><a href="OrderDashboard.aspx">Order Booking List</a></li>
              <li class="breadcrumb-item active">Master Project Information Form</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
      <div class="container-fluid">
          <div class="row">
            <div class="col-md-12">
              <div class="card card-warning card-outline">
                <div class="card-header">
                  <h3 class="card-title"><i class="fa fa-fw fa-cart-plus"></i>Master Project Details</h3>
                  <div class="card-tools">
                    <span class="float-right username"><a href="#" id="orderid"></a></span>
                  </div>
                </div>
                <div class="card-body">
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
                    <ContentTemplate>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                        <label>Project Name</label>  
                        <asp:TextBox ID="t_pnam" runat="server" class="form-control" placeholder="Add Project Name here.."></asp:TextBox>
                      </div>                      
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Project Information</label>  
                          <asp:TextBox ID="t_pinf" runat="server" cssClass="form-control" placeholder="Add Master Project Info here.."></asp:TextBox>      
                        </div>
                      </div>
                    </div>
                </ContentTemplate>
                </asp:UpdatePanel>  
                </div>
                <div class="card-footer">
                  <button  id="btnGetTime" type="button" class="btn btn-warning" onclick = "AddProject();"><i class="fas fa-plus"></i> &nbsp; Add</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-body" id="tbl1">
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                      <th>Project ID</th>
                      <th>Project Name</th>
                      <th>Project Info</th>
                      <th></th>
                      </tr>
                    </thead>
                    <tbody id="tb1"> 
                    </tbody>
                    <tfoot>
                    </tfoot>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      <script src="../../plugins/jquery/jquery.min.js"></script>
      <!-- Bootstrap 4 -->
      <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
      <!-- DataTables -->
      <script src="../../plugins/datatables/jquery.dataTables.js"></script>
      <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
      <!-- AdminLTE App -->
      <script src="../../dist/js/adminlte.min.js"></script>
      <!-- AdminLTE for demo purposes -->
      <script src="../../dist/js/demo.js"></script>
      <!-- page script -->
      <script>
        $(function () {
          $("#example1").DataTable();
          $('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false,
          });
        });
      </script>
</section>


</asp:Content>
