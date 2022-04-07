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
using System.Web.Script.Services;

namespace WebShop
{
  public partial class Department_Master : System.Web.UI.Page
  {
    private static string message = string.Empty;
    private static string message1 = string.Empty;
    private static string Errormessage = string.Empty;

    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst167100> GetDepartmentDetails()
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst167100> Prdlst = new List<ttdtst167100>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("testdb..[wh_Department]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
          comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst167100
            {
              t_dept = sdr["t_dept"].ToString(),
              t_desc = sdr["t_desc"].ToString(),

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

    [System.Web.Services.WebMethod]
    public static String[] saveDepartment(string t_dept, string t_desc, string t_flag)
   
    {

      string i_msg;
      i_msg = "";
      string[] output = new string[] { "", "" };
      WebDataAccess NBData = new WebDataAccess();
      WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;

      if (t_dept == "")
      {
        sqlcom.Parameters.AddWithValue("@t_dept", null);
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_dept", t_dept);
      }

      sqlcom.Parameters.AddWithValue("@t_desc", t_desc);
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);

      sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);

      sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "testdb..[wh_Department]";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
        i_msg = (string)sqlcom.Parameters["@t_mesg"].Value.ToString();

        msg1 = result;

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

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst167100> GetDepartmentWise(string t_dept)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("testdb..[wh_Department]"))
        {
          cmd.Connection = con;
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@t_flag", "S");
          cmd.Parameters.Add(new SqlParameter("@t_dept", t_dept));
          cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
          cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
          List<ttdtst167100> InputLines = new List<ttdtst167100>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              InputLines.Add(new ttdtst167100
              {
                t_dept = sdr["t_dept"].ToString(),
                t_desc = sdr["t_desc"].ToString(),
              });
            }

            con.Close();
            message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
            return InputLines;
          }
        }
      }
    }

    [WebMethod]
    public static int deleteDepartment(string t_dept)
    {
      int i;
      using (SqlConnection con = new SqlConnection(cs))
      {
        con.Open();

        SqlCommand com = new SqlCommand("testdb..[wh_Department]", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@t_flag", "D");
        com.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
        com.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@t_dept", t_dept);
        i = com.ExecuteNonQuery();
        message = (string)com.Parameters["@t_mesg"].Value.ToString();
        con.Close();
      }

      return i;
    }
  }
  public class ttdtst167100
    {
    public string t_dept { get; set; }
    public string t_desc { get; set; }
  }
}
