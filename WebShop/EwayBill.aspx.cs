using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using RestSharp.Extensions;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Newtonsoft.Json;
using System.IO;
using System.Text;
using System.Net;

namespace WebShop
{
  public partial class EwayBill : System.Web.UI.Page
  {

    string invno;
    string filenamepth;
    protected void Page_Load(object sender, EventArgs e)
    {
      string docno;
      int record;
      string ewaybill = "";
      string static_txt = "";

      string auth_token = "";
      string owner_id = "";
      string gst_no = "";

      record = 1;
      if (Request.QueryString["invoice"] != null)
      {
        invno = Request.QueryString["invoice"].ToString();
        try
        {
          Root root = new Root();
          root.BuyerDtls = new BuyerDtls();
          root.SellerDtls = new SellerDtls();
          root.ExpShipDtls = new ExpShipDtls();
          root.DispDtls = new DispDtls();
          root.ItemList = new List<ItemList>();
          string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
          using (SqlConnection con = new SqlConnection(constr))
          {
            using (SqlCommand cmd = new SqlCommand("select * from testdb..fg_inv_mst_ewayb_api_data where NO = '" + invno + "'"))
            {
              cmd.Connection = con;

              con.Open();
              using (SqlDataReader sdr = cmd.ExecuteReader())
              {
                while (sdr.Read())
                {
                  if (record == 1)
                  {
                    auth_token = sdr["AUTH_TOKEN"].ToString();
                    owner_id = sdr["OWNER_ID_LIVE"].ToString();
                    gst_no = sdr["GSTIN_SELLERDTLS"].ToString();
                    root.DocumentNumber = sdr["no"].ToString();
                    root.DocumentType = sdr["TYP"].ToString();
                    root.DocumentDate = sdr["DT"].ToString();
                    root.SupplyType = "OUTWARD";
                    root.SubSupplyType = sdr["STYP"].ToString();
                    root.SubSupplyTypeDesc = "TEST";
                    root.TransactionType = sdr["Transaction_Type"].ToString();

                    root.BuyerDtls.Gstin = sdr["GSTIN_BUYERDTLS"].ToString();
                    root.BuyerDtls.LglNm = sdr["LGLNM_BUYERDTLS"].ToString();
                    root.BuyerDtls.TrdNm = sdr["TRDNM_BUYERDTLS"].ToString();
                    root.BuyerDtls.Addr1 = sdr["ADDR1_BUYERDTLS"].ToString();
                    root.BuyerDtls.Addr2 = sdr["ADDR2_BUYERDTLS"].ToString();
                    root.BuyerDtls.Loc = sdr["LOC_BUYERDTLS"].ToString();
                    root.BuyerDtls.Pin = Convert.ToInt32(sdr["PIN_BUYERDTLS"]);
                    root.BuyerDtls.Stcd = sdr["STCD_BUYERDTLS"].ToString();

                    root.SellerDtls.Gstin = sdr["GSTIN_SELLERDTLS"].ToString();
                    root.SellerDtls.LglNm = sdr["LGLNM_SELLERDTLS"].ToString();
                    root.SellerDtls.TrdNm = sdr["TRDNM_SELLERDTLS"].ToString();
                    root.SellerDtls.Addr1 = sdr["ADDR1_SELLERDTLS"].ToString();
                    root.SellerDtls.Addr2 = sdr["ADDR2_SELLERDTLS"].ToString();
                    root.SellerDtls.Loc = sdr["LOC_SELLERDTLS"].ToString();
                    root.SellerDtls.Pin = Convert.ToInt32(sdr["PIN_SELLERDTLS"]);
                    root.SellerDtls.Stcd = sdr["STCD_SELLERDTLS"].ToString();

                    root.ExpShipDtls.LglNm = sdr["LGLNM_SHIPDTLS"].ToString();
                    root.ExpShipDtls.Addr1 = sdr["ADDR1_SHIPDTLS"].ToString();
                    root.ExpShipDtls.Loc = sdr["LOC_SHIPDTLS"].ToString();
                    root.ExpShipDtls.Pin = Convert.ToInt32(sdr["PIN_SHIPDTLS"]);
                    root.ExpShipDtls.Stcd = sdr["STCD_SHIPDTLS"].ToString();
                    root.DispDtls.Nm = sdr["NM_DISPDTLS"].ToString();
                    root.DispDtls.Addr1 = sdr["ADDR1_DISPDTLS"].ToString();
                    root.DispDtls.Addr2 = sdr["ADDR2_DISPDTLS"].ToString();
                    root.DispDtls.Loc = sdr["LOC_DISPDTLS"].ToString();
                    root.DispDtls.Pin = Convert.ToInt32(sdr["PIN_DISPDTLS"]);
                    root.DispDtls.Stcd = sdr["STCD_DISPDTLS"].ToString();

                    root.ItemList.Add(new ItemList
                    {
                      ProdName = sdr["PRDDESC_ITEMLIST"].ToString(),
                      ProdDesc = sdr["PRDDESC_ITEMLIST"].ToString(),
                      HsnCd = sdr["HSNCD_ITEMLIST"].ToString(),
                      Qty = Convert.ToInt32(sdr["QTY_ITEMLIST"]),
                      Unit = sdr["UNIT_ITEMLIST"].ToString(),
                      AssAmt = Convert.ToInt32(sdr["ASSAMT_ITEMLIST"]),
                      CgstRt = Convert.ToInt32(sdr["CGSTRT_ITEMLIST"]),
                      //CgstAmt = Convert.ToInt32(sdr["CGSTAMT_ITEMLIST"]),
                      CgstAmt = null,
                      SgstRt = Convert.ToInt32(sdr["SGSTRT_ITEMLIST"]),
                      //SgstAmt = Convert.ToInt32(sdr["SGSTAMT_ITEMLIST"]),
                      SgstAmt = null,
                      IgstRt = Convert.ToInt32(sdr["IGSTRT_ITEMLIST"]),
                      //IgstAmt = Convert.ToInt32(sdr["IGSTAMT_ITEMLIST"]),
                      IgstAmt = null,
                      CesRt = Convert.ToInt32(sdr["CESRT_ITEMLIST"]),
                      CesAmt = Convert.ToInt32(sdr["CESAMT_ITEMLIcST"]),
                      OthChrg = Convert.ToInt32(sdr["OTHCHRG_ITEMLIST"]),
                      CesNonAdvAmt = Convert.ToInt32(sdr["CESNONADVLAMT_ITEMLIST"]),
                    });

                    root.TotalInvoiceAmount = Convert.ToInt32(sdr["TOTINVVAL_VALDTLS"]);
                    root.TotalCgstAmount = Convert.ToInt32(sdr["CGSTVAL_VALDTLS"]);
                    root.TotalSgstAmount = Convert.ToInt32(sdr["SGSTVAL_VALDTLS"]);
                    root.TotalIgstAmount = Convert.ToInt32(sdr["IGSTVAL_VALDTLS"]);
                    root.TotalCessAmount = Convert.ToInt32(sdr["CESVAL_VALDTLS"]);
                    root.TotalCessNonAdvolAmount = Convert.ToInt32(sdr["CESNONADVLAMT_ITEMLIST"]);
                    root.TotalAssessableAmount = Convert.ToInt32(sdr["ASSVAL_VALDTLS"]);
                    root.OtherAmount = Convert.ToInt32(sdr["OTHCHRG_VALDTLS"]);
                    root.OtherTcsAmount = Convert.ToInt32(sdr["OTHCHRG_VALDTLS"]);
                    //root.TransId = sdr["TRANSID_EWBDTLS"].ToString();
                    root.TransId = null;
                    root.TransName = sdr["TRANSNAME_EWBDTLS"].ToString();
                    root.TransMode = sdr["TRANSMODE_EWBDTLS"].ToString();
                    root.Distance = Convert.ToInt32(sdr["DISTANCE_EWBDTLS"]);
                    root.TransDocNo = sdr["TRANSDOCNO_EWBDTLS"].ToString();
                    root.TransDocDt = sdr["TRANSDOCDT_EWBDTLS"].ToString();
                    root.VehNo = sdr["VEHNO_EWBDTLS"].ToString();
                    root.VehType = sdr["VEHTYPE_EWBDTLS"].ToString();// "REGULAR"; 
                    record = record + 1;
                  }
                  else
                  {
                    root.ItemList.Add(new ItemList
                    {
                      ProdName = sdr["PRDDESC_ITEMLIST"].ToString(),
                      ProdDesc = sdr["PRDDESC_ITEMLIST"].ToString(),
                      HsnCd = sdr["HSNCD_ITEMLIST"].ToString(),
                      Qty = Convert.ToInt32(sdr["QTY_ITEMLIST"]),
                      Unit = sdr["UNIT_ITEMLIST"].ToString(),
                      AssAmt = Convert.ToInt32(sdr["ASSAMT_ITEMLIST"]),
                      CgstRt = Convert.ToInt32(sdr["CGSTRT_ITEMLIST"]),
                      //CgstAmt = Convert.ToInt32(sdr["CGSTAMT_ITEMLIST"]),
                      CgstAmt = null,
                      SgstRt = Convert.ToInt32(sdr["SGSTRT_ITEMLIST"]),
                      //SgstAmt = Convert.ToInt32(sdr["SGSTAMT_ITEMLIST"]),
                      SgstAmt = null,
                      IgstRt = Convert.ToInt32(sdr["IGSTRT_ITEMLIST"]),
                      //IgstAmt = Convert.ToInt32(sdr["IGSTAMT_ITEMLIST"]),
                      IgstAmt = null,
                      CesRt = Convert.ToInt32(sdr["CESRT_ITEMLIST"]),
                      CesAmt = Convert.ToInt32(sdr["CESAMT_ITEMLIcST"]),
                      OthChrg = Convert.ToInt32(sdr["OTHCHRG_ITEMLIST"]),
                      CesNonAdvAmt = Convert.ToInt32(sdr["CESNONADVLAMT_ITEMLIST"]),
                    });
                  }
                }
              }
            }
            record = record + 1;
            //var client = new RestClient("https://einvoicing.internal.cleartax.co/v3/ewaybill/generate");
            var client = new RestClient("https://api-einv.cleartax.in/v3/ewaybill/generate");
            client.Timeout = -1;
            var request = new RestRequest(Method.PUT);
            //request.AddHeader("X-Cleartax-Auth-Token", "1.78a721e1-8ca7-4811-b38a-7603ca7e45f6_d9b774d7e353d36928dc93d6f85faa0a5e7e54d618111296405260f78b21f8b3");
            request.AddHeader("X-Cleartax-Auth-Token", auth_token);
            //request.AddHeader("gstin", "27AACCS4955R1ZJ");
            request.AddHeader("gstin", gst_no);
            //request.AddHeader("owner_id", "9d15de7b-b7b3-4987-aa75-053a5714b513");
            request.AddHeader("owner_id",owner_id);
            request.AddHeader("Content-Type", "application/json");

            //request.AddParameter("application/json", root, ParameterType.RequestBody);
            request.AddJsonBody(root);
            IRestResponse response = client.Execute(request);
            //Console.WriteLine(response.Content);
            dynamic data = JObject.Parse(response.Content.ToString());
            ewaybill = data.govt_response.EwbNo;
            if (ewaybill != null)
            {

              lblewaybill.Text = ewaybill;
              OK.Visible = true;
              NOK.Visible = false;
              Ewaybillfile ewb = new Ewaybillfile();
              List<ulong> stringList = new List<ulong> { UInt64.Parse(ewaybill) };
              ewb.ewb_numbers = stringList;
              ewb.print_type = "DETAILED";


              string FilePath = Server.MapPath("~/EInvoice/");
              //var client1 = new RestClient("https://einvoicing.internal.cleartax.co/v2/eInvoice/ewaybill/print?format=PDF");
              var client1 = new RestClient("https://api-einv.cleartax.in/v2/eInvoice/ewaybill/print?format=PDF");
              client1.Timeout = -1;
              var request1 = new RestRequest(Method.POST);
              //request1.AddHeader("x-cleartax-auth-token", "1.78a721e1-8ca7-4811-b38a-7603ca7e45f6_d9b774d7e353d36928dc93d6f85faa0a5e7e54d618111296405260f78b21f8b3");
              request1.AddHeader("x-cleartax-auth-token", auth_token);
              request1.AddHeader("x-cleartax-product", "EInvoice");
              //request1.AddHeader("owner_id", "9d15de7b-b7b3-4987-aa75-053a5714b513");
              request1.AddHeader("owner_id", owner_id);
              // request1.AddHeader("gstin", "27AACCS4955R1ZJ");
              request1.AddHeader("gstin", gst_no);
              request1.AddHeader("Content-Type", "application/json");
              request1.AddJsonBody(ewb);
              IRestResponse response1 = client1.Execute(request1);
              response1.ContentType = "Application/pdf";
              byte[] response2 = client1.DownloadData(request1);
              filenamepth = @FilePath + ewaybill + ".pdf";
              File.WriteAllBytes(filenamepth, response2);
              waybillpdf.Src = "EInvoice/" + ewaybill + ".pdf";
              save_waybill(ewaybill, invno);
            }
            else
            {
              lblerror.Text = response.Content.ToString();
              OK.Visible = false;
             NOK.Visible = true;
            }
          }
        }
        catch (Exception ex)
        {

        }
      }
      
      
    }
    protected void save_waybill(string waybilno,string invoice)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_ewbn", waybilno);
      sqlcom.Parameters.AddWithValue("@t_invc", invoice );
   
