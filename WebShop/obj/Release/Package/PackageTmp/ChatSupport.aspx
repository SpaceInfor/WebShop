<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="ChatSupport.aspx.cs" Inherits="WebShop.ChatSupport" %>
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
    <script type = "text/javascript">
      function bind_CustomerChat(worn) {

        $.ajax({
          type: "POST",
          url: "ChatSupport.aspx/bind_CustomerChat",
          data: '{t_worn: "' + worn + '" }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: BindTable,
          failure: function (response) {
            document.getElementById('chat').innerHTML = response.d;
          }
        });
      }
      function BindTable(response) {
        document.getElementById('chat').innerHTML = response.d;
      }
  </script> 
  <script type = "text/javascript">
    function AddChat() {
        $.ajax(
          {
            type: "POST",
            url: "ChatSupport.aspx/ProcessIT",
            data: '{t_worn: "' + $("#<%=t_worn.ClientID%>")[0].innerText + '",t_cmsg: "' + $("#<%=t_chat.ClientID%>")[0].value + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,
            failure: function (response) {
              alert(response.d);
          }
        });
    }
    function OnSuccess(response) {
      //document.getElementById('tb1').innerHTML  =   response.d;
      //alert('Secondary Customer added successfully!');
      var worn = $("#<%=t_worn.ClientID%>")[0].innerText;
      bind_CustomerChat(worn);
      $("#<%=t_chat.ClientID%>")[0].value = "";
    }
  </script> 
  <script type="text/javascript">

    $(document).ready(function () {
      var worn = $("#<%=t_worn.ClientID%>")[0].innerText;
      
      bind_CustomerChat(worn);
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
          <h1>Sales Quotation Chat</h1>
        </div>          
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
           
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
              <h3 class="card-title"><i class="fas fa-comments"></i>Order Chat Support</h3>
                <div class="card-tools">
                  <span class="float-right username"><a href="#" id="orderid"></a></span>
                </div>
              </div>
              <div class="card-body">                
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
                  <ContentTemplate>
                    <div class="row">
                      <div class="col-md-12">
                        <div class="card direct-chat direct-chat-primary">
                          <div class="card-header">
                            <h3 class="card-title">Order ID # <asp:label ID="t_worn" runat="server"></asp:label></h3>
                              <div class="card-tools">
                                <a class="btn btn-block btn-warning btn-xs" href="ChatList.aspx">
                                  
                                  <i class="fa fa-fw fa-backward"></i> Back
                                </a>            
                            </div>
                          </div>
                          <div class="card-body">
                          <!-- Conversations are loaded here -->
                            <div class="direct-chat-messages" id="chat">
                            <!-- Message. Default to the left -->
                              
                              <!-- /.direct-chat-msg -->

                              <!-- Message to the right -->
                              <%--<div class="direct-chat-msg right">
                                  <div class="direct-chat-infos clearfix">
                                    <span class="direct-chat-name float-right">Sarah Bullock</span>
                                    <span class="direct-chat-timestamp float-left">23 Jan 2:05 pm</span>
                                  </div>
                                  <!-- /.direct-chat-infos -->
                                  <img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
                                  <!-- /.direct-chat-img -->
                                  <div class="direct-chat-text">
                                    You better believe it!
                                  </div>
                                  <!-- /.direct-chat-text -->
                              </div>--%>
                              <!-- /.direct-chat-msg -->

                              <!-- Message. Default to the left -->
                              <%--<div class="direct-chat-msg">
                                <div class="direct-chat-infos clearfix">
                                  <span class="direct-chat-name float-left">Alexander Pierce</span>
                                  <span class="direct-chat-timestamp float-right">23 Jan 5:37 pm</span>
                                </div>
                                <!-- /.direct-chat-infos -->
                                <img class="direct-chat-img" src="dist/img/user1-128x128.jpg" alt="message user image">
                                <!-- /.direct-chat-img -->
                                <div class="direct-chat-text">
                                  Working with AdminLTE on a great new app! Wanna join?
                                </div>
                              <!-- /.direct-chat-text -->
                            </div>--%>
                              <!-- /.direct-chat-msg -->

                              <!-- Message to the right -->
                              <%--<div class="direct-chat-msg right">
                    <div class="direct-chat-infos clearfix">
                      <span class="direct-chat-name float-right">Sarah Bullock</span>
                      <span class="direct-chat-timestamp float-left">23 Jan 6:10 pm</span>
                    </div>
                    <!-- /.direct-chat-infos -->
                    <img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
                    <!-- /.direct-chat-img -->
                    <div class="direct-chat-text">
                      I would love to.
                    </div>
                    <!-- /.direct-chat-text -->
                  </div>--%>
                              <!-- /.direct-chat-msg -->
                              </div>
                            </div>
                          <div class="card-footer">
                              <div class="input-group">
                                <input type="text" name="message" placeholder="Type Message ..." class="form-control" runat="server" id="t_chat">
                                <span class="input-group-append">
                                  <button  id="btnChat" type="button" class="btn btn-warning" onclick = "AddChat();"><i class="fas fa-plus" ></i> &nbsp; Send</button>
                                </span>
                              </div>
                          </div>
                        </div>  
                      </ContentTemplate>
                    </asp:UpdatePanel>
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

