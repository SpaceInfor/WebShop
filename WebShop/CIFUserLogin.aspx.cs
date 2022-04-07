using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Data;
using System.Data.SqlClient;
using System.IO;


namespace WebShop
{
  public partial class CIFUserLogin : System.Web.UI.Page
  {
    string exception;
    string Empname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {

      }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
      string username = usrid.Text.ToString();
      string password = paswd.Text.ToString();

      //Session.Add("t_orno", null);

      if (username == "") { usrid.Focus(); Msg.Visible = true; Msg.Text = "User name is not supplied."; return; }
      if (password == "") { paswd.Focus(); Msg.Visible = true; Msg.Text = "Password is not supplied."; return; }

      bool verify = false;
      verify = VerifyEmp(username, password);

      if (verify)
      {
        string Unit = "";
        //int company = 0;
        //Session.Add("Company", "100");
        //Session.Add("t_bpid", null);
        
        Response.Cookies["userid"].Value = usrid.Text;
        Response.Cookies["pwd"].Value = paswd.Text;
        Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
        Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);
        if (Session["t_type"].ToString() == "8")
        {
          Response.Redirect("CIFFormList.aspx" + "?UID=" + username + "&PID=&TID=", false);
          return;
        }
        if (Session["t_type"].ToString() == "9")
        {
          Response.Redirect("CIFFormList.aspx" + "?UID=" + username + "&PID=&TID=", false);
          return;
        }
        
      }
      else
      {
        username = "";
        password = "";
        usrid.Text = "";
        paswd.Text = "";
        Msg.Text = "Wrong combination of Username and Password" + " Live " + exception;
        usrid.Focus();
      }
    }

    protected bool VerifyEmp(string username, string password)
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
        //String sQuery = "select t1.t_usid,t1.t_pass,t1.t_type,t1.t_nama,t2.t_usid,t2.t_dept,t3.t_desc,t2.t_levl from swlive..ttdtst250100 t1 left outer join swlive..ttdtst170100 t2 on t1.t_usid = t2.t_usid left outer join swlive..ttdtst167100 t3 on t2.t_dept = t3.t_dept where t1.t_usid ='" + username + "' and t_pass = '" + password + "'  and t_exdt = '1970-01-01 00:00:00.000'";
        String sQuery = "select t_usid,t_pass,t_emai,t_stat,t_nama,t_type,t_exdt from swlive.dbo.ttdtst250100 where t_usid ='" + username + "' and t_pass = '" + password + "' and t_exdt = '1970-01-01 00:00:00.000'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();

        if (tab.Rows.Count > 0)
        {
          Session.Add("t_usid", tab.Rows[0]["t_usid"].ToString());
          Empname = tab.Rows[0]["t_nama"].ToString();
          Session.Add("t_nama", Empname);
          Session.Add("t_type", tab.Rows[0]["t_type"].ToString());
          return true;
        }
        else
        {
          return false;
        }
      }
      catch (Exception ex)
      {
        exception = ex.Message;
        return false;
      }
    }

  }
}
