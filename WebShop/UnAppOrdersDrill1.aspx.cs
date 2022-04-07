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
  public partial class UnAppOrdersDrill1 : System.Web.UI.Page
  { 
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        getUnApprovedOrders();
      }
    }
    protected void getUnApprovedOrders()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_usid"].ToString());
      SqlComm.Parameters.AddWithValue("@t_sect", "UNAP");
      SqlComm.CommandText = "WS_CustGetInvDashboard";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_scbp"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_qnty"].ToString() + "</td><td>" + dr["t_incl"].ToString() + "</td><td>" + dr["t_incl"].ToString() + "</td><td>" + dr["t_dlcd"].ToString() + "</td><td>" + dr["t_quot"].ToString() + "</td></tr>";
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
