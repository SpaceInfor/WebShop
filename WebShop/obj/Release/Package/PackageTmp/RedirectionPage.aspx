<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="RedirectionPage.aspx.cs" Inherits="WebShop.RedirectionPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Notification Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Notification Page..</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Inline Charts</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
     <script>
         var timer = setTimeout(function () {
             window.location = 'CustOrderlist.aspx'
         }, 3000);
    </script>
      <div class="container-fluid">
        <!-- COLOR PALETTE -->
        <div class="card card-default color-palette-box">
          <div class="card-header">
            <h3 class="card-title">
              <i class="fas fa-tag"></i>
              Notification Page
            </h3>
          </div>
          <div class="card-body">
            <div class="col-12">
            </div>
            <!-- /.col-12 -->
            <div class="row">
           
              <div class="col-md-12">
            <!-- Widget: user widget style 1 -->
                <div class="card card-widget widget-user">
              <!-- Add the bg color to the header using any of the bg-* classes -->
              <div class="widget-user-header">
                <h3 class="widget-user-username">Thank you for your order!</h3>
                <h5 class="widget-user-desc">We have received your orde and it is under approval.</h5>
              </div>
              <div class="widget-user-image">
                <img class="img-circle elevation-2" src="../images/loading.gif" alt="User Avatar">
              </div>
              <div class="card-footer">
                <div class="row">
                  <div class="col-sm-4 border-right">
                    <div class="description-block">
                      <h5 class="description-header">Quotation No</h5>
                      <span class="description-text" id="Ordid" runat="server"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-4 border-right">
                    <div class="description-block">
                      <h5 class="description-header">ITEM</h5>
                      <span class="description-text" id="itemid" runat="server"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                  <div class="col-sm-4">
                    <div class="description-block">
                      <h5 class="description-header">QUANTITY</h5>
                      <span class="description-text" id="qty" runat="server"></span>
                    </div>
                    <!-- /.description-block -->
                  </div>
                  <!-- /.col -->
                </div>
                <!-- /.row -->
              </div>
            </div>
            <!-- /.widget-user -->
          </div>
            
              </div>
              <!-- /.card-body -->
            </div>
          <div class="card-footer">
            <center>You will be redirected to quotation list soon..</center>
          </div>
            <!-- /.card -->
          </div>
        </div>
    </section>
</asp:Content>
