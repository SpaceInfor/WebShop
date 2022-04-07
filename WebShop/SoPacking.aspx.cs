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
  public partial class SoPacking : System.Web.UI.Page
  {
    String Sales_Order;
   
    protected void Page_PreInit(object sender, EventArgs e)
    {
      Master.ContentCallEvent += new EventHandler(Master_TextChanged);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["t_usid"] == null)
      {
        Response.Redirect("CustLogin.aspx");
      }
      if (Request.QueryString["t_orno"] != null)
      {
        Sales_Order = Request.QueryString["t_orno"].ToString();
      }
      if (!IsPostBack)
      {
        //GetOrderList();
        GetPackingList(Sales_Order);
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      GetPackingList(Sales_Order);
    }
    protected void GetPackingList(String t_orno)
    {
      string tabl;
      tabl = "";
      int count;
      count = 0;
      int i;
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.CommandTimeout = 0;
      //SqlComm.Parameters.AddWithValue("@t_ofbp",Session["t_usid"].ToString());
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_orno", t_orno);
      SqlComm.Parameters.AddWithValue("@t_sect", "ORD");
      SqlComm.CommandText = "WS_GetPackingList";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          tabl = tabl + "<tr><td>" + sProdPlanData.Rows[i]["bp_code_name"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_orno"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_boxn"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cdf_cdsc"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qoor"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_bqty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cuni"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_ptyp"].ToString() + "</td></td></tr>";
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
