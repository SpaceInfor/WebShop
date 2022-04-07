using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace WebShop
{
  public partial class OrderDashboard : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        GetOrderList();
      }
    }
    protected void GetOrderList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      //SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
      SqlComm.Parameters.AddWithValue("@t_euni", "SW-T48");
      SqlComm.Parameters.AddWithValue("@type", "WEBHEAD");
      SqlComm.CommandText = "WS_OrderDashboard";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><a href='WebOrderBooking.aspx?ORD="+dr["t_qorn"].ToString()+"'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + dr["t_qorn"].ToString() + "</td><td>" + dr["t_quot"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td><td>" + dr["t_corn"].ToString() + "</td><td>" + dr["t_refb"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_amnt"].ToString() + "</td><td><span class='" + dr["t_colr"].ToString() + "'>"+ dr["t_stat"].ToString() + "</span></td></tr>";
          }
        }
        order.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
      Response.Redirect("WebOrderBooking.aspx");
    }
  }
}