      sqlcom.CommandText = "WS_EwaybillRequest";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
      }
      catch (Exception ex)
      {
        result = ex.Message;
      }
    }
  }

  public class BuyerDtls
  {
    public string Gstin { get; set; }
    public string LglNm { get; set; }
    public string TrdNm { get; set; }
    public string Addr1 { get; set; }
    public string Addr2 { get; set; }
    public string Loc { get; set; }
    public int Pin { get; set; }
    public string Stcd { get; set; }
  }

  public class SellerDtls
  {
    public string Gstin { get; set; }
    public string LglNm { get; set; }
    public string TrdNm { get; set; }
    public string Addr1 { get; set; }
    public string Addr2 { get; set; }
    public string Loc { get; set; }
    public int Pin { get; set; }
    public string Stcd { get; set; }
  }

  public class ExpShipDtls
  {
    public string LglNm { get; set; }
    public string Addr1 { get; set; }
    public string Loc { get; set; }
    public int Pin { get; set; }
    public string Stcd { get; set; }
  }

  public class DispDtls
  {
    public string Nm { get; set; }
    public string Addr1 { get; set; }
    public string Addr2 { get; set; }
    public string Loc { get; set; }
    public int Pin { get; set; }
    public string Stcd { get; set; }
  }

  public class ItemList
  {
    public string ProdName { get; set; }
    public string ProdDesc { get; set; }
    public string HsnCd { get; set; }
    public int Qty { get; set; }
    public string Unit { get; set; }
    public int AssAmt { get; set; }
    public int CgstRt { get; set; }
    public int? CgstAmt { get; set; }
    public int SgstRt { get; set; }
    public int? SgstAmt { get; set; }
    public int IgstRt { get; set; }
    public int? IgstAmt { get; set; }
    public int CesRt { get; set; }
    public int CesAmt { get; set; }
    public int OthChrg { get; set; }
    public int CesNonAdvAmt { get; set; }
  }

  public class Root
  {
    public string DocumentNumber { get; set; }
    public string DocumentType { get; set; }
    public string DocumentDate { get; set; }
    public string SupplyType { get; set; }
    public string SubSupplyType { get; set; }
    public string SubSupplyTypeDesc { get; set; }
    public string TransactionType { get; set; }
    public BuyerDtls BuyerDtls { get; set; }
    public SellerDtls SellerDtls { get; set; }
    public ExpShipDtls ExpShipDtls { get; set; }
    public DispDtls DispDtls { get; set; }
    public List<ItemList> ItemList { get; set; }
    // public ItemList ItemList { get; set; }
    public int TotalInvoiceAmount { get; set; }
    public int TotalCgstAmount { get; set; }
    public int TotalSgstAmount { get; set; }
    public int TotalIgstAmount { get; set; }
    public int TotalCessAmount { get; set; }
    public int TotalCessNonAdvolAmount { get; set; }
    public int TotalAssessableAmount { get; set; }
    public int OtherAmount { get; set; }
    public int OtherTcsAmount { get; set; }
    public string TransId { get; set; }
    public string TransName { get; set; }
    public string TransMode { get; set; }
    public int Distance { get; set; }
    public string TransDocNo { get; set; }
    public string TransDocDt { get; set; }
    public string VehNo { get; set; }
    public string VehType { get; set; }
  }
  public class Ewaybillfile
  {
    public List<ulong> ewb_numbers { get; set; }
    //public List<ewb_no> ItemList { get; set; }
    public string print_type { get; set; }
  }

  public class ewb_no
  {
    public ulong ewb_numbers { get; set; }
  }

}
