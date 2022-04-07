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
  public partial class BookedbutnotloggedIn : System.Web.UI.Page
  {
    private static string message = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst172100> BindBookingItemDetails(string t_prbp)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst172100> Prdlst = new List<ttdtst172100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_AddBookingItemWiseReport]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_prbp", t_prbp);
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;


          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst172100
            {
              //t_link = sdr["t_link"].ToString(),
              t_bkno = sdr["t_bkno"].ToString(),
              t_item = sdr["t_item"].ToString(),
              t_itemdsca = sdr["t_itemdsca"].ToString(),
              t_pric = Convert.ToSingle(sdr["t_pric"].ToString()),
              t_qoor = Convert.ToSingle(sdr["t_qoor"].ToString()),
              t_oamt = Convert.ToSingle(sdr["t_oamt"].ToString()),
              t_qtno = sdr["t_qtno"].ToString()
              //BookStatus = sdr["BookStatus"].ToString()


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

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst172100> BindAllBookingDetails()
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst172100> Prdlst = new List<ttdtst172100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_AddBookingItemWiseReport]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "AB");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst172100
            {
              //t_link = sdr["t_link"].ToString(),
              t_bkno = sdr["t_bkno"].ToString(),
              t_item = sdr["t_item"].ToString(),
              t_itemdsca = sdr["t_itemdsca"].ToString(),
              t_pric = Convert.ToSingle(sdr["t_pric"].ToString()),
              t_qoor = Convert.ToSingle(sdr["t_qoor"].ToString()),
              t_oamt = Convert.ToSingle(sdr["t_oamt"].ToString()),
              t_qtno = sdr["t_qtno"].ToString(),
              t_nama = sdr["t_nama"].ToString()
              //BookStatus = sdr["BookStatus"].ToString()
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
}
