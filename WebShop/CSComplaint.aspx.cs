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
  public partial class CSComplaint : System.Web.UI.Page
  {
    String userid;
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        if(Request.QueryString["t_dorn"]!=null)
          HttpContext.Current.Session.Add("t_dorn", Request.QueryString["t_dorn"].ToString());
      }
      if (Session["t_usid"].ToString() == null)
      {
        userid = Request.QueryString["UID"].ToString();
      }
      else
      {
        userid = Session["t_usid"].ToString();
      }

    }
    [System.Web.Services.WebMethod]
    public static String[] SaveComplaint(string t_cono,string t_worn,string t_orno,
      string t_rsol, string t_cost,string t_flag)
    {
      
      string i_cono;
      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      if (t_flag.Equals("U"))
      {
        sqlcom.Parameters.AddWithValue("@t_cono", t_cono);
      }
      sqlcom.Parameters.AddWithValue("@t_worn", t_worn);
      sqlcom.Parameters.AddWithValue("@t_rsol", t_rsol);
      sqlcom.Parameters.AddWithValue("@t_cost", 3);
      sqlcom.Parameters.AddWithValue("@t_user",HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      sqlcom.Parameters.Add("@message", SqlDbType.Char, 500);
      
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_Customer_Complaint";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_cono = (string)sqlcom.Parameters["@new_identity"].Value;
        i_msg = (string)sqlcom.Parameters["@message"].Value;
        msg1 = result;
        string comb = i_cono + "," + i_msg;
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
    [System.Web.Services.WebMethod]
    public static String[] SaveComplaintLine(string t_cono, string t_rsol)
    {

      string i_cono;
      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_cono", t_cono);
      sqlcom.Parameters.AddWithValue("@t_rsol", t_rsol);
      
      sqlcom.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.Add("@message", SqlDbType.Char, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_Customer_Complaint_Lines";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_msg = (string)sqlcom.Parameters["@message"].Value;
        msg1 = result;
        string comb = i_msg + "," + "";
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

    [System.Web.Services.WebMethod]
    public static String[] Acknoledge_complaint(string t_cono)
    {

      string i_cono;
      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_cono", t_cono);
      sqlcom.Parameters.AddWithValue("@t_flag", "A");
      sqlcom.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.Add("@message", SqlDbType.Char, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_Customer_Complaint";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_msg = (string)sqlcom.Parameters["@message"].Value;
        msg1 = result;
        string comb = t_cono + "," + i_msg;
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
    public static List<classes.ttdtst142100> GetComplaintLines(string t_cono_code)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select t_cono,t_pono,convert(nvarchar,t_date,103) as t_date,t_rsol,t_user from swlive..ttdtst142100 where t_cono = @t_cono"))
        {
          cmd.Connection = con;
         
          cmd.Parameters.AddWithValue("@t_cono", t_cono_code);
         
          List<classes.ttdtst142100> ComplaintLines = new List<classes.ttdtst142100>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              ComplaintLines.Add(new classes.ttdtst142100
              {
                t_cono = sdr["t_cono"].ToString(),
                t_pono = sdr["t_pono"].ToString(),
                t_date = sdr["t_date"].ToString(),
           
                t_rsol = sdr["t_rsol"].ToString(),
                t_user = sdr["t_user"].ToString()            
              });
            }

            con.Close();
            return ComplaintLines;
          }
        }
      }
    }


   
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetComplaintData(string t_cono)
    {
      string jsonData = "";
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select cps.t_cono,cps.t_worn,cps.t_orno,cps.t_prbp,bp.t_nama,cps.t_comt,case cps.t_prio when 4 then 'High' when 5 then 'Medium' when 6 then 'Low' end as t_prio,bp.t_nama,t_cost from swlive..ttdtst141100 cps  join swlive..ttccom100100 bp on (bp.t_bpid = cps.t_prbp) where t_cono = @t_cono", con))
        {
          cmd.Parameters.AddWithValue("@t_cono", t_cono);

          con.Open();
          SqlDataReader sdr = cmd.ExecuteReader();
          if (sdr.Read())
          {
            var input = new
            {
              t_cono = sdr["t_cono"],
              t_worn = sdr["t_worn"],
              t_orno = sdr["t_orno"],
              t_bpid = sdr["t_prbp"],
              t_nama = sdr["t_nama"],
              t_comt = sdr["t_comt"],
              t_prio = sdr["t_prio"],
              t_cost = sdr["t_cost"]

            };
            jsonData = (new JavaScriptSerializer()).Serialize(input);
          }
          con.Close();
        }
      }

      return jsonData;
    }

    public class ttdtst152100
    {
      public string t_worn { get; set; }
      public string t_orno { get; set; }
      public string t_prbp { get; set; }
      public string t_nama { get; set; }
    }

    public class ttdtst14100
    {
      public string t_cono { get; set; }

      public string t_codt { get; set; }
      public string    t_worn { get; set; }
      public string t_orno { get; set; }
      
      public string t_prbp { get; set; }
      public string t_rsol { get; set; }
      public string    t_comt { get; set; }

      public string t_cost { get; set; }
      public string t_user { get; set; }
      public string t_cldt { get; set; }
    }
   
  }
}
