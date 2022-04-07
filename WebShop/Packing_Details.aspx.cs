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
  public partial class Packing_Details : System.Web.UI.Page
  { 
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        GetInventory();
      }
    }
    protected void GetInventory()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
      SqlComm.Parameters.AddWithValue("@type", "PACK");
      SqlComm.CommandText = "WS_GetInvDashboard_Details";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_bpid"].ToString() + "</td><td>" + dr["t_lobn"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_desc"].ToString() + "</td><td>" + dr["t_open"].ToString() + "</td><td>" + dr["t_cuni"].ToString() + "</td></tr>";
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
