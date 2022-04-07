<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Demo.aspx.cs" Inherits="WebShop.Demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POD Slip</title>

    <!-- Google Font: Source Sans Pro -->
   <%-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css" />
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css" />
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet" />
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css" />
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css" />

    <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

    <link href="//datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {
            var data = [{
                "first_name": "Airi",
                "last_name": "Satou",
                "position": "Accountant",
                "office": "Tokyo",
                "start_date": "28th Nov 08",
                "salary": "$162,700"
            },
            {
                "first_name": "Angelica",
                "last_name": "Ramos",
                "position": "Chief Executive Officer (CEO)",
                "office": "London",
                "start_date": "9th Oct 09",
                "salary": "$1,200,000"
            }];
            var cols = [];

            var exampleRecord = data[0];

            //get keys in object. This will only work if your statement remains true that all objects have identical keys
            var keys = Object.keys(exampleRecord);

            //for each key, add a column definition
            keys.forEach(function (k) {
                cols.push({
                    title: k,
                    data: k
                    //optionally do some type detection here for render function
                });
            });

            //initialize DataTables
            var table = $('#example').DataTable({
                columns: cols
            });

            //add data and draw
            table.rows.add(data).draw();

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <div class="container">
      <table id="example" class="display" width="100%">
      </table>
    </div>
    </form>
</body>
</html>

