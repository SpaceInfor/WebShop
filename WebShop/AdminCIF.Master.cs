using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
  public partial class AdminCIF : System.Web.UI.MasterPage
  {
    //string userid;
    public event EventHandler ContentCallEvent;
    protected void Page_Load(object sender, EventArgs e)
    {
      try
      {
        if (!IsPostBack)
        {
          if (Session["t_usid"] == null)
          {
            //userid = Request.QueryString["UID"].ToString();
            //username.Text = getusername();
            Response.Redirect("CIFUserLogin.aspx");
          }
          //else
          //{
          //    userid = Session["t_usid"].ToString();
          //    username.Text = getusername();  
          //}
        }
      }
      catch (Exception ex)
      {
        errordiv.InnerHtml = ex.Message.ToString();
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
        errordiv.InnerHtml = ex.Message.ToString();
      }
    }
  }
}
