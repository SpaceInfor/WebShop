  <%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="WebOrderBooking.aspx.cs" Inherits="WebShop.WebOrderBooking" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <!-- Font Awesome -->
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
    function BindOrder(orderid)
    {
        $.ajax({
            type: "POST",
            url: "WebOrderBooking.aspx/bind_orderdata",
            <%--data: '{i_orno: "' + '<%#Session["t_orno"].ToString()%>' '" }',--%>
            data: '{i_orno: "' + orderid +'" }',
            contentType: "application/json; charset=utf-8",
             dataType: "json",
            success: BindTable,
            failure: function (response)
            {
                document.getElementById('ct1_tb1').innerHTML = response.d;
            }
      });
    }
      function BindTable(response)
    {
          document.getElementById('ct1_tb1').innerHTML = response.d;
    }
  </script> 
  <script type="text/javascript">
      
      function get_Price()
      {    
          $.ajax({
              type: "POST",
              url: "WebOrderBooking.aspx/GetPrice",
              data: '{t_ofbp:"' + $("#<%=t_ofbp.ClientID%>")[0].value + '",t_item:"' + $("#<%=t_item.ClientID%>")[0].value + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: ShowPrice,
              failure: function (response)
              {
                 alert(response.d);
              }
          });
      }
      function ShowPrice(response)
      {
          var qoor,pric;
          qoor = document.getElementById('t_qoor').value
          pric = response.d[0];    
          document.getElementById('ct1_t_pric').value = response.d[0];
          document.getElementById('ct1_t_cuni').value = response.d[1];
          document.getElementById('ct1_t_oamt').value = (pric * qoor);    
      }
  </script>
  <script type = "text/javascript">
    function AddOrder()
    {
        $.ajax(
              {
                type: "POST",
                url: "WebOrderBooking.aspx/ProcessIT",
                data: '{t_cotp: "' + $("#<%=t_cotp.ClientID%>")[0].value + '",t_ofbp: "' + $("#<%=t_ofbp.ClientID%>")[0].value + '",t_stbp:"' + $("#<%=t_stbp.ClientID%>")[0].value + '",t_cwar:"' + $("#<%=t_cwar.ClientID%>")[0].value + '",t_cofc:"' + $("#<%=t_cofc.ClientID%>")[0].value + '",t_refb:"' + $("#<%=t_refb.ClientID%>")[0].value + '",t_corn:"' + $("#<%=t_corn.ClientID%>")[0].value + '",t_item:"' + document.getElementById('ct1_t_item').value + '",t_qoor:"' + $("#<%=t_qoor.ClientID%>")[0].value + '",t_pric:"' + $("#<%=t_pric.ClientID%>")[0].value + '" }',
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
        //document.getElementById('tb1').innerHTML    =   response.d;
        orderid.innerHTML = response.d;
        BindOrder(response.d);
        document.getElementById('ct1_t_item').value =   "";
        document.getElementById('t_qoor').value     =   "";
        document.getElementById('ct1_t_pric').value =   "";
        document.getElementById('ct1_t_cuni').value =   "";
        document.getElementById('ct1_t_oamt').value =   "";
    }
</script> 
  <script language="javascript">
        var ctrl
        function openChild(control,form) {
            ctrl = control
            frm = form + ".aspx?param1=" + document.getElementById('<%=t_ofbp.ClientID %>').value;
            var left = (screen.width - 800) / 2;
            var top = (screen.height - 400) / 4;
            childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
        }
        function setValue(myVal)
        {
            document.getElementById(ctrl).value = myVal;
            $(document).ready(function ()
            {
                document.getElementById(ctrl).onchange();
            });
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
  </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
  <asp:ScriptManager ID="scriptmanager1" runat="server" EnablePageMethods="true" AjaxFrameworkMode="Enabled">  
</asp:ScriptManager>

<%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
    <ContentTemplate>--%>
      <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Sales Quotation Booking</h1>
          </div>          
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="BuyerDashboard.aspx">Home</a></li>
              <li class="breadcrumb-item"><a href="OrderDashboard.aspx">Order Booking List</a></li>
              <li class="breadcrumb-item active">Sales Quotation Booking</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
    <div class="container-fluid">
       <div class="row">
        <div class="col-md-12">
        <!-- SELECT2 EXAMPLE -->
          <div class="card card-warning card-outline">
            <div class="card-header">
            <h3 class="card-title"><i class="fa fa-fw fa-cart-plus"></i> Sales Quotation Details</h3>
              <div class="card-tools">
              <%--<button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
              <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-remove"></i></button>--%>
            <span class="float-right username"><a href="#" id="orderid"></a></span>
            </div>
          </div>
          <!-- /.card-header -->
            <div class="card-body">
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
                <ContentTemplate>
                  <div class="row">
                    <div class="col-4">
                      <div class="form-group">
                        <label>Order Type</label>  
                        <div class="input-group">
                          <asp:DropDownList ID="t_cotp" runat="server" class="form-control" placeholder="Select Order Type" AutoPostBack="true">
                            <asp:ListItem Text="Regular Sales Order" Value="REG"></asp:ListItem>
                            <asp:ListItem Text="Service Order" Value="FOC"></asp:ListItem>
                          </asp:DropDownList>
                          
                          <div class="input-group-append">
                          </div>  
                        </div> 
                        &nbsp;<label id="Label8" runat="server" class="link-black text-sm"></label>
                      </div>
                    </div>
                    <div class="col-4">
                      <div class="form-group">
                          <label>Reference</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_refb" runat="server" class="form-control" placeholder="Add Order Reference"></asp:TextBox>
                            <div class="input-group-append">
                            </div>
                          </div>                      
                          &nbsp;<label id="Label2" runat="server" class="link-black text-sm"></label>   
                      </div>
                    </div>
                    <div class="col-4">
                      <div class="form-group">
                          <label>Customer Order</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_corn" runat="server" class="form-control" placeholder="Add Customer Order Here"></asp:TextBox>
                            <div class="input-group-append">
                            </div>
                          </div>                      
                          &nbsp;<label id="Label1" runat="server" class="link-black text-sm"></label>   
                        </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-4">
                      <div class="form-group">
                        <label>Bill To Customer</label>  
                        <div class="input-group">
                          <asp:TextBox ID="t_ofbp" runat="server" class="form-control" placeholder="Add Bill To Business Partner Here" OnTextChanged="t_ofbp_TextChanged"  AutoPostBack="true"></asp:TextBox>
                          <div class="input-group-append">
                          <button id="btnofbp" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_ofbp','HelpPages/tccom1500m000')"><i class="fa fa-fw fa-search"></i></button>
                          </div>  
                        </div> 
                        &nbsp;<label id="t_ofbp_nama" runat="server" class="link-black text-sm"></label>
                      </div>
                    </div>
                    <div class="col-4">
                      <div class="form-group">
                      <label>Ship To Customer</label>  
                      <div class="input-group">
                      <asp:TextBox ID="t_stbp" runat="server" class="form-control" placeholder="Add Ship To Partner Here" OnTextChanged="t_stbp_TextChanged"  AutoPostBack="true"></asp:TextBox>
                      <div class="input-group-append">
                      <button id="btnstbp" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_stbp','HelpPages/tccom1500m000')"><i class="fa fa-fw fa-search"></i></button>
                      </div>
                    </div>                      
                      &nbsp;<label id="t_stbp_nama" runat="server" class="link-black text-sm"></label>   
                    </div>
                    </div>
                    <div class="col-4">
                    <div class="form-group">
                      <label>Warehouse</label>  
                      <div class="input-group">
                        <asp:TextBox ID="t_cwar" runat="server" class="form-control" placeholder="Add Warehouse Here" OnTextChanged="t_cwar_TextChanged"  AutoPostBack="true"></asp:TextBox>
                        <div class="input-group-append">
                          <button id="btncwar" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_cwar','HelpPages/tcemm1512m000')"><i class="fa fa-fw fa-search"></i></button>
                        </div>
                      </div>                      
                      &nbsp;<label id="t_cwar_nama" runat="server" class="link-black text-sm"></label>   
                    </div>
                 </div>
                    
                    
                  </div>
                  <div class="row">
                    <div class="col-4">
                      <div class="form-group">
                        <label>Sales Office</label>  
                        <div class="input-group">
                          <asp:TextBox ID="t_cofc" runat="server" class="form-control" placeholder="Add Sales Office Here" OnTextChanged="t_cofc_TextChanged"  AutoPostBack="true"></asp:TextBox>
                          <div class="input-group-append">
                            <button id="btnSalesoff" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_cofc','HelpPages/tdsls0512m000')"><i class="fa fa-fw fa-search"></i></button>
                          </div>
                        </div>                      
                        &nbsp;<label id="t_cofc_nama" runat="server" class="link-black text-sm"></label>   
                      </div>
                    </div>
                     <div class="col-4">
                       <div class="form-group">
                        <label for="exampleInputFile">File input</label>
                          <div class="input-group">
                            <div class="custom-file">
                              <input type="file" class="custom-file-input" id="orderfile"  name="orderfile"  type="file" r >
                              <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                            </div>
                            <div class="input-group-append">
                              <%--<button id="btnUpload" type="button" runat="server" class="btn btn-block btn-warning" onclick="btnUpload_Click">Upload</i></button>--%>
                              <asp:Button ID="btnUpload" runat="server" Text="Upload"  OnClick="btnUpload_Click" />
                            </div>
                          </div>
                        </div>
                    </div>
                  </div>  
                </ContentTemplate>
              </asp:UpdatePanel>
            </div>
          </div>
      
          <div class="card card-warning card-outline">
            <div class="card-header">
              <h3 class="card-title"><i class="fa fa-fw fa-tasks"></i> Sales Quotation Lines</h3>
              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-remove"></i></button>
              </div>
            </div>
            <!-- /.card-header -->
            
            <div class="card-body">
              <div class="row">
                  <div class="col-md-12">
                    <div class="row">
                          <div class="col-3">
                         <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
                          <ContentTemplate>
                          <div class="form-group">
                            <label>Item Code</label>  
                            <div class="input-group">
                              <asp:TextBox ID="t_item" runat="server" class="form-control" placeholder="Add Item Code" OnTextChanged="t_item_TextChanged"  AutoPostBack="true"></asp:TextBox>
                              <div class="input-group-append">
                                <button id="btnitem" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_item','HelpPages/tcibd0501m000')"><i class="fa fa-fw fa-search"></i></button>
                              </div>  
                            </div>                      
                            &nbsp;<label id="t_item_desc" class="link-black text-sm" runat="server"></label>   
                          </div>
                            </ContentTemplate>
                           </asp:UpdatePanel>
                      </div>
                      <div class="col-2">
                        <div class="form-group">
                          <label>Qty</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_qoor" runat="server" class="form-control" placeholder="Add Qty"  onChange="get_Price();" ClientIDMode="Static"></asp:TextBox>
                          </div>                      
                          &nbsp;<label id="Label3" runat="server" class="text-sm mb-0"></label>   
                        </div>
                      </div>
                      <div class="col-2">
                        <div class="form-group">
                          <label>Unit</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_cuni" runat="server" class="form-control" placeholder="Unit" disabled></asp:TextBox>
                          </div>                      
                          &nbsp;<label id="Label4" runat="server" class="text-sm mb-0"></label>   
                        </div>    
                      </div>
                      <div class="col-2">
                        <div class="form-group">
                          <label>Price / Unit</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_pric" runat="server" class="form-control" placeholder="Price / Unit"></asp:TextBox>
                          </div>                      
                          &nbsp;<label id="Label5" runat="server" class="text-sm mb-0"></label>   
                        </div>
                      </div>
                      <div class="col-2">
                    <div class="form-group">
                      <label>Amount</label>  
                      <div class="input-group">
                        <asp:TextBox ID="t_oamt" runat="server" class="form-control" placeholder="Amount" disabled></asp:TextBox>
                      </div>                      
                      &nbsp;<label id="Label6" runat="server" class="text-sm mb-0"></label>   
                    </div>
                  </div>
                      <div class="col-1">
                        <div class="form-group">
                          <label>&nbsp;</label>  
                          <div class="input-group">
                             <button  id="btnGetTime" type="button" class="btn btn-warning float-right toastrDefaultSuccess" onclick = "AddOrder();"><i class="fas fa-plus"></i></button>
                            </div>                      
                          &nbsp;<label id="Label7" runat="server" class="text-sm mb-0"></label>   
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
                                <th>Pos</th>
                                <th>Item Code</th>
                                <th>Description</th>
                                <th>Qty</th>
                                <th>Unit</th>
                                <th>Price</th>
                                <th>Amount</th>
                                <th></th>
                                </tr>
                              </thead>
                              <tbody id="tb1" runat="server"> 
                              </tbody>
                              <tfoot>
                              </tfoot>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>  
     </div>   
<!-- DataTables -->

  
<!-- Bootstrap 4 -->

<!-- DataTables -->


</section>
<%--    </ContentTemplate>
  </asp:UpdatePanel>  
                     --%>
  <script type="text/javascript">
      $(document).ready(function () {
          bsCustomFileInput.init();
      });
</script>
</asp:Content>
