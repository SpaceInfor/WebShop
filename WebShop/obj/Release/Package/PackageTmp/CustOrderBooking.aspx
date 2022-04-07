  <%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="CustOrderBooking.aspx.cs" Inherits="WebShop.CustOrderBooking" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
   
  <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script type="text/javascript">
        function EnableDisableTextBox(t_cotp)
        {
          var selectedValue = t_cotp.options[t_cotp.selectedIndex].value;
          var t_morn = document.getElementById("ct1_t_morn");
          t_morn.disabled = selectedValue > 1 ? false : true;
          btnMorn.disabled = selectedValue > 1 ? false : true;
          if (!t_morn.disabled) {
              t_morn.focus();
          }  
        }
    </script>
    <script type = "text/javascript">
      function AddOrder()
      {
        var mainorder = $("#<%=t_morn.ClientID%>")[0].value;
        var e = document.getElementById("ct1_t_cotp");
        var quottype = e.options[e.selectedIndex].value;
        if (document.getElementById("ct1_t_ofbp_nama").innerText == '')
        {
            var ofbp_var = document.getElementById("ct1_t_ofbp");
            var ofbp_name_var = document.getElementById("ct1_t_ofbp_nama");
            ofbp_var.className = "form-control is-invalid";
            document.getElementById("ct1_t_ofbp_nama").innerText = "Please add valid secondary customer";
            ofbp_name_var.className = "error invalid - feedback";
            return;
        }
        debugger
        if (document.getElementById("ct1_t_cprj_desc").innerText == '' && document.getElementById("ct1_t_cprj").value.length > 0) {
          alert(document.getElementById("ct1_t_cprj").innerText);
          var ofbp_var = document.getElementById("ct1_t_cprj");
          var ofbp_name_var = document.getElementById("ct1_t_cprj_desc");
          ofbp_var.className = "form-control is-invalid";
          document.getElementById("ct1_t_cprj_desc").innerText = "Please add valid project ID";
          ofbp_name_var.className = "error invalid - feedback";
          return;
        }
        if (document.getElementById("ct1_t_item_desc").innerText == '') {
              var item_var = document.getElementById("ct1_t_item");
              var item_name_var = document.getElementById("ct1_t_item_desc");
            item_var.className = "form-control is-invalid";
              document.getElementById("ct1_t_item_desc").innerText = "Please add valid Item Code";
            item_name_var.className = "error invalid - feedback";
            return;
        }  
        if (mainorder == 'undefined')
        {
            mainorder = "";
        }
        $.ajax(
          {
              type: "POST",
              url: "CustOrderBooking.aspx/ProcessIT",
            data: '{t_refb: "' + $("#<%=t_refb.ClientID%>")[0].value + '",t_ofbp:"' + $("#<%=t_ofbp.ClientID%>")[0].value + '",t_morn:"' + mainorder + '",t_incl:"' + $("#<%=t_incl.ClientID%>")[0].value + '",t_dlcd:"' + $("#<%=t_dlcd.ClientID%>")[0].value + '",t_item:"' + $("#<%=t_item.ClientID%>")[0].value + '",t_qoor:"' + $("#<%=t_qoor.ClientID%>")[0].value + '",t_qtyp:"' + quottype + '",t_rmrk:"' + $("#<%=t_rmrk.ClientID%>")[0].value + '",t_cprj:"' + $("#<%=t_cprj.ClientID%>")[0].value + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: OnSuccess,
              failure: function (response) {
              //alert(response.d);
            }
          });
    }
    function OnSuccess(response)
    {
        orderid.innerHTML = response.d; 
        window.location = "RedirectionPage.aspx?ORD=" + response.d;

    }
    </script> 
  <script language="javascript">
      var ctrl 
      function openChild(control, form) {
          var username = '<%= Session["t_usid"] %>';
          ctrl = control
          frm = form + ".aspx?param1=" + username;
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
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          <h1>Sales Quotation Booking</h1>
        </div>          
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="CustOrderBooking.aspx">Home</a></li>
            <li class="breadcrumb-item"><a href="CustOrderList.aspx">Order Booking List</a></li>
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
          <div class="card card-warning card-outline">
            <div class="card-header">
              <h3 class="card-title"><i class="fa fa-fw fa-cart-plus"></i>Order Details</h3>
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
                          <label>Order Type</label>  
                          <asp:DropDownList ID="t_cotp" runat="server" CssClass="form-control" OnSelectedIndexChanged="t_cotp_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value=1 Text="Main Order"></asp:ListItem>  
                            <asp:ListItem Value=2 Text="Service Order"></asp:ListItem>  
                            <asp:ListItem Value=3 Text="Additional Order"></asp:ListItem>  
                          </asp:DropDownList>
                         &nbsp;<label id="Label1" runat="server" class="link-black text-sm"></label>
                        </div> 
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Master Project ID</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_cprj" runat="server" class="form-control" placeholder="Add Master Project ID Here" OnTextChanged="t_cprj_TextChanged"  AutoPostBack="true"></asp:TextBox>
                            <div class="input-group-append">
                              <button id="btncprj" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_cprj','HelpPages/tdtst1506m000')"><i class="fa fa-fw fa-search"></i></button>
                            </div>  
                          </div> 
                          &nbsp;<label id="t_cprj_desc" runat="server" class="link-black text-sm"></label>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Secondary Customer</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_ofbp" runat="server" class="form-control" placeholder="Add Bill To Business Partner Here" OnTextChanged="t_ofbp_TextChanged"  AutoPostBack="true"></asp:TextBox>
                            <div class="input-group-append">
                              <button id="btnofbp" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_ofbp','HelpPages/tdtst1500m000')"><i class="fa fa-fw fa-search"></i></button>
                            </div>  
                          </div> 
                          &nbsp;<label id="t_ofbp_nama" runat="server" class="link-black text-sm"></label>
                        </div>
                      </div>
                      <div class="col-md-6" id="morder" runat="server">
                        <div class="form-group">
                          <label>Main Order</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_morn" runat="server" class="form-control" placeholder="Add Main Order Here" OnTextChanged="t_ofbp_TextChanged"  AutoPostBack="true" ></asp:TextBox>
                            <div class="input-group-append">
                              <button id="btnMorn" type="button" runat="server" class="btn btn-block btn-warning" onclick="openChild('ct1_t_morn','HelpPages/tdsls4500m000')"><i class="fa fa-fw fa-search"></i></button>
                            </div>  
                          </div> 
                          &nbsp;<label id="Label3" runat="server" class="link-black text-sm"></label>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Reference</label>  
                          <asp:TextBox ID="t_refb" runat="server" class="form-control" placeholder="Add Customer Order Here"></asp:TextBox>      
                          &nbsp;<label id="Label2" runat="server" class="link-black text-sm"></label>
                        </div>
                      </div>
                      <div class="col-md-6">    
                        <div class="form-group">
                        <label>Innocal Quotation Ref</label>  
                        <asp:TextBox ID="t_incl" runat="server" class="form-control" placeholder="Add Order Reference"></asp:TextBox>
                        &nbsp;<label id="Label5" class="link-black text-sm" runat="server"></label>   
                      </div>                      
                      </div>
                      <div class="col-md-6">    
                        <div class="form-group">
                        <label>DeltaCadd Quotation Ref</label>  
                        <asp:TextBox ID="t_dlcd" runat="server" class="form-control" placeholder="Add Order Reference"></asp:TextBox>
                        &nbsp;<label id="Label4" class="link-black text-sm" runat="server"></label>   
                      </div>    
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Item Code</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_item" runat="server" class="form-control" placeholder="Add Item Code" OnTextChanged="t_item_TextChanged"  AutoPostBack="true"></asp:TextBox>
                            <div class="input-group-append">
                              <button id="btnitem" type="button" class="btn btn-block btn-warning" onclick="openChild('ct1_t_item','HelpPages/tdtst1505m000')"><i class="fa fa-fw fa-search"></i></button>
                            </div>  
                          </div>                      
                          &nbsp;<label id="t_item_desc" class="link-black text-sm" runat="server"></label>   
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Qty</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_qoor" runat="server" class="form-control" placeholder="Add Qty"></asp:TextBox>
                          </div>                      
                          &nbsp;<label id="Label9" runat="server" class="text-sm mb-0"></label>   
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>Remarks</label>  
                          <div class="input-group">
                            <asp:TextBox ID="t_rmrk" runat="server" class="form-control" placeholder="Add Remarks (Max 300 Char.)" TextMode="MultiLine"></asp:TextBox>
                          </div>                      
                          &nbsp;<label id="Label6" runat="server" class="text-sm mb-0"></label>   
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>File Upload</label>  
                          <div class="input-group">
                            <div class="custom-file">
                              <asp:FileUpload runat="server" ID="UploadImages" AllowMultiple="true" cssclass="form-control"/>
                            </div>
                            <div class="input-group-append">
                              <asp:Button runat="server" ID="uploadedFile" Text="Upload" OnClick="uploadFile_Click" class="btn btn-block btn-warning" />
                            </div>
                          </div>                      
                          <asp:Label ID="listofuploadedfiles" runat="server" />
                        </div>
                      </div>
                    </div>  
                  </ContentTemplate>
                  <Triggers>
                    <asp:PostBackTrigger ControlID = "uploadedFile" />
                  </Triggers>
                </asp:UpdatePanel>
                </div>
                <div class="card-footer">
                  <button id="btnAddOrder" type="button" class="btn btn-warning float-left" onclick = "AddOrder();"><i class="fas fa-plus"></i>Add Order</button>
                </div>
            </div>
          </div>
      </div>
    </div>  
  </section>                  
  <script>
      $(function () {
          //Initialize Select2 Elements
          $('.select2').select2()

          //Initialize Select2 Elements
          $('.select2bs4').select2({
              theme: 'bootstrap4'
          })

          //Datemask dd/mm/yyyy
          $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
          //Datemask2 mm/dd/yyyy
          $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
          //Money Euro
          $('[data-mask]').inputmask()

          //Date range picker
          $('#reservation').daterangepicker()
          //Date range picker with time picker
          $('#reservationtime').daterangepicker({
              timePicker: true,
              timePickerIncrement: 30,
              locale: {
                  format: 'MM/DD/YYYY hh:mm A'
              }
          })
          //Date range as a button
          $('#daterange-btn').daterangepicker(
              {
                  ranges: {
                      'Today': [moment(), moment()],
                      'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                      'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                      'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                      'This Month': [moment().startOf('month'), moment().endOf('month')],
                      'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                  },
                  startDate: moment().subtract(29, 'days'),
                  endDate: moment()
              },
              function (start, end) {
                  $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
              }
          )
          //Timepicker
          $('#timepicker').datetimepicker({
              format: 'LT'
          })

          //Bootstrap Duallistbox
          $('.duallistbox').bootstrapDualListbox()

          //Colorpicker
          $('.my-colorpicker1').colorpicker()
          //color picker with addon
          $('.my-colorpicker2').colorpicker()

          $('.my-colorpicker2').on('colorpickerChange', function (event) {
              $('.my-colorpicker2 .fa-square').css('color', event.color.toString());
          });

          $("input[data-bootstrap-switch]").each(function () {
              $(this).bootstrapSwitch('state', $(this).prop('checked'));
          });

      })
</script>
  <script type="text/javascript">
      $(document).ready(function () {
          bsCustomFileInput.init();
      });
  </script>
  <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Toastr -->
<script src="../../plugins/toastr/toastr.min.js"></script>
    <script src="../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jQuery UI -->
<script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Filterizr-->
<script src="../plugins/filterizr/jquery.filterizr.min.js"></script>
<script src="../../plugins/jquery-validation/jquery.validate.min.js"></script>

<script src="../../plugins/jquery-validation/additional-methods.min.js"></script>
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



</asp:Content>
