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
  public partial class WIPScan : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        string userid;
        //if (Request.QueryString["ORD"] != null)
        //{
        //HttpContext.Current.Session.Add("userid", Request.QueryString["userid"].ToString());
        //}
        //if (Session["t_usid"] == null)
        //{
        //  //userid = Request.QueryString["UID"].ToString();
        //  //username.Text = getusername();
        //  Response.Redirect("CustLogin.aspx");
        //}
        //else
        //{
        //  userid = Session["t_usid"].ToString();

        //}

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
        return (result);
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String[] ProcessIT(string t_cwoc, string t_btch, string t_part)
    {

      string i_load;
      string i_msg;
      i_load = "";

      string t_logn;
      t_logn = "sam";

      string i_lopk = "";

      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_cwoc", t_cwoc);
      sqlcom.Parameters.AddWithValue("@t_btch", t_btch);
      sqlcom.Parameters.AddWithValue("@t_part", t_part);
      sqlcom.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_actn", "I");
      sqlcom.Parameters.Add("@t_mess", SqlDbType.Char, 500);
      sqlcom.Parameters["@t_mess"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "PMS_WIPScan";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);

        i_msg = (string)sqlcom.Parameters["@t_mess"].Value;

        msg1 = result;

        string comb = i_msg + ",";
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
    public static String getWogetworkstationname(string t_cwoc)
    {
      string t_dsca;
      t_dsca = "";
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select  t_dsca from swlive..ttiswc101100 where t_cwoc = '" + t_cwoc + "'"))
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
    public static List<tiswc124> GetWIPLines(string t_cwoc, string t_btch)
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec PMS_WIPScan @t_cwoc = '" + t_cwoc + "',@t_btch = '" + t_btch + "',@t_actn = 'S'"))
        {
          cmd.Connection = con;
          List<tiswc124> wiplines = new List<tiswc124>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              wiplines.Add(new tiswc124
              {
                t_cwoc = sdr["t_cwoc"].ToString(),
                t_dsca = sdr["t_dsca"].ToString(),
                t_btch = sdr["t_btch"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_part = sdr["t_part"].ToString(),
                t_user = sdr["t_user"].ToString(),
              });
            }
          }
          con.Close();
          return wiplines;
        }
      }
    }
  }


  public class tiswc124
  {

    public string t_cwoc { get; set; }
    public string t_dsca { get; set; }
    public string t_btch { get; set; }

    public string t_part { get; set; }
    public string t_date { get; set; }
    public string t_user { get; set; }

  }



}
