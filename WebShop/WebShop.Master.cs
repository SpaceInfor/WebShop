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
  public partial class WebShop : MasterPage
  {
    string userid;
    protected void Page_Load(object sender, EventArgs e)
    {
      try
      {
        if (!IsPostBack)
        {
          //if (Session["t_usid"] == null)
          //{
          //  //userid = Request.QueryString["UID"].ToString();
          //  //username.Text = getusername();
          //  Response.Redirect("CustLogin.aspx");
          //}
          //else
          //{
          //  userid = Session["t_usid"].ToString();
          //  username.Text = getusername();
          //  bind_chatcount();
          //}
        }
      }
      catch (Exception ex)
      {
        //errordiv.InnerHtml = ex.Message.ToString();
        Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);
        Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);
        //Response.Redirect("Login.aspx?ERRMSG="+ex.Message.ToString());
      }
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
      try
      {
        Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);
        Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);
        Response.Redirect("CustLogin.aspx");
      }
      catch (Exception ex)
      {
        //errordiv.InnerHtml = ex.Message.ToString();
      }
    }


    protected string getusername()
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "select t_nama from swlive..ttdtst250100 where t_usid = '" + userid + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_nama"].ToString());
        }
        else
        {
          return ("");
        }
      }
      catch (Exception ex)
      {
        return ("");
      }
    }
    public void bind_chatcount()
    {
      string tabl;
      tabl = "";
      int count;
      count = 0;
      int i, chatcnt = 0;
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;

      if (Session["t_usid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_usid", Session["t_usid"].ToString());
      }

      SqlComm.Parameters.AddWithValue("@t_mode", "C");
      SqlComm.CommandText = "WS_CustomerChat";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          chatcnt = chatcnt + 1;
          tabl = tabl + "<a href='ChatSupport.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "' class='dropdown-item'><div class='media'>";
          tabl = tabl + "<img src='" + sProdPlanData.Rows[i]["t_ipth"].ToString() + "' alt='User Avatar' class='img-size-50 mr-3 img-circle'>";
          tabl = tabl + "<div class='media-body'><h3 class='dropdown-item-title'>" + sProdPlanData.Rows[i]["t_nama"].ToString();
          tabl = tabl + "<span class='float-right text-sm text-danger'><i class='fas fa-star'></i></span></h3><p class='text-sm'>" + sProdPlanData.Rows[i]["t_cmsg"].ToString() + "</p>";
          tabl = tabl + "<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i>" + sProdPlanData.Rows[i]["t_ago"].ToString() + "</p>";
          tabl = tabl + "</div></div></a>";
          tabl = tabl + "<div class='dropdown-divider'></div>";
        }
        tabl = tabl + "<a href = 'ChatList.aspx' class='dropdown-item dropdown-footer'>See All Messages</a>";
        chatprev.InnerHtml = tabl;
        chatcount.InnerHtml = chatcnt.ToString();
      }
      catch (Exception ex)
      {
      }
    }
  }
}
