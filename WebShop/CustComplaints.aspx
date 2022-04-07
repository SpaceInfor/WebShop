<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="CustComplaints.aspx.cs" Inherits="WebShop.CustComplaints" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

    <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
    <!-- Font Awesome -->

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <script type="text/javascript">
      function link() {
        var comp_id = $('#t_cono_id').text();

        if (comp_id != "") {
          var val = $('#t_cono_id').text();

          //var link = document.getElementById("btnAddAttachment");
          //  link.setAttribute('href', 'CompFileUpload.aspx' + '?t_cono=' + val);
          var left = (screen.width - 800) / 2;
          var top = (screen.height - 400) / 4;
          childWindow = open("CompFileUpload.aspx?t_cono=" + val, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);

        }
        else {
          toastr.error('Please Save Complaint First!');
        }
      }
    </script>


    <script type="text/javascript">
      function SoAttachmentlink() {
        var val = document.getElementById('t_worn').value;

        //var link = document.getElementById("btnAddAttachment");
        //  link.setAttribute('href', 'CompFileUpload.aspx' + '?t_cono=' + val);
        var left = (screen.width - 800) / 2;
        var top = (screen.height - 400) / 4;
        childWindow = open("CustFileUpload.aspx?ORD=" + val, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);

      }
    </script>
    <%--    <script language="javascript">
      var ctrl
      function openChild(control, form) {
        ctrl = control
        frm = form + ".aspx?param1=" + document.getElementById("t_dtyp").value.toString();
        var left = (screen.width - 800) / 2;
        var top = (screen.height - 400) / 4;
        childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
      }
      function setValue(myVal) {
        document.getElementById(ctrl).value = myVal;
        $(document).ready(function () {
          document.getElementById(ctrl).onchange();

        });
      }
      Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
  </script>--%>
    <!-- Theme style -->
    <script type="text/javascript">
      $(document).ready(function () {

        const urlParams = new URLSearchParams(window.location.search);
        //const myParam = urlParams.get('t_stat');
        const t_cono_code = urlParams.get('t_cono');
        const t_worn_code = urlParams.get('t_worn');

        if (t_worn_code != null) {
          document.getElementById("t_worn").value = t_worn_code;
          Bind_CPS_Details();
        }

        if (t_cono_code != null) {
          debugger
          Bind_Complaint_Details(t_cono_code);
          debugger
          Bind_Complaint_Lines(t_cono_code);
          $("#btnUpdate").attr("onclick", "AddInput('U')");

        }
        else {

          var t_worn_txt = document.getElementById("t_worn");
          t_worn_txt.disabled = false;

          var t_comt_txt = document.getElementById("t_comt");
          t_comt_txt.disabled = false;

          var t_prio_txt = document.getElementById("t_prio");
          t_prio_txt.disabled = false;

          var addbtn = document.getElementById("btnAddLine");
          //attbtn.disabled = false;
          addbtn.setAttribute('disabled', "disabled");
        }


      });
    </script>

    <script language="javascript">
      var ctrl
      function openChild(control, form) {
        ctrl = control
        frm = form + ".aspx?param1=";
        var left = (screen.width - 800) / 2;
        var top = (screen.height - 400) / 4;
        childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
      }
      function setValue(myVal) {
        document.getElementById(ctrl).value = myVal;
        $(document).ready(function () {
          document.getElementById(ctrl).onchange();
        });
      }
      Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    </script>


    <script type="text/javascript">
      function AddComplaintLines() {
        debugger
        var comp_id = $('#t_cono_id').text();
        $.ajax(
          {
            type: "POST",
            url: "CustComplaints.aspx/SaveComplaintLine",
            data: '{t_cono: "' + comp_id + '",t_rsol: "' + document.getElementById('t_rsol_text').value + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: GetComplaintLineData,
            failure: function (response) {
              alert(response.d);
            }
          });
      }

      function GetComplaintLineData(response) {
        debugger
        var t_comp = response.d[0].toString();

        debugger
        if (response.d[0].toString().trim() == 'ERROR') {
          toastr.error(response.d[0].toString());
        }
        else {
          toastr.success('Complaint updated successfully');
          $('#modal-default').modal('hide');
        }
        Bind_Complaint_Lines($('#t_cono_id').text())
      }
    </script>

    <script type="text/javascript">
      debugger
      function Bind_CPS_Details() {
        debugger
        var t_worn_code = document.getElementById("t_worn").value;
        $.ajax(
          {
            type: "POST",
            url: "CustComplaints.aspx/Bind_CPS_Details",
            data: '{t_worn_code: "' + t_worn_code + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
              debugger
              if (response.d != '') {
                var dorn = JSON.parse(response.d);
                $('#t_cono_id').html(dorn.t_cono);

                document.getElementById("t_orno").value = dorn.t_orno;
                document.getElementById("t_bpid").value = dorn.t_bpid;
                document.getElementById("t_nama").value = dorn.t_nama;

              }
              else {
                //$('#lblt_ofbp').html('no datafound');
              }
            },
            error: function (response) {
              alert(response.responseText);
            }
          });
      }
    </script>
    <script type="text/javascript">

      function Bind_Complaint_Details(t_cono_code) {
        $.ajax(
        {
          type: "POST",
          url: "CustComplaints.aspx/GetComplaintData",
          data: '{t_cono: "' + t_cono_code + '" }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {
            debugger
            if (response.d != '') {
              var dorn = JSON.parse(response.d);
              $('#t_cono_id').html(dorn.t_cono);
              debugger
              document.getElementById("t_worn").value = dorn.t_worn;
              document.getElementById("t_orno").value = dorn.t_orno;
              document.getElementById("t_bpid").value = dorn.t_bpid;
              document.getElementById("t_nama").value = dorn.t_nama;
              document.getElementById("t_comt").value = dorn.t_comt;
              document.getElementById("t_prio").value = dorn.t_prio;
              document.getElementById("t_cost").value = dorn.t_cost;
              document.getElementById("t_rsol").value = dorn.t_rsol;

              if (dorn.t_cost == 3) {
                var t_worn_txt = document.getElementById("t_worn");
                t_worn_txt.disabled = true;


                var t_comt_txt = document.getElementById("t_comt");
                t_comt_txt.disabled = true;

                var t_prio_txt = document.getElementById("t_prio");
                t_prio_txt.disabled = true;
                $("#btnUpdate").prop("disabled", true);
                $("#btnAddLine").prop("disabled", true);
                $("#attachment").prop("disabled", true);
              }
              else
                if (dorn.t_cost == 2) {
                  //$('#btnAckn').prop(disabled) = true;
                  var btnAckn = document.getElementById("btnAckn");
                  //attbtn.disabled = false;
                  btnAckn.setAttribute('disabled', "disabled");
                }
                else {
                  var t_rsol_txt = document.getElementById("t_rsol");
                  t_rsol_txt.disabled = false;
                }

            }
            else {
              //$('#lblt_ofbp').html('no datafound');
            }
          },
          error: function (response) {
            alert(response.responseText);
          }
        });
      }
    </script>

    <script type="text/javascript">
      function delete_row(t_comp_code) {

        Swal.fire({
          title: 'Do you want to delete the line?',
          showDenyButton: true,
          showCancelButton: true,
          confirmButtonText: 'Save',
          denyButtonText: `Don't save`,
        }).then((result) => {
          /* Read more about isConfirmed, isDenied below */
          if (result.isConfirmed) {
            $.ajax(
              {
                type: "POST",
                url: "CustComplaints.aspx/delete_row",
                data: '{t_comp_code: "' + t_comp_code + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: GetLineData_Delete,
                failure: function (response) {
                  alert(response.d);
                }
              });
            Swal.fire('Line is deleted!', '', 'success')
          } else if (result.isDenied) {
            Swal.fire('Line is not deleted', '', 'info')
          }
        })

      }
      function GetLineData_Delete(response) {
        debugger
        //var t_dorn = response.d[0].toString();
        //$('#t_dorn_id').html(t_dorn);
        Bind_Complaint_Lines();
      }
    </script>


    <script type="text/javascript">
      function AddInput(flag) {
        debugger
        var stat = "1";

        var comp_id = $('#t_cono_id').text();
        if (comp_id == "") {
          flag = "I";
        }
        else {
          flag = "U";
        }

        if (document.getElementById('t_orno').value == '') {
          alert('Please Select Correct CPS Order');
          return;
        }

        $.ajax(
        {
          type: "POST",
          url: "CustComplaints.aspx/SaveComplaint",
          data: '{t_cono:"' + comp_id + '",t_worn: "' + document.getElementById('t_worn').value + '",t_orno: "' + document.getElementById('t_orno').value + '",t_prbp: "' + document.getElementById('t_bpid').value + '",t_comt: "' + document.getElementById('t_comt').value + '",t_rsol: "",t_prio: "' + document.getElementById('t_prio').value + '",t_cost: "' + stat + '",t_flag:"' + flag + '"}',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: GetLineData,
          failure: function (response) {
            alert(response.d);
          }
        });
      }

      function GetLineData(response) {
        debugger
        var t_dorn = response.d[0].toString();
        Bind_Complaint_Lines();

        $('#t_cono_id').html(t_dorn);


        debugger
        if (response.d[1].toString().trim() == 'ERROR') {
          toastr.error(response.d[1].toString());
        }
        else {
          if (response.d[1].toString().trim() == 'ADDED') {
            toastr.success('Complaint added successfully');
          }
          else {
            toastr.success('Complaint updated successfully');
          }
          var addbtn = document.getElementById("btnAddLine");
          attbtn.disabled = false;
          $("#btnUpdate").attr("onclick", "AddInput('U')");
          //addbtn.setAttribute('disabled', "disabled");
          // document.getElementsByTagName("btnAddLine").removeAttribute("disabled");
        }
      }
    </script>

    <%--     <script type = "text/javascript">
       function AddComplaintLines() {
         debugger
         var comp_id = $('#t_cono_id').text();
         $.ajax(
           {
             type: "POST",
             url: "CustComplaints.aspx/SaveComplaintLine",
             data: '{t_cono: "' + comp_id + '",t_rsol: "' + document.getElementById('t_rsol_text').value + '"}',
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: GetComplaintLineData,
             failure: function (response) {
               alert(response.d);
             }
           });
       }
       function GetComplaintLineData(response) {
         debugger
         var t_comp = response.d[0].toString();

         debugger
         if (response.d[0].toString().trim() == 'ERROR') {
           toastr.error(response.d[0].toString());
         }
         else {
           toastr.success('Complaint updated successfully');
           $('#modal-default').modal('hide');
         }
         Bind_Complaint_Lines($('#t_cono_id').text())
       }
    </script>--%>

    <script type="text/javascript">
      function Bind_Complaint_Lines(t_cono) {
        debugger
        $.ajax(
          {
            type: "POST",
            url: "CustComplaints.aspx/GetComplaintLines",
            data: '{t_cono_code: "' + t_cono + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: BindComplaintLinesTable,
            failure: function (response) {
              alert(response.d);
            },
            error: function (response) {
              alert(response.d);
            }
          });
      }
      function BindComplaintLinesTable(response) {
        debugger
        $("#example1").DataTable(
          {
            destroy: true,
            "responsive": true, "lengthChange": true, "autoWidth": false,
            "deferRender": true, "paging": true,
            "buttons": ["csv", "excel", "print", "colvis"],
            data: response.d,
            columns: [
              { 'data': 't_pono', 'title': 'Position' },
              { 'data': 't_date', 'title': 'Update Date' },
              { 'data': 't_rsol', 'title': 'Update Text' },
              { 'data': 't_user', 'title': 'User' }
              //{ 'data': null, title: 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_cono + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },
            ]
          }).buttons().container().appendTo('#example1_wrapper .col-lg-6:eq(0)');;
      };
    </script>


