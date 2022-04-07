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
using System.Web.Services;

namespace WebShop
{
  public partial class BookingList : System.Web.UI.Page
  {
    private static string message = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["t_usid"] != null)
      {
        HttpContext.Current.Session["t_usid"] = Session["t_usid"].ToString();
      }
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst171100> GetBookingHeaders(string t_prbp)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst171100> Prdlst = new List<ttdtst171100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_AddBooking]", con);
          comm.CommandType = CommandType.StoredProcedure;

          comm.Parameters.AddWithValue("@t_prbp", t_prbp);
          comm.Parameters.AddWithValue("@t_flag", "H");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst171100
            {
              t_link = sdr["t_link"].ToString(),
              t_bkno = sdr["t_bkno"].ToString(),
              t_date = sdr["t_date"].ToString(),
              t_prbp = sdr["t_prbp"].ToString(),
              t_srep = sdr["t_srep"].ToString(),
              scbpdesc = sdr["scbpdesc"].ToString(),
              t_tdlg = sdr["t_tdlg"].ToString(),
              t_amnt = Convert.ToSingle(sdr["t_amnt"].ToString()),
              t_advc = Convert.ToSingle(sdr["t_advc"].ToString()),

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Prdlst;
        }

      }
      catch (Exception ex)
      {
        throw ex;
      }
    }
  }


  public class ttdtst171100
  {
    public string t_link { get; set; }
    public string t_bkno { get; set; }
    public string t_date { get; set; }
    public string t_prbp { get; set; }
    public string t_srep { get; set; }
    public string t_scbp { get; set; }
    public string scbpdesc { get; set; }
    public string t_tdlg { get; set; }
    public float t_amnt { get; set; }
    public float t_advc { get; set; }

  }
}
