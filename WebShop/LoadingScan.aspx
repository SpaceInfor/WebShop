<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="LoadingScan.aspx.cs" Inherits="WebShop.LoadingScan" %>

<!DOCTYPE html>
<html lang="en">
 <head>
 

<link rel="alternate" type="application/rss+xml" title="Minhaz&#39;s Blog" href="/feed.xml">
<link rel="shortcut icon" href=/assets/favicon.ico>
<link rel="icon" type="image/png" sizes="32x32" href=/assets/favicon.ico>
  <script src="/assets/js/jquery.js"></script>
<title>Loading Slip</title>

<link rel="canonical" href="https://blog.minhazav.dev/research/html5-qrcode" />

    <script type = "text/javascript">
      function BindProject(prbp) {

        $.ajax({
          type: "POST",
          url: "MasterProject.aspx/bind_MasterProject",
          data: '{t_prbp: "' + prbp + '" }',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: BindTable,
          failure: function (response) {
            document.getElementById('tb1').innerHTML = response.d;
          }
        });
      }
      function BindTable(response) {
        document.getElementById('tb1').innerHTML = response.d;
      }
</script> 
  <script type = "text/javascript">
    function AddProject(var caseno) {
      $.ajax(
        {
          type: "POST",
          url: "LoadingScan.aspx/ProcessIT",
          data: '{t_boxs: "' + caseno + '" }',
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
      alert('Master Project added successfully!');
     
         
          var username = '<%= Session["t_usid"] %>';
          
          BindProject(username);
      }
  </script> 
  <script type="text/javascript">

      $(document).ready(function () {
          var username = '<%= Session["t_usid"] %>';
        BindProject(username);
      });
  </script>


<script type="application/ld+json">
{"description":"Demo of a cross platform HTML5 QR Code scanner","url":"https://blog.minhazav.dev/research/html5-qrcode","@type":"WebPage","headline":"HTML5 QR Code Scanner Demo","publisher":{"@type":"Organization","logo":{"@type":"ImageObject","url":"https://blog.minhazav.dev/images/rsz_self_1_1.jpg"}},"@context":"https://schema.org"}</script>
</head>
 <body>

   <main class="default-content" aria-label="Content">
     <div class="wrapper-content">
       <style>
#reader {
    width: 640px;
}
@media(max-width: 600px) {
	#reader {
		width: 300px;
	}
}
.empty {
    display: block;
    width: 100%;
    height: 20px;
}
.alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
}
.alert-info {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.alert-success {
    color: #3c763d;
    background-color: #dff0d8;
    border-color: #d6e9c6;
}
</style>
       <div class="container">
	<div class="row">
		<div class="col-md-12" style="text-align: center;margin-bottom: 20px;">
			<div id="reader" style="display: inline-block;"></div>
			<div class="empty"></div>
			<div id="scanned-result"></div>
		</div>
	</div>
</div>
      <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.3/highlight.min.js"></script>
      <script src="Scripts/html5-qrcode.min.js"></script>
      <script>
    
          function docReady(fn) {
    // see if DOM is already available


    if (document.readyState === "complete" || document.readyState === "interactive") {
            // call on next available tick
            setTimeout(fn, 1);
    } else {
            document.addEventListener("DOMContentLoaded", fn);
    }
}
/** Ugly function to write the results to a table dynamically. */
        function printScanResultPretty(codeId, decodedText, decodedResult) {


          alert(decodedText);
  //          let resultSection = document.getElementById('scanned-result');
  //  let tableBodyId = "scanned-result-table-body";
  //  if (!document.getElementById(tableBodyId)) {
  //          let table = document.createElement("table");
  //      table.className = "styled-table";
  //      table.style.width = "100%";
  //      resultSection.appendChild(table);
  //      let theader = document.createElement('thead');
  //      let trow = document.createElement('tr');
  //      let th1 = document.createElement('td');
  //      th1.innerText = "Count";
  //      let th2 = document.createElement('td');
  //      th2.innerText = "Format";
  //      let th3 = document.createElement('td');
  //      th3.innerText = "Result";
  //      trow.appendChild(th1);
  //      trow.appendChild(th2);
  //      trow.appendChild(th3);
  //      theader.appendChild(trow);
  //      table.appendChild(theader);
  //      let tbody = document.createElement("tbody");
  //      tbody.id = tableBodyId;
  //      table.appendChild(tbody);
  //  }
  //  let tbody = document.getElementById(tableBodyId);
  //  let trow = document.createElement('tr');
  //  let td1 = document.createElement('td');
  //td1.innerText = `${codeId}`;
  //  let td2 = document.createElement('td');
  //td2.innerText = `${decodedResult.result.format.formatName}`;
  //  let td3 = document.createElement('td');
  //td3.innerText = `${decodedText} `;
  //  trow.appendChild(td1);
  //  trow.appendChild(td2);
  //  trow.appendChild(td3);
  //  tbody.appendChild(trow);
}
docReady(function() {
            hljs.initHighlightingOnLoad();
	var lastMessage;
	var codeId = 0;
	function onScanSuccess(decodedText, decodedResult) {
        /**
         * If you following the code example of this page by looking at the
         * source code of the demo page - good job!!
         *
         * Tip: update this function with a success callback of your choise.
         */
		if (lastMessage !== decodedText) {
            lastMessage = decodedText;
            printScanResultPretty(codeId, decodedText, decodedResult);
            ++codeId;
		}
  }

  Html5Qrcode.getCameras().then(devices => {
    /**
     * devices would be an array of objects of type:
     * { id: "id", label: "label" }
     */
    debugger
    if (devices && devices.length) {
      var cameraId = devices[0].id;
      // .. use this to start scanning.
    }
  }).catch(err => {
    // handle err
  });
  const html5QrCode = new Html5Qrcode("reader");
  const qrCodeSuccessCallback = (decodedText, decodedResult) => {
    /* handle success */
  };
  const config = { fps: 10, qrbox: 250 };

  // If you want to prefer front camera
  html5QrCode.start({ facingMode: "environment" }, config, qrCodeSuccessCallback);

  // If you want to prefer back camera



});
      </script>
     </div>
   </main>


 </body>
</html>
