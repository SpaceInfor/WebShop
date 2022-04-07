  using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;


namespace WebShop
{
  public partial class LoadingSlip : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        if (Request.QueryString["ORD"] != null)
        {
          
        }
      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string FinalizeLoading(string t_load)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_load", t_load);
      sqlcom.CommandText = "WSL_FinalizeLoading";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        msg1 = result;
        return "Finalized Successfully";
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return(result);
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String[] ProcessIT(string t_load,string t_orno, string t_carp, string t_lyno, string t_lrno, string t_lrdt, string t_boxs)
    {

      string i_load;
      string i_msg;
      i_load = "";
   
      string t_logn;
      t_logn = "sam";

      string i_lopk = "";

      string[] output= new string[] { "", "" };

      if (t_lrdt == "")
      {
        t_lrdt = "1900-01-01 00:00:00.000";
      }

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_orno", t_orno);
      sqlcom.Parameters.AddWithValue("@t_carp", t_carp); 
      sqlcom.Parameters.AddWithValue("@t_lyno", t_lyno);
      sqlcom.Parameters.AddWithValue("@t_lrno", t_lrno);
      sqlcom.Parameters.AddWithValue("@t_lrdt", Convert.ToDateTime(t_lrdt));
      sqlcom.Parameters.AddWithValue("@t_boxs", t_boxs);
      sqlcom.Parameters.AddWithValue("@t_logn", t_logn);
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      sqlcom.Parameters.Add("@message", SqlDbType.Char, 500);
      sqlcom.Parameters.Add("@loadpacket", SqlDbType.Char, 500);
      if (t_load=="")
      {
        sqlcom.Parameters.AddWithValue("@t_load", null);
        //sqlcom.Parameters.AddWithValue("@t_load", HttpContext.Current.Session["t_load"].ToString());
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_load", t_load);
      }
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@loadpacket"].Direction = ParameterDirection.Output; 
      sqlcom.CommandText = "WSL_SaveLoading";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_load = (string)sqlcom.Parameters["@new_identity"].Value;
        i_msg = (string)sqlcom.Parameters["@message"].Value;
        i_lopk = (string)sqlcom.Parameters["@loadpacket"].Value;
        HttpContext.Current.Session.Add("t_load", i_load);
        msg1 = result;

        string comb = i_load + "," + i_msg + "," + i_lopk;
        output = comb.Split(',');
        if (result == "success")
        {

          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      return output;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static string getcarriername(string t_cfrw)
    {
      string t_dsca;
      t_dsca = "";
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select  t_dsca from swlive..ttcmcs080100 where t_cfrw = '" + t_cfrw + "'"))
        {
          cmd.Connection = con;
          List<LoadingLinesClass> LoadingLines = new List<LoadingLinesClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              t_dsca = sdr["t_dsca"].ToString();
            }
          }
          con.Close();
          return t_dsca;
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<LoadingLinesClass> GetLoadingLines(string t_orno)
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec WSL_GetLoadingLines @t_orno = '" + t_orno + "'"))
        {
          cmd.Connection = con;
          List<LoadingLinesClass> LoadingLines = new List<LoadingLinesClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              LoadingLines.Add(new LoadingLinesClass
              {
                t_item = sdr["t_item"].ToString(),
                t_desc = sdr["t_desc"].ToString(),
                t_cuni = sdr["t_cuni"].ToString(),
                t_bqty = sdr["t_bqty"].ToString(),
                t_boxn = sdr["t_boxn"].ToString(),
                t_boxs = sdr["t_boxs"].ToString(),
                t_scst = sdr["t_scst"].ToString()
              });
            }
          }
          con.Close();
          return LoadingLines;
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] GetPrice(string t_ofbp, string t_item)
    {
        string i_pric;
        string i_unit;
        string[] a_pric;
        i_pric = "";
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_bpid",t_ofbp);
        SqlComm.Parameters.AddWithValue("@item", t_item);
        SqlComm.CommandText = "WS_GetItemMaster";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              i_pric = dr["t_bapr"].ToString() + "," + dr["t_cuni"].ToString();

            }
          }
        }
        catch (Exception ex)
        {
          i_pric = "";
        }
        try
        {
          a_pric  = i_pric.Split(',');
          return a_pric;
        }
        catch (Exception ex)
        {
          return null;
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetSalesOrderDetails(string t_orno)
    {
      string jsonData = "";
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("SELECT top 1 o1.t_orno,t_ofbp + ' - ' + ofbp.t_nama as t_ofbp,t_stbp +' - '+stbp.t_nama as t_stbp,adr.t_ccit as t_dest,pck.t_nopk FROM swlive..ttdsls400100 o1 join swlive..ttccom100100 ofbp on (ofbp.t_bpid = o1.t_ofbp) join swlive..ttccom100100 stbp on(stbp.t_bpid = o1.t_stbp) join swlive..ttccom130100 adr on(adr.t_cadr = o1.t_stad) join swlive..ttdswc100100 pck on (pck.t_orno = o1.t_orno) where o1.t_orno = @t_orno", con))
        {
          cmd.Parameters.AddWithValue("@t_orno", t_orno);
          con.Open();
          SqlDataReader sdr = cmd.ExecuteReader();
          if (sdr.Read())
          {
            var input = new
            {
              t_orno = sdr["t_orno"],
              t_ofbp = sdr["t_ofbp"],
              t_stbp = sdr["t_stbp"],
              t_dest = sdr["t_dest"],
              t_nopk = sdr["t_nopk"]
             
            };
            jsonData = (new JavaScriptSerializer()).Serialize(input);
          }
          con.Close();
        }
      }

      return jsonData;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetLoadingHeader(string t_load)
    {

      string jsonData = "";
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec WSL_GetLoadingHeaders @t_load = '"  + t_load + "'", con))
        {
          //cmd.Parameters.AddWithValue("@t_orno", t_orno);
          con.Open();
          SqlDataReader sdr = cmd.ExecuteReader();
          if (sdr.Read())
          {
            var input = new
            {
              t_load = sdr["t_load"].ToString(),
              t_orno = sdr["t_orno"].ToString(),
              t_ofbp = sdr["t_ofbp"].ToString(),
              t_stbp = sdr["t_stbp"].ToString(),
              t_date = sdr["t_date"].ToString(),
              t_dest = sdr["t_dest"].ToString(),
              t_lyno = sdr["t_lyno"].ToString(),
              t_lrno = sdr["t_lrno"].ToString(),
              t_lrdt = sdr["t_lrdt"].ToString(),
              t_npak = sdr["t_npak"].ToString(),
              t_carp = sdr["t_carp"].ToString(),
              t_lopk = sdr["t_lopk"].ToString(),
              t_stat = sdr["t_stat"].ToString(),
              t_stta = sdr["t_stta"].ToString()

            };
            HttpContext.Current.Session.Add("t_load", sdr["t_load"].ToString());
            jsonData = (new JavaScriptSerializer()).Serialize(input);
          }
          con.Close();
        }
      }
      return jsonData;
    }
  }


  public class LoadingLinesClass
  {

    public string t_item { get; set; }
    public string t_desc { get; set; }
    public string t_cuni { get; set; }
    public string t_bqty { get; set; }
    public string t_boxn { get; set; }
    public string t_boxs { get; set; }
    public string t_scst { get; set; }
  }
  public class LoadingHeaderClass1
  {
    public string t_link { get; set; }
    public string t_load { get; set; }
    public string t_orno { get; set; }
    public string t_ofbp { get; set; }
    public string t_stbp { get; set; }
    public string t_date { get; set; }
    public string t_dest { get; set; }
    public string t_lyno { get; set; }
    public string t_lrno { get; set; }
    public string t_lrdt { get; set; }
    public string t_npak { get; set; }
    public string t_carp { get; set; }
    public string t_lopk { get; set; }
    public string t_stat { get; set; }
    public string t_stta { get; set; }

  }


}
