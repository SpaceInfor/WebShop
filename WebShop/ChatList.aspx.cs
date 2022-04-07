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
  public partial class ChatList : System.Web.UI.Page
  {
    void Page_PreInit(Object sender, EventArgs e)
    {
      if (Session["t_type"].ToString().Equals("1"))
        this.MasterPageFile = "~/AdminMaster.master";
      else
        this.MasterPageFile = "~/WebShop.master";

    }
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["t_usid"] == null)
      {
        Response.Redirect("CustLogin.aspx");
      }
     // if (!IsPostBack)
     // {
        GetChatList();
      //}
    }
    
    protected void GetChatList()
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
      if (Session["t_type"].ToString() == "4")
      {
        SqlComm.Parameters.AddWithValue("@t_usid", Session["t_usid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_mode", "LC");
      SqlComm.CommandText = "WS_CustomerChat";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          tabl = tabl + "<tr><td><div class='card'><div class='card-body p-0'><ul class='products-list product-list-in-card pl-2 pr-2'><li class='item'><div class='product-img'><img src='" + sProdPlanData.Rows[i]["t_ipth"].ToString() + "' alt='User Image' class='img-size-50'></div><div class='product-info'><a href='ChatSupport.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "' class='product-title'>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "<span class='badge badge-warning float-right'>"+ sProdPlanData.Rows[i]["t_ago"].ToString() + "</span></a><span class='product-description'>" + sProdPlanData.Rows[i]["t_cmsg"].ToString() + "</span></div></li</ul></div></div></td></tr>";
        }
        chatlist.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }



    protected void btnBack_Click(object sender, EventArgs e)
    {
      if (Session["t_type"].ToString() == "4")
      {
        Response.Redirect("BuyerDashboard.aspx");
      }
      else
      {
        Response.Redirect("CSDashboard.aspx");
      }
    }
  }
}
