using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;
using System.Threading;
namespace WebShop
{
  public partial class INNOrderLoginDrill1 : System.Web.UI.Page
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
        //GetOrderList();
      
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      //GetOrderList();
     
    }

  

    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetCustomers()
    {
      string r_ofbp;
      r_ofbp = "";
      if (HttpContext.Current.Session["t_bpid"] != null)
      {
        r_ofbp = HttpContext.Current.Session["t_bpid"].ToString();
      }
      else
      {
        r_ofbp = "";
      }
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec WS_CustOrderList_Innopan @t_sect='LDR' , @t_ofbp = '" + r_ofbp + "'"))
        //using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='DTL1'"))
        {
          cmd.Connection = con;
          List<SalesOrderClass> SalesOrders = new List<SalesOrderClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              SalesOrders.Add(new SalesOrderClass
              {
             
                bp_code_name = sdr["bp_code_name"].ToString(),
                t_qorn = sdr["t_qorn"].ToString(),
                t_quot = sdr["t_quot"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_refb = sdr["t_refb"].ToString(),
                t_corn = sdr["t_corn"].ToString(),
               
              
                t_oamt = sdr["t_oamt"].ToString(),
               
                t_cwar = sdr["t_cwar"].ToString(),
                t_cofc = sdr["t_cofc"].ToString()
      


              });
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }



    public class SalesOrderClass
    {
     
      public string bp_code_name { get; set; }
      public string t_qorn { get; set; }
      public string t_date { get; set; }
      public string t_quot { get; set; }
      public string t_corn { get; set; }

      public string t_refb { get; set; }


      public string t_cofc { get; set; }
      public string t_cwar { get; set; }
      public string t_oamt { get; set; }
    

  

    }

  }
}
