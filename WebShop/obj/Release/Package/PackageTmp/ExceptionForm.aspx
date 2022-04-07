<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ExceptionForm.aspx.cs" Inherits="WebShop.ExceptionForm" %>
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
      function BindExceptions(orno)
      {
          $.ajax({
            type: "POST",
            url: "ExceptionForm.aspx/bind_SoExceptions",
            data: '{t_orno: "' + orno + '" }',
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

    function AddProject() {
      $.ajax(
        {
          type: "POST",
          url: "ExceptionForm.aspx/ProcessIT",
          data: '{t_orno: "' + $("#<%=orderid.ClientID%>")[0].innerText + '",t_rmsh: "' + $("#<%=t_rmsh.ClientID%>")[0].value + '",t_dldt: "' + $("#<%=t_dldt.ClientID%>")[0].value + '",t_devi: "' + $("#<%=t_devi.ClientID%>")[0].value + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,
            failure: function (response) {
              alert(response.d);
            }
          });
    }
    function OnSuccess(response)
      {
        if (response.d.trim() == 'EXIST')
        {
          alert('Record already added for the sales order');
        }
        else
        {
          alert('Record Added successfully!');
          $("#<%=t_rmsh.ClientID%>")[0].value = "";
          $("#<%=t_dldt.ClientID%>")[0].value = "";
        } 
        BindExceptions($("#<%=orderid.ClientID%>")[0].innerText);
      }
  </script> 
  <script type="text/javascript">

      $(document).ready(function () {
        BindExceptions($("#<%=orderid.ClientID%>")[0].innerText);
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
            <h1>Sales Order Shortages & Readyness Date</h1>
          </div>          
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="CSDashboard.aspx">Home</a></li>
              <li class="breadcrumb-item"><a href="CSOrderList.aspx">Order Booking List</a></li>
              <li class="breadcrumb-item active">Sales Order Shortages & Readyness Date</li>
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
                  <h3 class="card-title"><i class="fa fa-fw fa-cart-plus"></i>Add Sales Order Shortages & Readyness Date</h3>
                  <div class="card-tools">
                    <span class="float-right username"><a href="#" id="orderid" runat="server"></a></span>
                  </div>
                </div>
                <div class="card-body">
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
                    <ContentTemplate>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group">
                            <label>RM Shortage</label>  
                            <asp:TextBox ID="t_rmsh" runat="server" class="form-control" placeholder="Add RM Shortages Here.." TextMode="MultiLine"></asp:TextBox>
                          </div>                      
                        </div>
                        
                        <div class="col-md-6">
                          <div class="form-group">
                            <label>Tentative Readyness Date</label>  
                            <asp:TextBox ID="t_dldt"  cssclass="form-control" runat="server"  placeholder="Enter Tentative Readyness Date" TextMode="Date" ></asp:TextBox>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <label>Deviations</label>  
                            <asp:TextBox ID="t_devi" runat="server" class="form-control" placeholder="Add Deviation Here.." TextMode="MultiLine"></asp:TextBox>
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
                        <th>Sales Order </th>
                        <th>Shortages</th>
                        <th>Tentative Readyness Date</th>
                        <th>Deviation</th>
                        <th>Last Updated</th>
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
