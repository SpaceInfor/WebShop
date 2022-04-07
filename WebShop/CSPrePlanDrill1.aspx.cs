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
  public partial class CSPrePlanDrill1 : System.Web.UI.Page
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
      int count,i;
      count = 0;
      i = 0;
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
      SqlComm.Parameters.AddWithValue("@t_sect", "PPDR");
      SqlComm.CommandText = "WS_CustOrderList_details";
      //DataSet sProdPlanData = new DataSet();
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {   
          if (Convert.ToInt16(sProdPlanData.Rows[i]["t_qoor"]) > Convert.ToInt16(sProdPlanData.Rows[i]["t_prep"]))
          {
              tabl = tabl + "<tr><td><a href='CustOrderEdit.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + sProdPlanData.Rows[i]["t_bpid"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["bp_code_name"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qtyp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_incl"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dlcd"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_hdst"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qoor"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cuni"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_oamt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_pdno"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_podt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cwar"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_clco"].ToString() + "</td> </tr>";
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
