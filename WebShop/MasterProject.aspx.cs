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
  public partial class MasterProject : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!Page.IsPostBack)
      {
        
      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String bind_MasterProject(string t_prbp)
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
      SqlComm.Parameters.AddWithValue("@t_prbp", t_prbp);
      SqlComm.CommandText = "WS_getMasterProject";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><span class='badge bg-warning'>" + dr["t_cprj"].ToString() + "</span></td><td>" + dr["t_pnam"].ToString() + "</td><td>" + dr["t_pinf"].ToString() + "</td></tr>";
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
    public static String ProcessIT(string t_pnam, string t_pinf)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom  = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_prbp", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_pnam", t_pnam);
      sqlcom.Parameters.AddWithValue("@t_pinf", t_pinf);
      sqlcom.CommandText = "WS_SaveMasterProject";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
      return "";
    }
  }
}
