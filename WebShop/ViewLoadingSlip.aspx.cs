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
  public partial class ViewLoadingSlip : System.Web.UI.Page
  {
    private static string message = string.Empty;
    private static string message1 = string.Empty;
    private static string Errormessage = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdswc105100> GetLoadingSlipDetails(string t_orno,string t_load)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdswc105100> Prdlst = new List<ttdswc105100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WSL_GetLoadingSlip]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_orno", t_orno);
          comm.Parameters.AddWithValue("@t_load", t_load);
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
          comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
         

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdswc105100
            {

              t_orno = sdr["t_orno"].ToString(),
              t_load = sdr["t_load"].ToString(),
              t_pono = sdr["t_pono"].ToString(),
              t_item = sdr["t_item"].ToString(),
              t_boxn = sdr["t_boxn"].ToString(),
              t_bqty = sdr["t_bqty"].ToString(),
              t_boxs = sdr["t_boxs"].ToString(),
              t_bpid = sdr["t_bpid"].ToString(),
              t_nama = sdr["t_nama"].ToString(),
              t_stbp = sdr["t_stbp"].ToString(),
              t_date = sdr["t_date"].ToString(),
              t_dest =sdr["t_dest"].ToString(),
              t_lyno = sdr["t_lyno"].ToString(),
              t_lrno = sdr["t_lrno"].ToString(),
              t_lrdt = sdr["t_lrdt"].ToString(),
              t_npak = sdr["t_npak"].ToString(),
              t_carp = sdr["t_carp"].ToString(),
              t_dsca = sdr["t_dsca"].ToString(),
              t_stat = sdr["t_stat"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@t_mesg"].Value.ToString();
          return Prdlst;
        }

      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

  }
  public class ttdswc105100
  {

    public string t_load { get; set; }
    public string t_orno { get; set; }
    public string t_pono { get; set; }
    public string t_item { get; set; }
    public string t_boxn { get; set; }
    public string t_bqty { get; set; }
    public string t_boxs { get; set; }
    public string t_bpid { get; set; }
    public string t_nama { get; set; }
    public string t_stbp { get; set; }
    public string t_date { get; set; }
    public string t_dest { get; set; }
    public string t_lyno { get; set; }
    public string t_lrno { get; set; }
    public string t_lrdt { get; set; }
    public string t_npak { get; set; }
    public string t_carp { get; set; }
    public string t_dsca { get; set; }
    public string t_stat { get; set; }
    public string t_flag { get; set; }
  
   
    
  }

}
