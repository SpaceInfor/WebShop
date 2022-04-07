using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Net;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace WebShop
{
  public partial class BrandMaster : System.Web.UI.Page
  {
    private static string message = string.Empty;
    private static string message1 = string.Empty;
    private static string Errormessage = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst175100> GetBrandDetails()
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst175100> lst = new List<ttdtst175100>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_BrandMaster]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@Action", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttdtst175100
            {
              t_brid = sdr["t_brid"].ToString(),
              t_cbrn = sdr["t_cbrn"].ToString(),
              t_brnd = sdr["t_brnd"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }

    }

    [System.Web.Services.WebMethod]
    public static String[] saveInputBrand(string t_brid, string t_cbrn, string t_brnd, string Action)
    //, string t_cwoc, string t_mcrt, string t_mccp,string t_mdcp,
    {

      //string i_tano;
      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;

      if (t_brid == "")
      {
        sqlcom.Parameters.AddWithValue("@t_brid", null);
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_brid", t_brid);
      }
      sqlcom.Parameters.AddWithValue("@t_cbrn", t_cbrn);
      sqlcom.Parameters.AddWithValue("@t_brnd", t_brnd);
      sqlcom.Parameters.AddWithValue("@Action", Action);
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);

      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "testdb..[WS_BrandMaster]";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString();
        msg1 = result;

        string comb = i_msg;
        output = comb.Split(',');
      
        if (result == "success")
        {
          return output;
        }
        else
        {
          string comb1 = result;
          output = comb1.Split(',');
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      //return output;
    }

    [WebMethod]
    public static int deleteBrand(string t_brid)
    {
      int i;
      using (SqlConnection con = new SqlConnection(cs))
      {
        con.Open();

        SqlCommand com = new SqlCommand("testdb..[WS_BrandMaster]", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Action", "D");
        com.Parameters.Add("@message", SqlDbType.VarChar, 500);
        com.Parameters["@message"].Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@t_brid", t_brid);
        i = com.ExecuteNonQuery();
        message = (string)com.Parameters["@message"].Value.ToString();
        con.Close();
      }

      return i;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst175100> GetBrandLines(string t_brid)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("testdb..[WS_BrandMaster]"))
        {
          cmd.Connection = con;
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@Action", "S");
          cmd.Parameters.Add(new SqlParameter("@t_brid", t_brid));
          cmd.Parameters.Add("@message", SqlDbType.VarChar, 500);
          cmd.Parameters["@message"].Direction = ParameterDirection.Output;
          List<ttdtst175100> InputLines = new List<ttdtst175100>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              InputLines.Add(new ttdtst175100
              {
                t_brid = sdr["t_brid"].ToString(),
                t_cbrn = sdr["t_cbrn"].ToString(),
                t_brnd = sdr["t_brnd"].ToString()
              });
            }

            con.Close();
            message = (string)cmd.Parameters["@message"].Value.ToString();
            return InputLines;
          }
        }
      }
    }
  }
  public class ttdtst175100
  {

    public string t_brid { get; set; }
    public string t_cbrn { get; set; }
    public string t_brnd { get; set; }

  }
}
