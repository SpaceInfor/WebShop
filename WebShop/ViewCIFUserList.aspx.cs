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
  public partial class ViewCIFUserList : System.Web.UI.Page
  {
    private static string message = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst250100_User> GetCIFUserDetails(string t_usid)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst250100_User> lst = new List<ttdtst250100_User>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_UserRegistration]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add(new SqlParameter("@t_usid", t_usid));
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
         
          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttdtst250100_User
            {
              t_usid = sdr["t_usid"].ToString(),
              t_pass = sdr["t_pass"].ToString(),
              t_emai = sdr["t_emai"].ToString(),
              t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
              t_nama = sdr["t_nama"].ToString(),
              t_type = sdr["t_type"].ToString()
           
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
  }
}
