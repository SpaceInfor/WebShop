<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="SOInfo.aspx.cs" Inherits="WebShop.SOInfo" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Spacewood SO Information</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">
  <form id="form1" runat="server">
  <!-- Navbar -->
  
  <!-- /.navbar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Sales Order <small>Info</small></h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container">
        <div class="row">

          <!-- /.col-md-6 -->
          <div class="col-lg-6">
            <div class="card card-warning">
              <div class="card-header">
                <h3 class="card-title"></h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
       
                <div class="card-body">
                  <div class="form-group">
                    <label for="exampleInputEmail1">Sales Order/Project Code</label>
                    <input class="form-control" id="t_orno"  runat="server" placeholder="Enter Sales Order/Project Code">
                  </div>
                  
             
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                  
                  <asp:Button ID="Button1" runat="server" Text="Search" cssClass="btn btn-warning" OnClick="Button1_Click" />
                </div>
              
            </div>

            <div class="card">
              
              <!-- /.card-header -->
              <div class="card-body card-body table-responsive p-0" id="dvinfo" runat="server" visible="false">
                <table class="table table-striped">
                 
                  <tbody>
                    <tr>
                      
                      <td><b>Sales Order No</b></td>
                      <td>
                        
                        <b>  : </b>
                        
                      </td>
                      <td><asp:Label ID="lbl_t_orno" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                      <td><b>Project</b></td>
                      <td>
                        <b>  : </b>
                      </td>
                      <td><asp:Label ID="lblt_cprj" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                      <td><b>Customer</b></td>
                      <td>
                        <b>  : </b>
                      </td>
                      <td><asp:Label ID="lblt_ofbp" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                      <td><b>Consignee</b></td>
                      <td>
                        <b>  : </b>
                      </td>
                      <td><asp:Label ID="lblt_stbp" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                      <td><b>Destination</b></td>
                      <td>
                        <b>  : </b>
                      </td>
                      <td><asp:Label ID="lblt_dest" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                      <td><b>Status</b></td>
                      <td>
                        <b>  : </b>
                      </td>
                      <td><asp:Label ID="lblt_stat" runat="server" Text=""></asp:Label></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>

            
          </div>
          <!-- /.col-md-6 -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="float-right d-none d-sm-inline">

    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2010-2021 <a href="https://spacewood.in">Spacewood Furnishers Pvt. Ltd.</a>.</strong> All rights reserved.
  </footer>
  </form>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
</html>
