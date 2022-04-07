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
  public partial class SoDelDate : System.Web.UI.Page
  {
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
      if (!IsPostBack)
      {
        //GetOrderList();
        GetOrderList_New();
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      GetOrderList_New();
    }
    protected void GetOrderList_New()
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
        SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_sect", "UPD");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          tabl = tabl + "<tr><td>" + sProdPlanData.Rows[i]["bp_code_name"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmrk"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qtyp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Amount"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Dispatched_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dldt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_devi"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_apst"].ToString() + "</td><td><a href='ExceptionForm.aspx?ORD=" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'><i class='fa fa-fw fa-object-ungroup'></i></a></td></tr>";
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
