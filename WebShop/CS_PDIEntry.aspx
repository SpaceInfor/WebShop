<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CS_PDIEntry.aspx.cs" Inherits="AdminMaster.CS_PDIEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CS PDI Entry</title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Theme style -->

    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

    <%--<script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

    <script type="text/javascript">
      function clearTextBox() {

        $("#t_rmrk").val('');
        $("#t_stat").val('');

        $("#btnAdd").attr("onclick", "AddInput('I')");
        $("#btnAdd").attr("value", "Add");

        $('#CSPDIModal').modal('show');

        //if (t_orno != null) {

        //  document.getElementById("t_orno").value = t_orno;
        //    GetRouting(t_opro);
        //}
      }
   </script>
    <script type="text/javascript">
      var userid = '';
      var t_orno;
      t_orno = '';
      $(document).ready(function () {
        debugger
        var url_string = window.location.href; //window.location.href
        var url = new URL(url_string);
        t_orno = url.searchParams.get("t_orno");
        userid = '<%= Session["t_usid"] %>';
        $("#t_orno").html(t_orno);


        debugger

        if (t_orno != null) {

          Bind_PID_IdWise();
        }
        else {
          Bind_PID_IdWise_Headers();
        }

      });

      function Bind_PID_IdWise() {

        $.ajax({

          type: "POST",
          url: "CS_PDIEntry.aspx/ListPIDIdWise",
          data: '{t_orno :"' + t_orno + '"}',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {

            if (response.d.length === 0) {

              $('#CSPDIModal').modal('show');
              $("#t_orno").html(t_orno);
              //GetRouting(t_opro);
            }
            else {


              var datatableVariable = $('#tblPDIDetails').DataTable({
                "responsive": true, "lengthChange": false, "autoWidth": true,
                "buttons": ["excel", "pdf", "print"],
                "bDestroy": true,

                //"lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]],
                data: response.d,
                columns: [

                    { "data": "t_orno", "title": "Sales Order" },
                    { "data": "t_pdiu", "title": "PDI Date" },
                    { "data": "t_pdid", "title": "PDI Remarks" },
                    { "data": "t_pdim", "title": "PDI Login" },
                    { "data": "t_pdst", "title": "Status" },

                    { 'data': null, title: 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="Bind_Operation_Lines(' + "'" + item.t_opro + "'," + item.t_seqn + "" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },



                ]
              }).buttons().container().appendTo('#tblPDIDetails_wrapper .col-md-6:eq(0)');

            }

          }
        });
      };

    </script>
    <script type="text/javascript">
      function Bind_PID_IdWise_Headers() {

        $.ajax({

          type: "POST",
          url: "CS_PDIEntry.aspx/GetPIDDetails",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {

            var datatableVariable = $('#tblPDIDetails').DataTable({
              "responsive": true, "lengthChange": false, "autoWidth": true,
              "buttons": ["excel", "pdf", "print"],
              "bDestroy": true,

              //"lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]],
              data: response.d,
              columns: [

                      { "data": "t_orno", "title": "Sales Order" },
                      { "data": "t_pdiu", "title": "PDI Date" },
                      { "data": "t_pdid", "title": "PDI Remarks" },
                      { "data": "t_pdim", "title": "PDI Login" },
                      //{ "data": "t_pdst", "title": "Status" },
                      {

                        data: null, "title": "Status", render: function (data, type, row, meta) {
                          var PDIStatus = "";
                          if (row.t_pdst == 1) {
                            PDIStatus = "Pending";
                            return '<div' + PDIStatus + '" class="badge bg-warning">' + PDIStatus + '</div>';
                          }
                          else if (row.t_pdst == 2) {
                            PDIStatus = "Hold";
                            return '<div' + PDIStatus + '" class="badge bg-success">' + PDIStatus + '</div>';
                          }

                        }
                      },

                      { 'data': null, title: 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="Bind_Operation_Lines(' + "'" + item.t_opro + "'," + item.t_seqn + "" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },



              ]
            }).buttons().container().appendTo('#tblPDIDetails_wrapper .col-md-6:eq(0)');

          }
        });
      };
   </script>
    <script type="text/javascript">
      function AddInput(t_flag) {
        debugger
        var res = validate();
        if (res == false) {
          return false;
        }
        userid = '<%= Session["t_usid"] %>';
        //var t_orno = $("#t_orno").html();
        var t_orno = 'REG235407';
        if (t_flag == 'I') {
          $.ajax(
              {
                type: "POST",
                url: "CS_PDIEntry.aspx/saveInputPDI",

                data: '{t_orno: "' + t_orno + '",t_pdiu: "' + userid + '",t_pdim: "' + document.getElementById('t_pdim').value + '",t_pdst: "' + document.getElementById('t_pdst').value + '",t_flag:"' + t_flag + '"}',

                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //success: GetLineData,
                success: function (response) {
                  if (response.d[0].toString() === "success") {
                    $('#CSPDIModal').modal('hide');

                    $('#t_pdim').focus();
                    $("#btnAdd").attr("onclick", "AddInput('I',0)");
                    $("#btnAdd").attr("value", "Add");
                    //Bind_Input1_Lines(t_tano);
                    Bind_PID_IdWise_Headers();
                    toastr.success('Record added successfully');
                  }
                  else {
                    toastr.warning(response.d[0].toString());

                  }
                },
                failure: function (response) {
                  alert(response.d);
                }
              });
        }
        //else if (Action == 'U') {
        //    var t_opro = $("#t_opro").val();
        //    $.ajax(
        //        {
        //            type: "POST",
        //            url: "OperationSequence.aspx/UpdateInputOperation",
        //            //data: '{t_opro: "' + t_opro + '",t_tano: "' + document.getElementById('t_tano').value + '",t_opno: "' + document.getElementById('t_opno').value + '",t_seqn: "' + document.getElementById('t_seqn').value + '",t_ostp: "' + document.getElementById('t_ostp').value + '",t_dsca: "' + document.getElementById('t_dsca').value + '",t_cowc: "' + document.getElementById('t_cowc').value + '",Action:"' + Action + '"}',
        //            data: '{t_opro: "' + t_opro + '",t_tano: "' + document.getElementById('t_tano').value + '",t_opno: "' + document.getElementById('t_opno').value + '",t_seqn: "' + document.getElementById('t_seqn').value + '",t_ostp: "' + t_ostp + '",t_dsca: "' + t_dsca + '",t_cowc: "' + document.getElementById('t_cowc').value + '",Action:"' + Action + '"}',
        //            //,t_opno: "' + document.getElementById('t_opno').value + '",t_seqn: "' + document.getElementById('t_seqn').value + '",t_ostp: "' + document.getElementById('t_ostp').value + '"
        //            contentType: "application/json; charset=utf-8",
        //            dataType: "json",
        //            //success: GetLineData,
        //            success: function (response) {
        //                if (response.d[0].toString() === "SUCCESS") {
        //                    $('#OperationModal').modal('hide');
        //                    $('#t_opro').val("");
        //                    $('#t_tano').val("");
        //                    $('#t_dsca').val("");
        //                    $('#t_cowc').val("");
        //                    $('#t_opno').val("");
        //                    $('#t_seqn').val("");
        //                    $('#t_ostp').val("");



        //                    $('#t_opro').focus();
        //                    $("#btnAdd").attr("onclick", "AddInput('I',0)");
        //                    $("#btnAdd").attr("value", "Add");
        //                    //Bind_Input1_Lines(t_tano);
        //                    Bind_Opearation_Headers();
        //                    toastr.success('Record updated successfully');
        //                }
        //                else {
        //                    toastr.warning(response.d[0].toString());

        //                }
        //            },
        //            failure: function (response) {
        //                alert(response.d);
        //            }
        //        });
        //}

      }
      function validate() {

        var isValid = true;
        if ($('#t_rmrk').val() == "") {
          $('#t_rmrk').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_rmrk').css('border-color', 'lightgrey');
        }
        if ($("#t_pdst option:selected").text() == "--Select--") {
          $('#t_pdst').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_pdst').css('border-color', 'lightgrey');
        }

        return isValid;
      }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">

            <div class="block-header">
                <h2>PDI Entry</h2>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content-header">
        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card card-warning card-outline">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-table"></i>&nbsp;PDI Entry List</h3>
                                <div class="card-tools">

                                    <a class="btn btn-block bg-gradient-warning" data-toggle="modal" data-target="#CSPDIModal" onclick="clearTextBox();">
                                        <%-- href="InputProcess.aspx"--%>
                                        <i class="fa fa-fw fa-plus-circle"></i>Add
                                    </a>
                                </div>
                            </div>
                            <div class="card-body table-responsive p-0">
                                <table id="tblPDIDetails" class="table table-bordered table-striped ">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="modal fade" id="CSPDIModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg card card-secondary" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">
                                            <i class="fas fa-drafting-compass"></i>PDI Details

                                        </h3>

                                        <div class="card-tools">
                                        </div>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>

                                        </button>
                                    </div>



                                    <div class="modal-body">
                                        <div class="row">
                                            <h3 class="card-title"><span class="badge badge-warning">Sales Order No. :</span>&nbsp;
                                           <span class="float-right username">
                                                 <label id="t_orno"></label>
                                           </span>
                                            </h3>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>Remark</label>
                                                    <input type="text" class="form-control" placeholder="Enter Remark" id="t_pdim">
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <select class="custom-select rounded-0" data-dropdown-css-class="select2-danger" style="width: 100%;" id="t_pdst">
                                                        <%--  <option value="1">Pending</option>--%>
                                                        <option value="1">Hold</option>
                                                        <option value="2">Approved</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="modal-footer">

                                        <input type="button" class="btn btn-warning waves-effect" onclick="AddInput('I')" id="btnAdd" value="Add" />
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>


                <!-- /.row -->
            </div>
        </section>
    </section>


    <%--<script src="../../formjs/ValidationJS.js"></script>--%>
    <!-- /.container-fluid -->
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>

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
    <%-- <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>--%>
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
