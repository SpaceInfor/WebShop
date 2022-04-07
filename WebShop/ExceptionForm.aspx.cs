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
namespace WebShop
{
  public partial class ExceptionForm : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!Page.IsPostBack)
      {
        if (!IsPostBack)
        {
          if (Request.QueryString["ORD"] != null)
          {
            orderid.InnerText = Request.QueryString["ORD"].ToString();
          }
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String bind_SoExceptions(string t_orno)
    {
      string tabl;
      Double r_qnty, r_amnt;
      r_qnty = 0;
      r_amnt = 0;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_orno", t_orno);
      SqlComm.CommandText = "WS_GetSoExceptions";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><span class='badge bg-warning'>" + dr["t_orno"].ToString() + "</span></td><td>" + dr["t_rmsh"].ToString() + "</td><td>" + dr["t_dldt"].ToString() + "</td><td>" + dr["t_devi"].ToString() + "</td><td>" + dr["t_lmdt"].ToString() + "</td></tr>";
          }
        }
        return tabl;
      }
      catch (Exception ex)
      {
        return "";
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string t_orno,string t_rmsh,string t_dldt, string t_devi)

    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom  = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_orno", t_orno);
      sqlcom.Parameters.AddWithValue("@t_rmsh", t_rmsh);
      sqlcom.Parameters.AddWithValue("@t_devi", t_devi);
      sqlcom.Parameters.AddWithValue("@t_dldt", Convert.ToDateTime(t_dldt));
      sqlcom.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_SaveSoExceptions";
      string result = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        return (string)sqlcom.Parameters["@new_identity"].Value;
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
    }
  }
}
