<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompFileUpload.aspx.cs" Inherits="WebShop.CompFileUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body>
    
    <form id="form1" runat="server" enctype="multipart/form-data">
      <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Upload Files</h1>
          </div>
         
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
      <section class="content">
     
        <div class="container-fluid">
        <div class="row">
          <div class="col-md-6">
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">Upload Files here</h3>
              </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>      
              <div class="card-body">
                <div class="input-group">
                  <div class="custom-file">
                    <asp:FileUpload runat="server" ID="UploadImages" AllowMultiple="true" cssclass="form-control"/>
                  </div>
                  <div class="input-group-append">
                    <asp:Button runat="server" ID="uploadedFile" Text="Upload" OnClick="uploadFile_Click" class="btn btn-block btn-warning"  UseSubmitBehavior="false" OnClientClick="javascript:document.forms[0].encoding = 'multipart/form-data';"/>
                  </div>
                </div>                      
                <asp:Label ID="listofuploadedfiles" runat="server" />
              </div>
              </ContentTemplate>
               <Triggers>
              <asp:PostBackTrigger ControlID="uploadedFile" />
              </Triggers>
              </asp:UpdatePanel>
            </div>
            </div>
          </div>
          <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">DataTable with minimal features & hover style</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Position</th>
                  <th>File Name</th>
                  <th>Download Path</th>
                  
                  
                </tr>
                </thead>
                <div id="sam" runat="server">
                  
                </div>
                <tfoot>
                </tfoot>
              </table>
              </div>
              <!-- /.card-body -->
            </div>
          </div>
        </div>
        </div>

    </section>

    </form>
</body>
</html>
