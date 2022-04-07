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
namespace AdminMaster
{
  public partial class CS_PDIEntry : System.Web.UI.Page
  {
    private static string message = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst180100> GetPIDDetails()
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst180100> Processlst = new List<ttdtst180100>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("testdb..[WS_SaveSOPDI]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Processlst.Add(new ttdtst180100
            {
              t_orno = sdr["t_orno"].ToString(),
              t_pdiu = sdr["t_pdiu"].ToString(),
              t_pdid = sdr["t_pdid"].ToString(),
              t_pdim = sdr["t_pdim"].ToString(),
              t_pdst = sdr["t_pdst"].ToString()
            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Processlst;
        }
      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst180100> ListPIDIdWise(string t_orno)
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst180100> Processlst = new List<ttdtst180100>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("testdb..[WS_SaveSOPDI]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add(new SqlParameter("@t_orno", t_orno));
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Processlst.Add(new ttdtst180100
            {
              t_orno = sdr["t_orno"].ToString(),
              t_pdiu = sdr["t_pdiu"].ToString(),
              t_pdid = sdr["t_pdid"].ToString(),
              t_pdim = sdr["t_pdim"].ToString(),
              t_pdst = sdr["t_pdst"].ToString()
          


            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Processlst;
        }
      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

    [System.Web.Services.WebMethod]
    public static String[] saveInputPDI(string t_orno, string t_pdiu, string t_pdim, string t_pdst, string t_flag)
    //, string t_opno, string t_seqn, string t_ostp
    {

      //string i_tano;
      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;

      if (t_orno == "")
      {
        sqlcom.Parameters.AddWithValue("@t_orno", null);
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_orno", t_orno);
      }


     
      sqlcom.Parameters.AddWithValue("@t_pdiu", t_pdiu);
      sqlcom.Parameters.AddWithValue("@t_pdim", t_pdim);
      sqlcom.Parameters.AddWithValue("@t_pdst", t_pdst);
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      //sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "testdb..[WS_SaveSOPDI]";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString();
        //HttpContext.Current.Session.Add("t_tano", i_tano);
        msg1 = result;
        //string comb = i_tano + "," + i_msg;
        string comb = i_msg;
        output = comb.Split(',');
        //output = comb.ToString();
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
  }
  public class ttdtst180100
  {

    public string t_orno { get; set; }
    public string t_pdiu { get; set; }
    public string t_pdid { get; set; }
    public string t_pdim { get; set; }
    public string t_pdst { get; set; }
   
  }
}
