using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace WebShop
{
  public partial class CIFUserRegistration : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static String[] AddUser(string t_usid, string t_pass, string t_emai, string t_nama)
    {

      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_usid", t_usid);
      sqlcom.Parameters.AddWithValue("@t_pass", t_pass);
      sqlcom.Parameters.AddWithValue("@t_emai", t_emai);
      sqlcom.Parameters.AddWithValue("@t_nama", t_nama);
     

      sqlcom.Parameters.AddWithValue("@t_flag", "I");
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;

      sqlcom.CommandText = "testdb.dbo.[WS_UserRegistration]";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);

        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString().Trim();
        msg1 = result;
        string comb = i_msg;
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
  }
  public class ttdtst250100_User
  {
    public string t_usid { get; set; }
    public string t_pass { get; set; }
    public string t_emai { get; set; }
    public int t_stat { get; set; }
    public string t_nama { get; set; }
    public string t_type { get; set; }

  }
}
