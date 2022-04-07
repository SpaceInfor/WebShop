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
    public partial class Login : System.Web.UI.Page
    {
        #region Declaration
        string Mobile = "";
        string Empname = "";
        string etyp = "";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Request.Cookies["userid"] != null)
                //    usrid.Text = Request.Cookies["userid"].Value;
                //if (Request.Cookies["pwd"] != null)
                //    paswd.Text = Request.Cookies["pwd"].Value;
                //if (usrid.Text != "" && paswd.Text != "")
                //{
                //    btnLogin_Click(btnLogin, null);
                //}
                populatebranch();
            }
        }       
        protected void btnLogin_Click(object sender, EventArgs e)
        {  
            string username = usrid.Text.ToString();
            string password = paswd.Text.ToString();

            Session.Add("t_orno", null);

            if (username == "") { usrid.Focus(); Msg.Visible = true; Msg.Text = "User name is not supplied."; return; }
            if (password == "") { paswd.Focus(); Msg.Visible = true; Msg.Text = "Password is not supplied."; return; }
            
              
            bool verify = false;
            verify = VerifyEmp(username, password);

            if (verify)
            {
                string Unit = "";
                int company = 0;
                Session.Add("Company","100");
                Response.Cookies["userid"].Value = usrid.Text;
                Response.Cookies["pwd"].Value = paswd.Text;
                Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);
                Response.Redirect("Default.aspx" + "?UID=" + username + "&PID=&TID=",false);
            }
            else
            {
                username = "";
                password = "";
                usrid.Text = "";
                paswd.Text = "";
                usrid.Focus();
            }
        }
        protected void populatebranch()
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
              String sQuery = "select * from swlive..ttcemm030100"; 
              SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
              da.Fill(tab);
              Con.Close();
              Con.Dispose();

                if (tab.Rows.Count > 0)
                {
                  t_euni.DataSource = tab;
                  t_euni.DataTextField = "t_dsca";
                  t_euni.DataValueField = "t_eunt";
                  t_euni.DataBind();
                }
                else
                {

                }
            }
            catch (Exception ex)
            {

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
                String sQuery = "select * from swlive..ttdtst250100 where t_usid='" + username + "' and t_pass = '" + password + "'";
                SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
                da.Fill(tab);
                Con.Close();
                Con.Dispose();

            if (tab.Rows.Count > 0)
            {
              Session.Add("t_usid", tab.Rows[0]["t_usid"].ToString());
              Empname = tab.Rows[0]["t_nama"].ToString();
              Session.Add("t_nama", Empname);
              Session.Add("t_crus", tab.Rows[0]["t_crus"].ToString());
              return true;
            }
            else
            {
              return false;
            }
            }
            catch (Exception ex)
            {
                return false;
            }
        }


    }
}
