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
    public partial class RedirectionPage : System.Web.UI.Page
    {
    string ord;
        protected void Page_Load(object sender, EventArgs e)
        {
          if(Request.QueryString["ORD"]!=null)
          {
            ord = Request.QueryString["ORD"].ToString();
          }
          else
          {
            ord = "";
          }
          if (!Page.IsPostBack)
          {
            getOrderDetails(ord);
          }
        }
        protected void getOrderDetails(string t_worn)
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
            String sQuery = "select * from swlive..ttdtst152100 where t_worn='" + t_worn + "'";
            SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
            da.Fill(tab);
            Con.Close();
            Con.Dispose();

            if (tab.Rows.Count > 0)
            { 
              Ordid.InnerText = tab.Rows[0]["t_worn"].ToString();
              itemid.InnerText = tab.Rows[0]["t_dsca"].ToString();
              qty.InnerText = tab.Rows[0]["t_qnty"].ToString();
            }
            else
            {
            }
          }
          catch (Exception ex)
          {
          }
    }

    }
}
