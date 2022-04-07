using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
namespace WebShop
{
  public partial class ChatSupport : System.Web.UI.Page
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
      if (!IsPostBack)
      {
        if (Request.QueryString["ORD"] != null)
        {
          t_worn.Text = Request.QueryString["ORD"].ToString();
        }
      }
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string t_worn, string t_cmsg)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_worn", t_worn);
      sqlcom.Parameters.AddWithValue("@t_usid", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_cmsg", t_cmsg);
      sqlcom.Parameters.AddWithValue("@t_mode", "A");
      sqlcom.CommandText = "WS_CustomerChat";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
      return "";
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String bind_CustomerChat(string t_worn)
    {
      String Chat;
      Chat = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_worn", t_worn);
      SqlComm.Parameters.AddWithValue("@t_mode", "V");
      SqlComm.CommandText = "WS_CustomerChat";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            if (Convert.ToUInt16(dr["t_type"]) == 1)
            {
              Chat = Chat + "<div class='direct-chat-msg'>";
              Chat = Chat + "<div class='direct-chat-infos clearfix'> ";
              Chat = Chat + "<span class='direct-chat-name float-left'>" + dr["t_nama"].ToString() + "</span>";
              Chat = Chat + "<span class='direct-chat-timestamp float-right'>" + dr["t_date"].ToString() + "</span>";
              Chat = Chat + "</div>";
              Chat = Chat + "<img class='direct-chat-img' src='"+ dr["t_ipth"].ToString()+"' alt='message user image'>";
              Chat = Chat + "<div class='direct-chat-text'>";
              Chat = Chat + dr["t_cmsg"].ToString();
              Chat = Chat + "</div>";
              Chat = Chat + "</div>";
            }
            else
            {
              Chat = Chat + "<div class='direct-chat-msg right'>";
              Chat = Chat + "<div class='direct-chat-infos clearfix'>";
              Chat = Chat + "<span class='direct-chat-name float-right'>" + dr["t_nama"].ToString() + "</span>";
              Chat = Chat + "<span class='direct-chat-timestamp float-left'>" + dr["t_date"].ToString() + "</span>";
              Chat = Chat + "</div>";
              Chat = Chat + "<img class='direct-chat-img' src='" + dr["t_ipth"].ToString() + "' alt='message user image'>";
              Chat = Chat + "<div class='direct-chat-text'>";
              Chat = Chat + dr["t_cmsg"].ToString(); ;
              Chat = Chat + "</div>";
              Chat = Chat + "</div>";
            }
          }
        }
        return Chat;

      }
      catch (Exception ex)
      {
        return "";
      }
    }
  }
}
