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
  public partial class CSProdDrill1 : System.Web.UI.Page
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
        GetOrderList();
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      GetOrderList();
    }
    protected void GetOrderList()
    {
      string tabl;
      tabl = "";
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.CommandTimeout = 0;
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_sect", "PRDR");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><a href='CustOrderEdit.aspx?ORD=" + dr["t_worn"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + dr["t_bpid"].ToString() + "</td><td>" + dr["bp_code_name"].ToString() + "</td><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_qtyp"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_incl"].ToString() + "</td><td>" + dr["t_dlcd"].ToString() + "</td><td>" + dr["Sales_Order"].ToString() + "</td><td>" + dr["Sales_Order_date"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["Sales_Qty"].ToString() + "</td><td>" + dr["t_cuni"].ToString() + "</td><td>" + dr["Sales_Amount"].ToString() + "</td><td>" + dr["t_pdno"].ToString() + "</td><td>" + dr["t_podt"].ToString() + "</td><td>" + dr["t_cwar"].ToString() + "</td><td>" + dr["t_clco"].ToString() + "</td> </tr>";
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
