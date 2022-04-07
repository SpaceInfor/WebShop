<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="WebShop.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Change Password</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">General Form</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-6">
                <div class="card card-info">
              <div class="card-header">
                <h3 class="card-title" id="hdmsg" runat="server">Please Change Password From Here</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              
                <div class="card-body">
                  <div class="form-group row">
                    <label for="inputEmail3" class="col-sm-2 col-form-label">Old Password</label>
                    <div class="col-sm-10">
                      <asp:TextBox ID="txtOldPass" runat="server" placeholder="Old Password" TextMode="Password" cssClass="form-control"></asp:TextBox>

                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
                    <div class="col-sm-10">
                      <asp:TextBox ID="txtNewPass" runat="server" placeholder="Old Password"  cssClass="form-control" TextMode="Password"></asp:TextBox>  
                    </div>
                  </div>
                  <div class="form-group row">
                     <label for="inputPassword3" class="col-sm-2 col-form-label"> Confirm Password</label>
                    <div class="col-sm-10">
                      <asp:TextBox ID="txtConfPass" runat="server" placeholder="Confirm Password" TextMode="Password" cssClass="form-control"></asp:TextBox>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                  <asp:Button ID="btnChange" runat="server" Text="Change Password" cssclass="btn btn-info" OnClick="btnChange_Click" />
                </div>
                <!-- /.card-footer -->
              
            </div>
          </div>
        </div>
          </div>
    </section>
</asp:Content>
