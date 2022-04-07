using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebShop
{
  public partial class InprocDrill1 : System.Web.UI.Page
  { 
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        GetInProcessOrder();
      }
    }
    protected void GetInProcessOrder()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_usid"].ToString());
      SqlComm.Parameters.AddWithValue("@t_sect", "INPR");
      SqlComm.CommandText = "WS_CustGetInvDashboard";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_orno"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_oamt"].ToString() + "</td><td>" + dr["t_corn"].ToString() + "</td><td>" + dr["t_refa"].ToString() + "</td><td>" + dr["t_refb"].ToString() + "</td></tr>";
          }
        }
        inventory.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
  }
}
