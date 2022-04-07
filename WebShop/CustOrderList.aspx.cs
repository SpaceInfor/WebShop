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
  public partial class CustOrderList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["t_usid"] == null)
      {
        Response.Redirect("CustLogin.aspx");
      }
      GetOrderList_New();
    }
    
    protected void GetOrderList_New()
      {
      string tabl;
      string dapatri;
      dapatri = "";
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
      SqlComm.Parameters.AddWithValue("@t_ofbp",Session["t_usid"].ToString());
      SqlComm.Parameters.AddWithValue("@t_sect", "DTL");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          if (sProdPlanData.Rows[i]["t_appr"].ToString() != "2")
          {
            dapatri = "disabled=disabled";
          }
          else
          {
            dapatri = "";
          }
          tabl = tabl + "<tr><td><a href='CustOrderEdit.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td><button type='button' " + dapatri + " onclick=ApproveDeviation(" + "'" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'" + "); class='btn btn-block bg-gradient-success btn-sm'><i class='fa fa-fw fa-check'></i></button></td><td>" + sProdPlanData.Rows[i]["t_devi"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmsh"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dldt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cprj"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_scbp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_incl"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dlcd"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_quot"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmrk"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qtyp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Amount"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Production_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Prouced_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Despatch_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Dispatched_Qty"].ToString() + "</td><td><a href='CustFileUpload.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "' data-toggle='lightbox' data-title='Download Files For Customer Portal Orders'><i class='nav-icon fas fa-copy'></i></a></td><td><a href='ChatSupport.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fas fa-comments'></i></a></td><td><a href='SoPacking.aspx?t_orno=" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'><i class='fa fa-fw fa-cubes'></i></a></td><td><a href='CustComplaints.aspx?t_worn=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fas fa-exclamation-triangle'></i></a></td></tr>";
        }
        order.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static String ApproveDeviation(string t_orno)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_orno", t_orno);
      sqlcom.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.CommandText = "WS_ApproveDeviation";
      string result = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        return (result);
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static String GetOrderList_WM()
    {
      string tabl;
      string dapatri;
      dapatri = "";
      tabl = "";
      int count;
      count = 0;
      int i;
      string customerid = HttpContext.Current.Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.CommandTimeout = 0;
      SqlComm.Parameters.AddWithValue("@t_ofbp", HttpContext.Current.Session["t_usid"].ToString());
      SqlComm.Parameters.AddWithValue("@t_sect", "DTL");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          if (sProdPlanData.Rows[i]["t_appr"].ToString() != "2")
          {
            dapatri = "disabled=disabled";
          }
          else
          {
            dapatri = "";
          }
          tabl = tabl + "<tr><td><a href='CustOrderEdit.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td><button type='button' " + dapatri + " onclick=ApproveDeviation(" + "'" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'" + "); class='btn btn-block bg-gradient-success btn-sm'>&nbsp;<i class='fa fa-fw fa-check'></i>&nbsp;</button></td><td>" + sProdPlanData.Rows[i]["t_devi"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmsh"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dldt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cprj"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_scbp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_incl"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dlcd"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_quot"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmrk"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qtyp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Amount"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Production_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Prouced_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Despatch_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Dispatched_Qty"].ToString() + "</td><td><a href='CustFileUpload.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "' data-toggle='lightbox' data-title='Download Files For Customer Portal Orders'><i class='nav-icon fas fa-copy'></i></a></td><td><a href='ChatSupport.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fas fa-comments'></i></a></td></tr>";
        }
        return(tabl);
      }
      catch (Exception ex)
      {
        return("");
      }
    }



    protected void btnAddNew_Click(object sender, EventArgs e)
    {
      Response.Redirect("CustOrderBooking.aspx?SCP=1");
    }

  }
}