</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ct1" runat="server">

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Customer Complaints</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="CustComplaintList.aspx">Customer Complaint List</a></li>
                        <li class="breadcrumb-item active">Customer Complaint</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Complaint Form</h3>
                        <div class="card-tools">
                            <span class="badge badge-warning">Complaint ID :</span>&nbsp; <span class="float-right username">
                                <label id="t_cono_id"></label>
                            </span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <label>CPS Order</label>
                                    <div class="input-group">
                                        <input type="text" id="t_worn" class="form-control" onchange="Bind_CPS_Details()">
                                        <div class="input-group-append">
                                            <button id="btncprj" type="button" class="btn btn-block btn-warning" onclick="openChild('t_worn','HelpPages/tdtst1552m000')"><i class="fa fa-fw fa-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <label>Sales Order No</label>
                                    <input type="text" class="form-control" id="t_orno" disabled>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Branch</label>
                                    <input type="text" class="form-control" id="t_bpid" disabled>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <label>Branch Name</label>
                                    <input type="text" class="form-control" id="t_nama" disabled>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <label>Status</label>
                                    <select class="form-control" id="t_cost" disabled>
                                        <option value="1">Open</option>
                                        <option value="2">In Process</option>
                                        <option value="3">Closed</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-1">
                                <div class="form-group">
                                    <label>Severity</label>
                                    <select class="form-control" id="t_prio" disabled>
                                        <option value="4">High</option>
                                        <option value="5">Medium</option>
                                        <option value="6">Low</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Complaint Text</label>
                                    <textarea rows="5" class="form-control" id="t_comt"></textarea>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Complaint Closure Update</label>
                                    <textarea rows="5" class="form-control" placeholder="Enter Final Complaint Text" id="t_rsol" disabled></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-warning waves-effect" onclick="AddInput('I')" id="btnUpdate"><i class="fas fa-save"></i>Save Complaint</button>

                        <button type="button" class="btn btn-warning waves-effect" id="btnAddLine" data-toggle="modal" data-target="#modal-default"><i class="fas fa-plus"></i>Add Update</button>

                        <button class="btn btn-warning waves-effect" id="attachment" onclick="link()"><i class="fas fa-paperclip"></i>Add/View Attachment</button>
                        <button class="btn btn-warning waves-effect" id="SoAttachment" onclick="SoAttachmentlink()"><i class="fas fa-paperclip"></i>View CPS Attachments</button>

                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-door-open"></i>Complaints
                        </h3>
                        <div class="card-tools">
                        </div>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table id="example1" class="table table-bordered table-striped ">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="modal fade" id="modal-default">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add Update to Complaint</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-door-open"></i>Complaint Updates
                            </h3>
                            <div class="card-tools">
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="col-md-8  ">
                                <div class="form-group">
                                    <label>Complaint Redressal</label>
                                    <textarea rows="5" class="form-control" placeholder="Enter Complaint Redressal" id="t_rsol_text"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-warning" onclick="AddComplaintLines();">Save changes</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <script>
      $(function () {
        bsCustomFileInput.init();
      });
    </script>
    <script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
    <!-- jQuery -->

    <!-- Page specific script -->

    <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->

    <!-- Bootstrap4 Duallistbox -->
    <script src="../../plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <script src="../../plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="../../plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="../../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Bootstrap Switch -->
    <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <!-- BS-Stepper -->
    <script src="../../plugins/bs-stepper/js/bs-stepper.min.js"></script>
    <!-- dropzonejs -->
    <script src="../../plugins/dropzone/min/dropzone.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../../dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <%--<script src="../../dist/js/demo.js"></script>--%>
    <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>

    <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    <script src="../../plugins/jszip/jszip.min.js"></script>
    <script src="../../plugins/pdfmake/pdfmake.min.js"></script>
    <script src="../../plugins/pdfmake/vfs_fonts.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>



</asp:Content>
