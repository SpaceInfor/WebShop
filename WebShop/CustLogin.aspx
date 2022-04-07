<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustLogin.aspx.cs" Inherits="WebShop.CustLogin" enableViewStateMac="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>SFPL Customer Portal</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <style>
    .background {
    background-image: url('images/view3.jpg');
    background-position: center;
    background-repeat: no-repeat;
    background-size:cover;
    height: 100vh;
    width: 100%;
    backdrop-filter: blur(0px); 
    
  }

    /*.blur {
      background: rgba(255, 255, 255, 0.2); // Make sure this color has an opacity of less than 1
      backdrop-filter: blur(8px); // This be the blur
      height: 100vh;
	    width: 50%;
  }*/
  </style>
</head>
<%--<body class="hold-transition login-page" style=" background-image: url('images/Login.jpg');background-position:center center; background-size:cover;
    background-repeat':no-repeat' -webkit-filter: blur(5px);filter: blur(5px);" >--%>
<body class="hold-transition login-page background blur">
  <div class="login-box">
    <div>
    <img src="Images/loginlogo.png" width="100%" >
  </div>
  <!-- /.login-logo -->
    <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg"><asp:Label ID="Msg" runat="server" Text="Sign in to start your session"></asp:Label></p>
       <form  runat="server" id="login" >
        <div class="input-group mb-3"> 
          <asp:TextBox ID="usrid"  cssclass="form-control" runat="server"  placeholder="User Name"  autocomplete="off" ></asp:TextBox>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
         <asp:TextBox ID="paswd"  cssclass="form-control" runat="server"  placeholder="Password" TextMode="Password" autocomplete="off"></asp:TextBox>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Remember Me
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <asp:Button  id="btnLogin" runat="server" onclick="btnLogin_Click" Text="Sign In" CssClass="btn btn-warning btn-block"  />
          </div>
          <!-- /.col -->
        </div>
      </form>
      <!-- /.social-auth-links -->

      <p class="mb-1">
        <a href="ForGotPassword.aspx">I forgot my password</a>
      </p>
      <p class="mb-0">
      </p>
    </div>
    
    <!-- /.login-card-body -->
  </div>
  </div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
</body>
</html>

