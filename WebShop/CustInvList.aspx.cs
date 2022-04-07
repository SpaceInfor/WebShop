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
  public partial class CustInvList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      
      if (!IsPostBack)
      {
        GetInvList();
      }
    }
    protected void GetInvList()
    {
      string tabl;
      tabl = "";
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_prbp",Session["t_usid"].ToString());
      SqlComm.CommandText = "WS_CustInvList";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_idoc"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_lrno"].ToString() + "</td><td>" + dr["t_lrdt"].ToString() + "</td><td>" + dr["t_lyno"].ToString() + "</td><td>" + dr["t_name"].ToString() + "</td><td>" + dr["t_fpon"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_dqua"].ToString() + "</td><td>" + dr["t_cuni"].ToString() + "</td><td>" + dr["t_pric"].ToString() + "</td><td>"+ dr["t_amti"].ToString() + "</td><td>"+ dr["t_orno"].ToString() + "</td><td>" + dr["t_worn"].ToString() + "</td></tr>";
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
      Response.Redirect("CustOrderBooking.aspx?SCP=1");
    }

  }
}
