<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EwayBill.aspx.cs" Inherits="WebShop.EwayBill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>..SFPL..</title>
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/pace-progress/themes/black/pace-theme-flat-top.css">
      <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
=
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->


  <!-- summernote -->

  <%--<link rel="stylesheet" href="../../plugins/pace-progress/themes/yellow/pace-theme-mac-osx.css">--%>
    <script>
        $(document).ajaxStart(function () { Pace.restart(); });
    </script>
</head>
<body>
  <form id="form1" runat="server">

        <div class="preloader flex-column justify-content-center align-items-center bg-transparent">
          <img  src="Images/SLoading.gif" alt="Spacewood" height="80" width="80">
        </div>
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
             
              <div class="row">
                <div class="col-12">
                  <a href="#" class="brand-link navbar-light">
                    <img src="Images/logo-header.png" alt="Spacewood Logo" class="brand-image" style="opacity: .8">
                    <span class="brand-text font-weight-light"></span></a>
                </div>
                <!-- /.col -->
              </div>
            </div>
          </div><!-- /.container-fluid -->
        </section>
        <section class="content">
          <div class="col-md-6">
            <div class="card card-default">
              <div class="card-header">
                <h3 class="card-title">  
                  Spacewood Eway Bill Generation System
                </h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="alert alert-danger alert-dismissible" id="NOK" runat="server" visible="false">
             
                  <h5><i class="icon fas fa-ban"></i> Alert!</h5>
                   Eway Bill is not generated!
                  <asp:Label ID="lblerror" runat="server" Text=""></asp:Label>
                </div>
              
                <div class="alert alert-success alert-dismissible" id="OK" runat="server" visible="false">
            
                  <h5><i class="icon fas fa-check"></i> Alert!</h5>
                  Eway Bill generated Successfully!<br />
                  Eway Bill No : <asp:Label ID="lblewaybill" runat="server" Text=""></asp:Label>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>

 
            <div class="row">
              <div class="col-md-12">
                <div style="height:100%">
                  <embed  runat="server" id="waybillpdf" width="100%" height="1000"> </embed>
                  </div>
              </div><!-- /.col -->
            </div><!-- /.row -->
     
          <div id="sam" runat="server"></div>
      <!-- /.card -->
    </section>

    </form>
    <script src="plugins/jquery/jquery.min.js"></script>
      <!-- Bootstrap -->
      <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
      <!-- overlayScrollbars -->
      <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
      <!-- AdminLTE App -->
      <script src="dist/js/adminlte.js"></script>
      <!-- OPTIONAL SCRIPTS -->
      <script src="dist/js/demo.js"></script>
      <!-- PAGE PLUGINS -->
      <!-- jQuery Mapael -->

      <script src="../../plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
      <script src="../../plugins/pace-progress/pace.min.js"></script>

          <!-- ChartJS -->


          <!-- PAGE SCRIPTS -->



                <script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
      <!-- AdminLTE App -->

      <!-- AdminLTE for demo purposes -->
      <script src="../dist/js/demo.js"></script>
      <!-- Filterizr-->
      <script src="../plugins/filterizr/jquery.filterizr.min.js"></script>
      <!-- Page specific script -->
      <script>
        $(function () {
          $(document).on('click', '[data-toggle="lightbox"]', function (event) {
            event.preventDefault();
            $(this).ekkoLightbox({
              alwaysShowClose: true
            });
          });
          $('.filter-container').filterizr({ gutterPixels: 3 });
          $('.btn[data-filter]').on('click', function () {
            $('.btn[data-filter]').removeClass('active');
            $(this).addClass('active');
          });
        })
      </script>
</body>
</html>
