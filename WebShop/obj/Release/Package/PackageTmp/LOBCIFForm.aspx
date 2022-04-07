<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCIF.Master" AutoEventWireup="true" CodeBehind="LOBCIFForm.aspx.cs" Inherits="AdminCIF.LOBCIFForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- daterange picker -->
    <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="../../plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- Bootstrap4 Duallistbox -->
    <link rel="stylesheet" href="../../plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">
    <!-- BS Stepper -->
    <link rel="stylesheet" href="../../plugins/bs-stepper/css/bs-stepper.min.css">
    <!-- dropzonejs -->
    <link rel="stylesheet" href="../../plugins/dropzone/min/dropzone.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker.css">
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>

    <script language="javascript">
        var username = '';
        var ctrl
        function openChild(control, form) {
            ctrl = control
            frm = form + ".aspx?param1=" + username + "";
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

    </script>
    <script type="text/javascript">
        function GetCountry() {

            var t_ccty = $("#t_ccty").val();

            $.ajax({
                url: "LOBCIFForm.aspx/GetCountryName",
                data: '{t_ccty :"' + t_ccty + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_ccty_desc").html("");
                        $("#t_ccty").val("");

                    }
                    else {
                        $("#t_ccty_desc").html(response.d[0].t_dsca);
                        $("#t_ccty_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;

        }
        function ShippingGetCountry() {

            var t_cntr = $("#t_cntr").val();

            $.ajax({
                url: "LOBCIFForm.aspx/GetShippingCountryName",
                data: '{t_ccty :"' + t_cntr + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_cntr_desc").html("");
                        $("#t_cntr").val("");

                    }
                    else {
                        $("#t_cntr_desc").html(response.d[0].t_dsca);
                        $("#t_cntr_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;

        }
   </script>

    <script type="text/javascript">
        function GetState() {
            var t_cste = $("#t_cste").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetStateName",
                data: '{t_cste :"' + t_cste + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_cste_desc").html("");
                        $("#t_cste").val("");
                    }
                    else {
                        $("#t_cste_desc").html(response.d[0].t_dsca);
                        $("#t_cste_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
        function ShippingGetState() {
            var t_stte = $("#t_stte").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetShippingStateName",
                data: '{t_cste :"' + t_stte + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_stte_desc").html("");
                        $("#t_stte").val("");
                    }
                    else {
                        $("#t_stte_desc").html(response.d[0].t_dsca);
                        $("#t_stte_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
   </script>

    <script type="text/javascript">
        function GetCity() {
            var t_ccit = $("#t_ccit").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetCityName",
                data: '{t_ccit :"' + t_ccit + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_ccit_desc").html("");
                        $("#t_ccit").val("");
                    }
                    else {
                        $("#t_ccit_desc").html(response.d[0].t_dsca);
                        $("#t_ccit_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
        function ShippingGetCity() {
            var t_city = $("#t_city").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetShippingCityName",
                data: '{t_ccit :"' + t_city + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_city_desc").html("");
                        $("#t_city").val("");
                    }
                    else {
                        $("#t_city_desc").html(response.d[0].t_dsca);
                        $("#t_city_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }
   </script>

    <script type="text/javascript">
        function GetChannel() {
            var t_chan = $("#t_chan").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetChannelName",
                data: '{t_chan :"' + t_chan + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_chan_desc").html("");
                        $("#t_chan").val("");
                    }
                    else {
                        $("#t_chan_desc").html(response.d[0].t_dsca);
                        $("#t_chan_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

        function GetPaymentTerms() {
            var t_cpay = $("#t_cpay").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetPaymentTermsName",
                data: '{t_cpay :"' + t_cpay + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_cpay_desc").html("");
                        $("#t_cpay").val("");
                    }
                    else {
                        $("#t_cpay_desc").html(response.d[0].t_dsca);
                        $("#t_cpay_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

        function GetPaymentMode() {
            var t_paym = $("#t_paym").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetPaymentModeName",
                data: '{t_paym :"' + t_paym + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_paym_desc").html("");
                        $("#t_paym").val("");
                    }
                    else {
                        $("#t_paym_desc").html(response.d[0].t_desc);
                        $("#t_paym_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

        function GetSaleSegment() {
            var t_sals = $("#t_sals").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetSalesSegment",
                data: '{t_cbrn :"' + t_sals + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_sals_desc").html("");
                        $("#t_sals").val("");
                    }
                    else {
                        $("#t_sals_desc").html(response.d[0].t_dsca);
                        $("#t_sals_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

        function GetDHCollResponsible() {
            var t_crep = $("#t_crep").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetInternalCollResponsible",
                data: '{t_crep :"' + t_crep + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_crep_desc").html("");
                        $("#t_crep").val("");
                    }
                    else {
                        $("#t_crep_desc").html(response.d[0].t_nama);
                        $("#t_crep_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

        function GetSalesCollResponsible() {
            var t_osrp = $("#t_osrp").val();
            $.ajax({
                url: "LOBCIFForm.aspx/GetExternalCollResponsible",
                data: '{t_osrp :"' + t_osrp + '"}',
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (response) {

                    if (response.d.length === 0) {
                        $("#t_osrp_desc").html("");
                        $("#t_osrp").val("");
                    }
                    else {
                        $("#t_osrp_desc").html(response.d[0].t_nama);
                        $("#t_osrp_desc").css('display', 'block');

                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

    </script>

    <script type="text/javascript">
        function GetProductBrand() {

            var t_cbrn = '';
            t_cbrn = $("#t_cbrn option:selected").val();
            if (t_cbrn != "--Select--") {
                //Add Product
                $.ajax({
                    type: "POST",
                    url: "LOBCIFForm.aspx/GetProduct",
                    data: '{t_cbrn:"' + t_cbrn + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response != null) {

                            $("#t_prod").empty();
                            ////$("#t_prod").append($("<option></option>").val("0").html("Select Shift"));
                            //$.each(response.d, function (data, value) {
                            //    $("#t_prod").append($("<option></option>").val(value.t_pdid).html(value.t_item));

                            //})
                            var ddlProduct = $("#t_prod");
                            //ddlProduct.empty().append('<option selected="selected" value="0">Please select</option>');
                            $.each(response.d, function () {
                                ddlProduct.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });


                        }
                        //else {
                        //    $("#t_prod").empty();
                        //    $("#t_prod").append($("<option disabled></option>").val(0).html("--Select--"));
                        //}
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
                //Add Brand
                $.ajax({
                    type: "POST",
                    url: "LOBCIFForm.aspx/GetBrand",
                    data: '{t_cbrn :"' + t_cbrn + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response != null) {
                            //alert(0);
                            $("#t_brnd").empty();
                            ////$("#t_prod").append($("<option></option>").val("0").html("Select Shift"));
                            //$.each(response.d, function (data, value) {
                            //    $("#t_brnd").append($("<option></option>").val(value.t_brid).html(value.t_brnd));
                            //})
                            var ddlBrand = $("#t_brnd");
                            //ddlProduct.empty().append('<option selected="selected" value="0">Please select</option>');
                            $.each(response.d, function () {
                                ddlBrand.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });
                        }
                        //else {
                        //    $("#t_brnd").empty();
                        //    $("#t_brnd").append($("<option disabled></option>").val(0).html("--Select--"));
                        //}
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            if (t_cbrn == 1) {
                $("#finiDisplayeddiv").css('display', 'none');
            }
            else {
                $("#finiDisplayeddiv").css('display', 'block');
            }

        }
        function GetProductBrandEdit(_t_prod, _t_brnd) {

            var t_cbrn = '';
            t_cbrn = $("#t_cbrn option:selected").val();
            if (t_cbrn != "--Select--") {
                //Add Product
                $.ajax({
                    type: "POST",
                    url: "LOBCIFForm.aspx/GetProduct",
                    data: '{t_cbrn:"' + t_cbrn + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response != null) {

                            $("#t_prod").empty();

                            var ddlProduct = $("#t_prod");
                            //ddlProduct.empty().append('<option selected="selected" value="0">Please select</option>');
                            $.each(response.d, function () {
                                ddlProduct.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });
                            $('#t_prod').val(_t_prod.toString().split(',')).trigger('change');

                        }

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
                //Add Brand
                $.ajax({
                    type: "POST",
                    url: "LOBCIFForm.aspx/GetBrand",
                    data: '{t_cbrn :"' + t_cbrn + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response != null) {
                            $("#t_brnd").empty();

                            var ddlBrand = $("#t_brnd");
                            //ddlProduct.empty().append('<option selected="selected" value="0">Please select</option>');
                            $.each(response.d, function () {
                                ddlBrand.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });
                        }

                        $('#t_brnd').val(_t_brnd.toString().split(',')).trigger('change');

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            if (t_cbrn == 1) {
                $("#finiDisplayeddiv").css('display', 'none');
            }
            else {
                $("#finiDisplayeddiv").css('display', 'block');
            }

        }
    </script>

    <script type="text/javascript">
        var t_bpid = '';
        var userid = '';
        $(document).ready(function () {

            $('#t_cbrn').focus();
            const urlParams = new URLSearchParams(window.location.search);
            const t_bpid = urlParams.get('t_bpid');
           <%-- userid = '<%= Session["t_usid"] %>';--%>
            if (t_bpid != null) {

                $("#t_bpid_id").html(t_bpid);
                Bind_CIFForm_Lines(t_bpid);

            }
            GetProductBrand();

        });
    </script>

    <script type="text/javascript">
        //function Bind_CIFFormDetails() {

        //    $.ajax({

        //        type: "POST",
        //        url: "LOBCIFForm.aspx/BindCIFForm",
        //        //data: '{t_bkno:"' + t_bkno + '"}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        processData: false,
        //        success: function (data) {

        //            var datatableVariable = $('#tblCIFFormdetails').DataTable({

        //                "responsive": true, "lengthChange": false, "autoWidth": true,
        //                "buttons": ["excel", "pdf", "print"],
        //                "bDestroy": true,

        //                data: data.d,
        //                columns: [
        //                    { "data": "t_bpid", "title": "Customer Id" },
        //                    { "data": "t_nama", "title": "Customer Name" },
        //                    //{ "data": "t_cbrn", "title": "LOB Line" },
        //                    {

        //                        data: null, "title": "LOB Line", render: function (data, type, row, meta) {
        //                            var LOBStatus = "";
        //                            if (row.t_cbrn == 1) {
        //                                LOBStatus = "Home";
        //                                return '<div' + LOBStatus + '" class="badge bg-success">' + LOBStatus + '</div>';
        //                            }
        //                            else {
        //                                LOBStatus = "Kitchen";
        //                                return '<div' + LOBStatus + '" class="badge bg-warning">' + LOBStatus + '</div>';
        //                            }

        //                        }
        //                    },
        //                    { "data": "t_phne", "title": "Phone" },
        //                    { "data": "t_mail", "title": "E-Mail" },
        //                    { "data": "t_chan", "title": "Channel" },
        //                    { "data": "t_ln01", "title": "Billing Address 1" },
        //                    { "data": "t_ln02", "title": "Billing Address 2" },
        //                    { "data": "t_ccty", "title": "Billing Country code" },
        //                    { "data": "t_cctydesc", "title": "Billing Country" },
        //                    { "data": "t_cste", "title": "Billing State code" },
        //                    { "data": "t_cstedesc", "title": "Billing State" },
        //                    { "data": "t_ccit", "title": "Billing City code" },
        //                    { "data": "t_ccitdesc", "title": "Billing City" },
        //                    { "data": "t_pstc", "title": "Billing Pin Code" },
        //                    { "data": "t_bgst", "title": "Billing GST" },
        //                    { "data": "t_panu", "title": "PAN Number" },
        //                    { "data": "t_badd", "title": "Shipping  Address 1" },
        //                    { "data": "t_sadd", "title": "Shipping Address 2" },
        //                    { "data": "t_cntr", "title": "Shipping Country code" },
        //                    { "data": "t_cntrdesc", "title": "Shipping Country" },
        //                    { "data": "t_stte", "title": "Shipping State code" },
        //                    { "data": "t_sttedesc", "title": "Shipping State" },
        //                    { "data": "t_city", "title": "Shipping City code" },
        //                    { "data": "t_citydesc", "title": "Shipping City" },
        //                    { "data": "t_spin", "title": "Shipping Pin Code" },
        //                    { "data": "t_sgst", "title": "Shipping GST" },
        //                    { "data": "t_shsz", "title": "Showroom size" },
        //                    { "data": "t_prdd", "title": "Products Displayed" },
        //                    { "data": "t_brdd", "title": "Brands present" },
        //                    { "data": "t_find", "title": "Finishes Displayed" },
        //                    { "data": "t_swdi", "title": "Spacewood Display" },
        //                    { "data": "t_keye", "title": "Key Empolyees" },
        //                    { "data": "t_shfr", "title": "Showroom Frontage" },
        //                    { "data": "t_tofl", "title": "Total Floors" },
        //                    { "data": "t_cpay", "title": "Payment Terms" },
        //                    { "data": "t_paym", "title": "Payment Mode" },
        //                    { "data": "t_crli", "title": "Credit Limit" },
        //                    { "data": "t_cday", "title": "Credit Days" },
        //                    { "data": "t_sals", "title": "Sales Segment" },
        //                    { "data": "t_crep", "title": "DH Coll Responsible" },
        //                    { "data": "t_osrp", "title": "Sales Coll Responsible" },
        //                    { "data": "t_emsr", "title": "Email Sales Representative" },
        //                    { "data": "t_cntp", "title": "Contact Person" },
        //                    { "data": "t_namd", "title": "Name Of Director" },
        //                    { "data": "t_remk", "title": "Remark" },
        //                    { 'data': null, "title": 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" data-toggle="modal" data-target="#exampleModal" onclick="Bind_CIFForm_Lines(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
        //                    { 'data': null, "title": 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_bpid + "'" + ')" value="0" class="btn btn-danger btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } }

        //                ]

        //            }).buttons().container().appendTo('#tblCIFFormdetails_wrapper .col-md-6:eq(0)');
        //        }
        //    }
        //    );
        //}
    </script>
    <script type="text/javascript">
        function Bind_CIFForm_Lines(t_bpid) {

            $("#divLoader").show();

            $.ajax({
                type: "POST",
                url: "LOBCIFForm.aspx/GetCIFForm",
                data: '{t_bpid: "' + t_bpid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d != '') {

                        var bpidRes = (response.d);
                        $('#t_bpid_id').html(bpidRes[0].t_bpid);
                        $('#t_cbrn').val(bpidRes[0].t_cbrn);

                        document.getElementById("t_nama").value = bpidRes[0].t_nama;
                        document.getElementById("t_phne").value = bpidRes[0].t_phne;
                        document.getElementById("t_mail").value = bpidRes[0].t_mail;
                        document.getElementById("t_chan").value = bpidRes[0].t_chan;
                        document.getElementById("t_ln01").value = bpidRes[0].t_ln01;
                        document.getElementById("t_ln02").value = bpidRes[0].t_ln02;
                        document.getElementById("t_ccit").value = bpidRes[0].t_ccit;
                        document.getElementById("t_ccty").value = bpidRes[0].t_ccty;
                        document.getElementById("t_cste").value = bpidRes[0].t_cste;
                        document.getElementById("t_pstc").value = bpidRes[0].t_pstc;
                        document.getElementById("t_bgst").value = bpidRes[0].t_bgst;
                        document.getElementById("t_panu").value = bpidRes[0].t_panu;
                        document.getElementById("t_shsz").value = bpidRes[0].t_shsz;
                        GetCountry();
                        GetState();
                        GetCity();
                        var products = bpidRes[0].t_prod;
                        var brands = bpidRes[0].t_brnd;

                        GetProductBrandEdit(products, brands);

                        //document.getElementById("t_prod").value = bpidRes[0].t_prod.trigger('change');
                        //document.getElementById("t_brnd").value = bpidRes[0].t_brnd.trigger('change');
                        document.getElementById("t_find").value = bpidRes[0].t_find;
                        document.getElementById("t_swdi").value = bpidRes[0].t_swdi;
                        document.getElementById("t_keye").value = bpidRes[0].t_keye;
                        document.getElementById("t_remk").value = bpidRes[0].t_remk;


                        document.getElementById("t_sadd").value = bpidRes[0].t_sadd;
                        document.getElementById("t_badd").value = bpidRes[0].t_badd;
                        document.getElementById("t_cntr").value = bpidRes[0].t_cntr;
                        document.getElementById("t_stte").value = bpidRes[0].t_stte;
                        document.getElementById("t_city").value = bpidRes[0].t_city;
                        document.getElementById("t_spin").value = bpidRes[0].t_spin;
                        document.getElementById("t_sgst").value = bpidRes[0].t_sgst;
                        ShippingGetCountry();
                        ShippingGetState();
                        ShippingGetCity();
                        document.getElementById("t_shfr").value = bpidRes[0].t_shfr;
                        document.getElementById("t_tofl").value = bpidRes[0].t_tofl;
                        document.getElementById("t_cpay").value = bpidRes[0].t_cpay;
                        document.getElementById("t_paym").value = bpidRes[0].t_paym;
                        document.getElementById("t_crli").value = bpidRes[0].t_crli;
                        document.getElementById("t_cday").value = bpidRes[0].t_cday;
                        document.getElementById("t_sals").value = bpidRes[0].t_sals;
                        document.getElementById("t_crep").value = bpidRes[0].t_crep;
                        document.getElementById("t_osrp").value = bpidRes[0].t_osrp;
                        document.getElementById("t_emsr").value = bpidRes[0].t_emsr;
                        document.getElementById("t_cntp").value = bpidRes[0].t_cntp;
                        document.getElementById("t_namd").value = bpidRes[0].t_namd;

                        //if (bpidRes[0].t_samb == 1) {
                        //    $('#checksameasbilling').prop('checked')
                        //}
                        //else {
                        //     $('#checksameasbilling').prop('unchecked')
                        //}
                        $('.checkval').each(function (e) {
                            if (bpidRes[0].t_samb == 1) {
                                $('#checksameasbilling').prop('checked', true);
                                //$(this).attr("checked", "checked");
                            }
                            else {
                                //$(this).attr("checked", "unchecked");
                                $('#checksameasbilling').prop('checked', false);
                            }
                        });

                        document.getElementById("t_cnmo").value = bpidRes[0].t_cnmo;
                        document.getElementById("t_cnem").value = bpidRes[0].t_cnem;
                        GetChannel();
                        GetPaymentTerms();
                        GetPaymentMode();
                        GetSaleSegment();
                        GetDHCollResponsible();
                        GetSalesCollResponsible();

                        $("#btnAdd").attr("onclick", "AddInput('U')");
                        $("#btnAdd").attr("value", "Update");
                        $("#divLoader").hide();
                    }
                    else {
                        //$('#lblt_ofbp').html('no datafound');
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                    $("#divLoader").hide();
                }
            });
        }
    </script>

    <script type="text/javascript">
        function AddInput(flag) {

            <%--userid = '<%= Session["t_usid"] %>';--%>
            var res = validateHeader();
            if (res == false) {
                return false;
            }

            var t_bpid_id = $('#t_bpid_id').html();
            if (t_bpid_id != '') {
                t_bpid = t_bpid_id;
            }
            else {
                t_bpid = "";
            }
            var t_cbrn = document.getElementById("t_cbrn").value;
            var t_nama = document.getElementById("t_nama").value;;
            var t_phne = document.getElementById("t_phne").value;
            var t_mail = document.getElementById("t_mail").value;
            var t_ln01 = document.getElementById("t_ln01").value;
            var t_ln02 = document.getElementById("t_ln02").value;
            var t_ccit = document.getElementById("t_ccit").value;
            var t_ccty = document.getElementById("t_ccty").value;
            var t_cste = document.getElementById("t_cste").value;

            var t_shsz = document.getElementById("t_shsz").value;
            var t_prod = $('#t_prod').val().toString();
            var t_brnd = $('#t_brnd').val().toString();
            var t_prdd = $("#t_prod option:selected").map(function () {
                return $(this).text();
            }).get().join(',');
            var t_brdd = $("#t_brnd option:selected").map(function () {
                return $(this).text();
            }).get().join(',');

            //var t_prdd = $("#t_prod option:selected").text().split(',').toString();
            //var t_brdd = $('#t_brnd option:selected').text().split(',').toString();
            //document.getElementById("t_prod").value.toString();

            //document.getElementById("t_brnd").value.toString();

            var t_find = document.getElementById("t_find").value;
            var t_swdi = document.getElementById("t_swdi").value;
            var t_keye = document.getElementById("t_keye").value;
            var t_remk = document.getElementById("t_remk").value;

            var t_chan = document.getElementById("t_chan").value;
            var t_badd = document.getElementById("t_badd").value;
            var t_pstc = document.getElementById("t_pstc").value;
            var t_bgst = document.getElementById("t_bgst").value;
            var t_panu = document.getElementById("t_panu").value;
            var t_sadd = document.getElementById("t_sadd").value;
            var t_spin = document.getElementById("t_spin").value;
            var t_sgst = document.getElementById("t_sgst").value;
            var t_shfr = document.getElementById("t_shfr").value;
            var t_tofl = document.getElementById("t_tofl").value;
            var t_cpay = document.getElementById("t_cpay").value;
            var t_paym = document.getElementById("t_paym").value;
            var t_crli = document.getElementById("t_crli").value;
            var t_cday = document.getElementById("t_cday").value;
            var t_sals = document.getElementById("t_sals").value;
            var t_crep = document.getElementById("t_crep").value;
            var t_osrp = document.getElementById("t_osrp").value;
            var t_emsr = document.getElementById("t_emsr").value;
            var t_cntp = document.getElementById("t_cntp").value;
            var t_namd = document.getElementById("t_namd").value;
            var t_cntr = document.getElementById("t_cntr").value;
            var t_stte = document.getElementById("t_stte").value;
            var t_city = document.getElementById("t_city").value;
            let isChecked = $('#checksameasbilling').is(':checked');
            var t_crus = '<%= Session["t_usid"] %>';
            var sameasbilling = '';
            if (isChecked == true) {
                sameasbilling = 1;
            }
            else {
                sameasbilling = 2;
            }
            var t_cnmo = document.getElementById("t_cnmo").value;
            var t_cnem = document.getElementById("t_cnem").value;
            if (t_crus != "") {
                //alert(isChecked);
                //console.log(isChecked);

                Swal.fire({
                    title: 'Do you want to Save?',
                    showDenyButton: true,
                    showCancelButton: true,
                    confirmButtonText: 'Save',
                    denyButtonText: `Don't save`,
                }).then((result) => {

                    if (result.isConfirmed) {
                        //var flag = 'I';
                        $.ajax(
                            {
                                type: "POST",
                                url: "LOBCIFForm.aspx/saveLOBCIF",
                                data: '{t_bpid: "' + t_bpid + '",t_cbrn: "' + t_cbrn + '",t_nama: "' + t_nama + '",t_phne: "' + t_phne + '",t_mail: "' + t_mail + '",t_ln01: "' + t_ln01 + '",t_ln02: "' + t_ln02 + '",t_ccit:"' + t_ccit + '",t_ccty:"' + t_ccty + '",t_cste:"' + t_cste + '",t_shsz:"' + t_shsz + '",t_prod:"' + t_prod + '",t_brnd:"' + t_brnd + '",t_find:"' + t_find + '",t_swdi:"' + t_swdi + '",t_keye:"' + t_keye + '",t_remk:"' + t_remk + '",t_prdd:"' + t_prdd + '",t_brdd:"' + t_brdd + '",t_chan:"' + t_chan + '",t_badd:"' + t_badd + '",t_pstc:"' + t_pstc + '",t_bgst:"' + t_bgst + '",t_panu:"' + t_panu + '",t_sadd:"' + t_sadd + '",t_spin:"' + t_spin + '",t_sgst:"' + t_sgst + '",t_shfr:"' + t_shfr + '",t_tofl:"' + t_tofl + '",t_cpay:"' + t_cpay + '",t_paym:"' + t_paym + '",t_crli:"' + t_crli + '",t_cday:"' + t_cday + '",t_sals:"' + t_sals + '",t_crep:"' + t_crep + '",t_osrp:"' + t_osrp + '",t_emsr:"' + t_emsr + '",t_cntp:"' + t_cntp + '",t_namd:"' + t_namd + '",t_cntr:"' + t_cntr + '",t_stte:"' + t_stte + '",t_city:"' + t_city + '",t_samb:"' + sameasbilling + '",t_crus:"' + t_crus + '",t_cnmo:"' + t_cnmo + '",t_cnem:"' + t_cnem + '",t_flag:"' + flag + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: GetHeaderData,
                                failure: function (response) {
                                    alert(response.d);
                                }
                            });
                        Swal.fire('Record is Saved!', '', 'success')
                    } else if (result.isDenied) {
                        Swal.fire('Record not is Saved', '', 'info')
                    }
                })
            }
            else {
                toastr.error('User id does not found,Please Login again');
            }

        }


        function validateHeader() {

            var isValid = true;
            if ($("#t_cbrn option:selected").text() == "--Select--") {
                $('#t_cbrn').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_cbrn').css('border-color', 'lightgrey');
            }
            if ($('#t_nama').val() == "") {
                $('#t_nama').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_nama').css('border-color', 'lightgrey');
            }
            if ($('#t_phne').val() == "") {
                $('#t_phne').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_phne').css('border-color', 'lightgrey');
            }

            if ($('#t_mail').val() == "") {
                $('#t_mail').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_mail').css('border-color', 'lightgrey');
            }


            if ($('#t_ln01').val() == "") {
                $('#t_ln01').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_ln01').css('border-color', 'lightgrey');
            }
            if ($('#t_ln02').val() == "") {
                $('#t_ln02').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_ln02').css('border-color', 'lightgrey');
            }
            if ($('#t_ccit').val() == "") {
                $('#t_ccit').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_ccit').css('border-color', 'lightgrey');
            }

            if ($('#t_shsz').val() == "") {
                $('#t_shsz').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_shsz').css('border-color', 'lightgrey');
            }

            if ($('#t_prod option:selected').text() == '') {
                $('#t_prod').css('border-color', 'Red');
                toastr.error('Please Select Products Displayed.');
                isValid = false;
            }
            else {
                $('#t_prod').css('border-color', 'lightgrey');
            }
            if ($('#t_brnd option:selected').text() == '') {
                $('#t_brnd').css('border-color', 'Red');
                toastr.error('Please Select Brands present.');
                isValid = false;
            }
            else {
                $('#t_brnd').css('border-color', 'lightgrey');
            }
            //if ($('#t_find').val() == "") {
            //    $('#t_find').css('border-color', 'Red');
            //    isValid = false;
            //}
            //else {
            //    $('#t_find').css('border-color', 'lightgrey');
            //}
            if ($('#t_swdi').val() == "") {
                $('#t_swdi').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_swdi').css('border-color', 'lightgrey');
            }
            if ($('#t_keye').val() == "") {
                $('#t_keye').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_keye').css('border-color', 'lightgrey');
            }
            if ($('#t_remk').val() == "") {
                $('#t_remk').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_remk').css('border-color', 'lightgrey');
            }
            if ($('#t_chan').val() == "") {
                $('#t_chan').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_chan').css('border-color', 'lightgrey');
            }
            if ($('#t_badd').val() == "") {
                $('#t_badd').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_badd').css('border-color', 'lightgrey');
            }
            if ($('#t_pstc').val() == "") {
                $('#t_pstc').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_pstc').css('border-color', 'lightgrey');
            }
            if ($('#t_bgst').val() == "") {
                $('#t_bgst').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_bgst').css('border-color', 'lightgrey');
            }
            if ($('#t_panu').val() == "") {
                $('#t_panu').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_panu').css('border-color', 'lightgrey');
            }
            if ($('#t_sadd').val() == "") {
                $('#t_sadd').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_sadd').css('border-color', 'lightgrey');
            }
            if ($('#t_spin').val() == "") {
                $('#t_spin').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_spin').css('border-color', 'lightgrey');
            }
            if ($('#t_sgst').val() == "") {
                $('#t_sgst').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_sgst').css('border-color', 'lightgrey');
            }
            if ($('#t_shfr').val() == "") {
                $('#t_shfr').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_shfr').css('border-color', 'lightgrey');
            }
            if ($('#t_tofl').val() == "") {
                $('#t_tofl').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_tofl').css('border-color', 'lightgrey');
            }
            if ($('#t_cpay').val() == "") {
                $('#t_cpay').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_cpay').css('border-color', 'lightgrey');
            }
            if ($('#t_paym').val() == "") {
                $('#t_paym').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_paym').css('border-color', 'lightgrey');
            }
            if ($('#t_crli').val() == "") {
                $('#t_crli').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_crli').css('border-color', 'lightgrey');
            }
            if ($('#t_cday').val() == "") {
                $('#t_cday').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_cday').css('border-color', 'lightgrey');
            }
            if ($('#t_sals').val() == "") {
                $('#t_sals').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_sals').css('border-color', 'lightgrey');
            }
            if ($('#t_crep').val() == "") {
                $('#t_crep').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_crep').css('border-color', 'lightgrey');
            }
            if ($('#t_osrp').val() == "") {
                $('#t_osrp').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_osrp').css('border-color', 'lightgrey');
            }
            if ($('#t_emsr').val() == "") {
                $('#t_emsr').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_emsr').css('border-color', 'lightgrey');
            }
            //if ($('#t_cntp').val() == "") {
            //    $('#t_cntp').css('border-color', 'Red');
            //    isValid = false;
            //}
            //else {
            //    $('#t_cntp').css('border-color', 'lightgrey');
            //}
            //if ($('#t_namd').val() == "") {
            //    $('#t_namd').css('border-color', 'Red');
            //    isValid = false;
            //}
            //else {
            //    $('#t_namd').css('border-color', 'lightgrey');
            //}
            if ($('#t_cntr').val() == "") {
                $('#t_cntr').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_cntr').css('border-color', 'lightgrey');
            }
            if ($('#t_stte').val() == "") {
                $('#t_stte').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_stte').css('border-color', 'lightgrey');
            }
            if ($('#t_city').val() == "") {
                $('#t_city').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#t_city').css('border-color', 'lightgrey');
            }
            return isValid;
        }
        function GetHeaderData(response) {

            $('#t_cbrn').focus();


            if (response.d[0].toString().trim() != 'success') {
                toastr.error(response.d[1].toString());
            }
            else {
                //Bind_CIFFormDetails();
                ClearTextbox();
                toastr.success('Record added successfully');

            }

        }
        function ClearTextbox() {
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");
            $('#t_bpid_id').html('');

            document.getElementById("t_cbrn").value = 0;
            document.getElementById("t_nama").value = "";
            document.getElementById("t_phne").value = "";
            document.getElementById("t_mail").value = "";
            document.getElementById("t_ln01").value = "";
            document.getElementById("t_ln02").value = "";
            document.getElementById("t_ccit").value = "";
            $('#t_ccit_desc').html('');
            document.getElementById("t_ccty").value = "";
            $('#t_ccty_desc').html('');
            document.getElementById("t_cste").value = "";
            $('#t_cste_desc').html('');
            document.getElementById("t_shsz").value = "";
            //document.getElementById("t_prod").text = "";
            //document.getElementById("t_brnd").text = "";
            $('#t_prod').text('');
            //document.getElementById("t_prod").value.toString();
            $('#t_brnd').text('');
            document.getElementById("t_find").value = "";
            document.getElementById("t_swdi").value = "";
            document.getElementById("t_keye").value = "";
            document.getElementById("t_remk").value = "";

            document.getElementById("t_chan").value = "";
            document.getElementById("t_badd").value = "";
            document.getElementById("t_pstc").value = "";
            document.getElementById("t_bgst").value = "";
            document.getElementById("t_panu").value = "";
            document.getElementById("t_sadd").value = "";
            document.getElementById("t_spin").value = "";
            document.getElementById("t_sgst").value = "";
            document.getElementById("t_shfr").value = "";
            document.getElementById("t_tofl").value = "";
            document.getElementById("t_cpay").value = "";
            document.getElementById("t_paym").value = "";
            document.getElementById("t_crli").value = "";
            document.getElementById("t_cday").value = "";
            document.getElementById("t_sals").value = "";
            document.getElementById("t_crep").value = "";
            document.getElementById("t_osrp").value = "";
            document.getElementById("t_emsr").value = "";
            document.getElementById("t_cntp").value = "";
            document.getElementById("t_namd").value = "";
            document.getElementById("t_cntr").value = "";
            document.getElementById("t_stte").value = "";
            document.getElementById("t_city").value = "";
            $('#t_chan_desc').html('');
            $('#t_cpay_desc').html('');
            $('#t_paym_desc').html('');
            $('#t_sals_desc').html('');
            $('#t_crep_desc').html('');
            $('#t_osrp_desc').html('');
            $('#t_cntr_desc').html('');
            $('#t_stte_desc').html('');
            $('#t_city_desc').html('');
            $('#checksameasbilling').prop('checked', false);

        }

    </script>

    <script type="text/javascript">
        function delete_row(t_bpid) {
            Swal.fire({
                title: 'Do you want to delete the record?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Delete',
                denyButtonText: `Don't delete`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    $.ajax(
                        {
                            type: "POST",
                            url: "LOBCIFForm.aspx/deleteCIFDetails",
                            data: '{t_bpid: "' + t_bpid + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                if (response.d[0].toString() === "success") {

                                    //toastr.success('Record deleted successfully.');
                                    //$("#btnupdate").prop("disabled", true);
                                    Bind_CIFFormDetails();
                                }

                                else {
                                    toastr.warning(response.d[0].toString());

                                }
                            },
                            failure: function (response) {
                                alert(response.d);
                            }
                        })
                    Swal.fire('Deleted!', '', 'success')
                } else if (result.isDenied) {
                    Swal.fire('Records are not deleted', '', 'info')
                }
            })
        }
    </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">


    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>CIF Form</h1>

                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="CIFFormList.aspx">Home</a></li>
                        <li class="breadcrumb-item active">CIF Form</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>


    <section class="content">
        <section class="content-header">
            <div class="container-fluid">


                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;Add CIF Form</h3>
                                <div class="card-tools">
                                    <span class="badge badge-warning">Customer Id :</span>&nbsp; <span class="float-right username">
                                        <label id="t_bpid_id" style="color: darkblue"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="0">
                                            <label>LOB Name</label>

                                            <div class="input-group mb-3">

                                                <select class="form-control custom-select rounded-0" id="t_cbrn" data-dropdown-css-class="select2-danger" style="width: 100%;" onchange="GetProductBrand();">
                                                    <option value="0">--Select--</option>
                                                    <option value="1">Home</option>
                                                    <option value="2">Kitchen</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="1">
                                            <label>Name</label>
                                            <input type="text" class="form-control" placeholder="Enter customer name " id="t_nama">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="2">
                                            <label>Phone</label>
                                            <input type="number" class="form-control" placeholder="Enter Phone number" onchange="CheckValidPhoneno();" id="t_phne">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="3">
                                            <label>E-mail</label>
                                            <input type="text" class="form-control" placeholder="Enter E-mail" onchange="CheckEmail();" id="t_mail">
                                        </div>
                                    </div>
                                </div>

                                <%-- <div class="row">
                                    <div class="col-md-6">
                                    </div>

                                </div>--%>
                                <div class="row" tabindex="4">
                                    <div class="col-md-3">
                                        <label>Channel</label>

                                        <div class="input-group">
                                            <div class="custom-file">
                                                <input type="text" class="form-control" placeholder="Select Channel" id="t_chan" onchange="GetChannel();">
                                            </div>
                                            <div class="input-group-append" tabindex="5">
                                                <button type="button" id="btnchannel" class="btn btn-warning" onclick="openChild('t_chan','HelpPages/ttcmcs066100_channel')"><i class="fa fa-search"></i></button>
                                            </div>
                                        </div>
                                        <label id="t_chan_desc" style="display: none;"></label>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;Billing Address</h3>
                            </div>
                            <div class="card-body">

                                <div class="form-group" tabindex="6">
                                    <label>Billing Address Line 1</label>
                                    <input type="text" class="form-control" placeholder="Add Billing Address Line 1 here.." id="t_ln01">
                                </div>
                                <div class="form-group" tabindex="7">
                                    <label>Billing Address Line 2</label>
                                    <input type="text" class="form-control" placeholder="Add Billing Address Line 2 here.." id="t_ln02">
                                </div>


                                <div class="form-group" tabindex="8">
                                    <label>Country</label>
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Billing Country Name" id="t_ccty" onchange="GetCountry();">
                                        </div>
                                        <div class="input-group-append" tabindex="9">
                                            <button type="button" id="btnbindcountry" class="btn btn-warning" onclick="openChild('t_ccty','HelpPages/ttcmcs010100_country')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_ccty_desc" style="display: none;"></label>
                                </div>
                                <div class="form-group" tabindex="10">
                                    <label>State</label>
                                    <%-- <input type="text" class="form-control" placeholder="Select State Name" id="t_ccty" value="India" disabled>--%>
                                    <div class="input-group">

                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Billing State Name" id="t_cste" onchange="GetState();">
                                        </div>
                                        <div class="input-group-append" tabindex="11">
                                            <button type="button" id="btnbindState" class="btn btn-warning" onclick="openChild('t_cste','HelpPages/ttcmcs143100_State')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_cste_desc" style="display: none;"></label>
                                </div>
                                <div class="form-group" tabindex="12">
                                    <label>City</label>
                                    <%-- <input type="text" class="form-control" placeholder="Select City name" id="t_ccit">--%>
                                    <div class="input-group">

                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Billing City name" id="t_ccit" onchange="GetCity();">
                                        </div>
                                        <div class="input-group-append" tabindex="13">
                                            <button type="button" id="btnbindCity" class="btn btn-warning" onclick="openChild('t_ccit','HelpPages/ttccom139100_City')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_ccit_desc" style="display: none;"></label>
                                </div>

                                <div class="form-group" tabindex="14">
                                    <label>Pin code</label>
                                    <input type="number" class="form-control" placeholder="Enter Biiling Pin code" id="t_pstc">
                                </div>


                                <div class="form-group" tabindex="15">
                                    <label>GST</label>
                                    <input type="text" class="form-control" placeholder="Enter Billing GST" id="t_bgst">
                                </div>
                                <div class="form-group" tabindex="16">
                                    <label>PAN Number</label>
                                    <input type="text" class="form-control" placeholder="Enter PAN Number" onchange="CheckPan();" id="t_panu">
                                </div>

                              
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;Shipping Address</h3>
                            </div>
                            <div class="card-body">

                                <div class="form-group" tabindex="17">
                                    <label>Shipping Address Line 1</label>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Add Shipping Address Line 1 here.." id="t_badd">
                                        <%--<textarea class="form-control" id="t_badd" rows="2" placeholder="Enter Billing address"></textarea>--%>
                                    </div>
                                </div>
                                <div class="form-group" tabindex="18">
                                    <label>Shipping Address Line 2</label>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Add Shipping Address Line 2 here.." id="t_sadd">
                                        <%-- <textarea class="form-control" id="t_sadd" rows="2" placeholder="Enter Shipping address"></textarea>--%>
                                    </div>
                                </div>
                                <div class="form-group" tabindex="19">
                                    <label>Country</label>
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Shipping Country Name" id="t_cntr" onchange="ShippingGetCountry();">
                                        </div>
                                        <div class="input-group-append" tabindex="20">
                                            <button type="button" id="btnbindcountry1" class="btn btn-warning" onclick="openChild('t_cntr','HelpPages/ttcmcs010100_country')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_cntr_desc" style="display: none;"></label>
                                </div>
                                <div class="form-group" tabindex="21">
                                    <label>State</label>

                                    <div class="input-group">

                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Shipping State Name" id="t_stte" onchange="ShippingGetState();">
                                        </div>
                                        <div class="input-group-append" tabindex="22">
                                            <button type="button" id="btnbindState1" class="btn btn-warning" onclick="openChild('t_stte','HelpPages/ttcmcs143100_State')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_stte_desc" style="display: none;"></label>
                                </div>
                                <div class="form-group" tabindex="23">
                                    <label>City</label>

                                    <div class="input-group">

                                        <div class="custom-file">
                                            <input type="text" class="form-control" placeholder="Select Shipping City name" id="t_city" onchange="ShippingGetCity();">
                                        </div>
                                        <div class="input-group-append" tabindex="24">
                                            <button type="button" id="btnbindCity1" class="btn btn-warning" onclick="openChild('t_city','HelpPages/ttccom139100_City')"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                    <label id="t_city_desc" style="display: none;"></label>
                                </div>

                                <div class="form-group" tabindex="25">
                                    <label>Pin code</label>
                                    <input type="number" class="form-control" placeholder="Enter Shipping Pin code" id="t_spin">
                                </div>

                                <div class="form-group" tabindex="26">
                                    <label>GST</label>
                                    <input type="text" class="form-control" placeholder="Enter Shipping GST" id="t_sgst">
                                </div>
                                <div class="form-group" tabindex="27">
                                    <div class="form-check">
                                        <input id="checksameasbilling" class="form-check-input checkval" type="checkbox">
                                        <label class="form-check-label">Same as billing address</label>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;Additional Info</h3>
                                <div class="card-tools">
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="28">
                                            <label>Showroom size</label>
                                            <input type="text" class="form-control" placeholder="Enter Showroom size" id="t_shsz">
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="29">
                                            <label>Products Displayed</label>
                                            <select class="select2" multiple="multiple" data-placeholder="Select Products Displayed" style="width: 100%;" id="t_prod">
                                            </select>

                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="30">
                                            <label>Brands Present</label>
                                            <select class="select2" multiple="multiple" data-placeholder="Select Brands Present" style="width: 100%;" id="t_brnd">
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-3" id="finiDisplayeddiv">
                                        <div class="form-group" tabindex="31">
                                            <label>Finishes Displayed</label>
                                            <input type="number" class="form-control" placeholder="Enter Finishes Displayed" id="t_find">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="32">
                                            <label>Spacewood Display</label>
                                            <input type="number" class="form-control" placeholder="Select Spacewood Display" id="t_swdi">
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="33">
                                            <label>Key Employees</label>
                                            <input type="number" class="form-control" placeholder="Select Key Empolyees" id="t_keye">
                                        </div>
                                    </div>


                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="34">
                                            <label>Showroom Frontage</label>
                                            <input type="number" class="form-control" placeholder="Enter Showroom Frontage" id="t_shfr">
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group" tabindex="35">
                                            <label>Total Floor</label>
                                            <input type="number" class="form-control" placeholder="Enter total floor" id="t_tofl">
                                        </div>
                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="36">
                                            <label>Remarks</label>
                                            <input type="text" class="form-control" placeholder="Enter Remark" id="t_remk">
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <%-- <div class="modal-footer">
                            <input type="button" class="btn btn-warning waves-effect" onclick="ClearTextbox()" id="btnnew" value="New" />
                            <input type="button" class="btn btn-warning waves-effect" onclick="AddInput('I')" id="btnAdd" value="Save" />

                        </div>--%>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;ERP Payment Terms</h3>
                                <div class="card-tools">
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">

                                        <div class="form-group" tabindex="37">
                                            <label>Payment Terms as agreed</label>
                                            <div class="input-group">
                                                <div class="custom-file">

                                                    <input type="text" class="form-control" placeholder="Enter Payment terms as agreed" onchange="GetPaymentTerms();" id="t_cpay">
                                                </div>
                                                <div class="input-group-append" tabindex="38">
                                                    <button type="button" id="btnbindpaymentterms" class="btn btn-warning" onclick="openChild('t_cpay','HelpPages/ttcmcs013100_PaymentTerms')"><i class="fa fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_cpay_desc" style="display: none;"></label>
                                        </div>

                                        <div class="form-group" tabindex="39">
                                            <label>Payment mode</label>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Payment mode" onchange="GetPaymentMode();" id="t_paym">
                                                </div>
                                                <div class="input-group-append" tabindex="40">
                                                    <button type="button" id="btnbindpaymentMode" class="btn btn-warning" onclick="openChild('t_paym','HelpPages/ttfcmg003100_PaymentMode')"><i class="fa fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_paym_desc" style="display: none;"></label>
                                        </div>

                                        <div class="form-group" tabindex="41">
                                            <label>Credit Limit</label>
                                            <input type="number" class="form-control" placeholder="Enter Credit Limit" id="t_crli">
                                        </div>

                                        <div class="form-group" tabindex="42">
                                            <label>Credit Days</label>
                                            <input type="number" class="form-control" placeholder="Enter Credit Days" id="t_cday">
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="43">
                                            <label>Sales Segment</label>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Sales Segment" onchange="GetSaleSegment();" id="t_sals">
                                                </div>
                                                <div class="input-group-append" tabindex="44">
                                                    <button type="button" id="btnSalesSegmemnt" class="btn btn-warning" onclick="openChild('t_sals','HelpPages/ttcmcs031100_salessegment')"><i class="fa fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_sals_desc" style="display: none;"></label>
                                        </div>
                                        <div class="form-group" tabindex="45">
                                            <label>DH Coll responsible</label>
                                            <%--<input type="text" class="form-control" placeholder="Enter DH Coll Responsible" id="t_dhco">--%>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter DH Coll Responsible" onchange="GetDHCollResponsible();" id="t_crep">
                                                </div>
                                                <div class="input-group-append" tabindex="46">
                                                    <button type="button" id="btnDHCollResponsible" class="btn btn-warning" onclick="openChild('t_crep','HelpPages/ttccom001100_Internal')"><i class="fa fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_crep_desc" style="display: none;"></label>
                                        </div>

                                        <div class="form-group" tabindex="47">
                                            <label>Sales Coll responsible</label>
                                            <%--<input type="text" class="form-control" placeholder="Enter Sales coll responsible" id="t_saco">--%>
                                            <div class="input-group">
                                                <div class="custom-file">
                                                    <input type="text" class="form-control" placeholder="Enter Sales coll responsible" onchange="GetSalesCollResponsible();" id="t_osrp">
                                                </div>
                                                <div class="input-group-append" tabindex="48">
                                                    <button type="button" id="btnSalesCollResponsible" class="btn btn-warning" onclick="openChild('t_osrp','HelpPages/ttccom001100_External')"><i class="fa fa-search"></i></button>
                                                </div>
                                            </div>
                                            <label id="t_osrp_desc" style="display: none;"></label>
                                        </div>

                                        <div class="form-group" tabindex="49">
                                            <label>Email-Sales Representative(For Dispatch Intimation)</label>
                                            <input type="text" class="form-control" placeholder="Enter Email Sales Representative" onchange="CheckEmailSalesRep();" id="t_emsr">
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-file"></i>&nbsp;Contact Information</h3>
                                <div class="card-tools">
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="50">
                                            <label>Contact Person</label>
                                            <input type="text" class="form-control" placeholder="Enter Contact Person" id="t_cntp">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="51">
                                            <label>Contact Person Mobile Number</label>
                                            <input type="number" class="form-control" maxlength="10" placeholder="Enter Contact Person Mobile Number" onchange="CheckValidContactno();" id="t_cnmo">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="52">
                                            <label>Contact Person Email</label>
                                            <input type="text" class="form-control" placeholder="Enter Contact Person Email" onchange="CheckContactEmail();" id="t_cnem">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group" tabindex="53">
                                            <label>Name Of Director</label>
                                            <input type="text" class="form-control" placeholder="Enter Name Of Director" id="t_namd">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-warning waves-effect" onclick="ClearTextbox()" id="btnnew" value="New" tabindex="53" />
                                <input type="button" class="btn btn-warning waves-effect" onclick="AddInput('I')" id="btnAdd" value="Save" tabindex="52" />

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="divLoader" class="loading" align="center" style="display: none">
                        Loading. Please wait.<br />
                        <br />
                        <img src="images/SLoading.gif" alt="Loader" />
                    </div>
                </div>


                <%-- <div class="row" tabindex="-1">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-file"></i>&nbsp;CIF Form Details
                          
                            </h3>
                            <div class="card-tools">
                            </div>
                        </div>
                        <div class="card-body table-responsive p-0" tabindex="54">
                            <table id="tblCIFFormdetails" class="table table-bordered table-striped ">
                            </table>
                        </div>
                    </div>
                </div>
            </div>--%>
            </div>
        </section>
    </section>

    <script type="text/javascript">
        function CheckEmail() {

            var mailid = '';
            mailid = $("#t_mail").val();
            var EmailCheck = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (mailid != '') {
                if (mailid.match(EmailCheck)) {
                    return true;
                }
                else {
                    toastr.error('Enter valid E-mail address.');
                    $("#t_mail").val('');
                    $("#t_mail").focus();
                    return false;
                }
            }
        }
        function CheckContactEmail() {

            var mailid = '';
            mailid = $("#t_cnem").val();
            var EmailCheck = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (t_cnem != '') {
                if (mailid.match(EmailCheck)) {
                    return true;
                }
                else {
                    toastr.error('Enter valid E-mail address.');
                    $("#t_cnem").val('');
                    $("#t_cnem").focus();
                    return false;
                }
            }
        }
        function CheckEmailSalesRep() {

            var mailid = '';
            mailid = $("#t_emsr").val();
            var EmailCheck = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (mailid != '') {
                if (mailid.match(EmailCheck)) {
                    return true;
                }
                else {
                    toastr.error('Enter valid E-mail address.');
                    $("#t_emsr").val('');
                    $("#t_emsr").focus();
                    return false;
                }
            }
        }
        function CheckValidPhoneno() {
            debugger
            var txtPhoneno = "";
            var txtPhoneno = $("#t_phne").val();
            //var TotalPerCheck = "^0*(?:[1-9][0-9]?(\.\d+)?|100)$";
            var ValidPhoneno = /^(\+\d{1,3}[- ]?)?\d{10}$/;
            if (txtPhoneno != '') {
                if (txtPhoneno.match(ValidPhoneno)) {
                    return true;
                }
                else {
                    toastr.error('Enter valid phone no.');
                    $("#t_phne").val('');
                    $("#t_phne").focus();
                    return false;

                }
            }
        }
        
        function CheckValidContactno() {
            debugger
            var t_cnmo = "";
            var t_cnmo = $("#t_cnmo").val();
            //var TotalPerCheck = "^0*(?:[1-9][0-9]?(\.\d+)?|100)$";
            var Valid = /^(\+\d{1,3}[- ]?)?\d{10}$/;
            if (t_cnmo != '') {
                if (t_cnmo.match(Valid)) {
                    return true;
                }
                else {
                    toastr.error('Enter valid phone no.');
                    $("#t_cnmo").val('');
                    $("#t_cnmo").focus();
                    return false;

                }
            }
        }
        function CheckPan() {
            var inputvalues = $("#t_panu").val();
            var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
            if (!regex.test(inputvalues)) {
                $("#t_panu").val('');
                $("#t_panu").focus();
                toastr.error('Invalid PAN number');
                return regex.test(inputvalues);
            }
        }
    </script>
    <script type="text/javascript">
        $('#checksameasbilling').change(function () {

            if (this.checked) {

                var t_ln01 = $('#t_ln01').val();
                $('#t_badd').val(t_ln01);
                var t_ln02 = $('#t_ln02').val();
                $('#t_sadd').val(t_ln02);
                var t_ccty = $('#t_ccty').val();
                $('#t_cntr').val(t_ccty);
                var t_cste = $('#t_cste').val();
                $('#t_stte').val(t_cste);
                var t_ccit = $('#t_ccit').val();
                $('#t_city').val(t_ccit);
                var t_pstc = $('#t_pstc').val();
                $('#t_spin').val(t_pstc);
                var t_bgst = $('#t_bgst').val();
                $('#t_sgst').val(t_bgst);
                ShippingGetCountry();
                ShippingGetState();
                ShippingGetCity();

            }
            else {
                $('#t_badd').val('');
                $('#t_sadd').val('');
                $('#t_cntr').val('');
                $('#t_stte').val('');
                $('#t_city').val('');
                $('#t_spin').val('');
                $('#t_sgst').val('');
            }


        });
    </script>
    <!-- jQuery -->
    <script src="../../plugins/jquery/jquery.min.js"></script>

    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->
    <script src="../../plugins/select2/js/select2.full.min.js"></script>
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

    <!-- Page specific script -->
    <script>
        $(function () {
            //Initialize Select2 Elements
            $('.select2').select2()

            //Initialize Select2 Elements
            $('.select2bs4').select2({
                theme: 'bootstrap4'
            })
        })
    </script>
</asp:Content>
