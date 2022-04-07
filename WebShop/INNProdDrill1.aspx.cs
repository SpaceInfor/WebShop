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
  public partial class INNProdDrill1 : System.Web.UI.Page
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
        using (SqlCommand cmd = new SqlCommand("exec WS_CustOrderList_Innopan @t_sect='PRDR' , @t_ofbp = '" + r_ofbp + "'"))
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
                t_refa = sdr["t_refa"].ToString(),
                t_refb = sdr["t_refb"].ToString(),
                t_corn = sdr["t_corn"].ToString(),
                Sales_Order = sdr["Sales_Order"].ToString(),
                Sales_Order_Date = sdr["Sales_Order_Date"].ToString(),
                Sales_Qty = sdr["Sales_Qty"].ToString(),
                Sales_Amount = sdr["Sales_Amount"].ToString(),
                t_hdst = sdr["t_hdst"].ToString(),
                t_cwar = sdr["t_cwar"].ToString(),
                t_item = sdr["t_item"].ToString(),
                Item_Desc = sdr["Item_Desc"].ToString(),
                t_cuni = sdr["t_cuni"].ToString(),
                t_pdno = sdr["t_pdno"].ToString(),
                t_clco = sdr["t_clco"].ToString(),
                t_podt = sdr["t_podt"].ToString(),
                t_fgmt = sdr["t_fgmt"].ToString()

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
  
      public string Sales_Order { get; set; }
      public string Sales_Order_Date { get; set; }
      public string t_refa { get; set; }
      public string t_refb { get; set; }

      public string t_corn { get; set; }
      public string t_odat { get; set; }
      public string Sales_Amount { get; set; }
      public string Sales_Qty { get; set; }
      public string t_hdst { get; set; }
      public string t_prep { get; set; }

      public string t_prod { get; set; }
      public string t_fgmt { get; set; }

      public string t_dldt { get; set; }

      public string t_cwar { get; set; }
      public string t_item { get; set; }

      public string Item_Desc { get; set; }
      public string t_pdno { get; set; }
      public string t_clco { get; set; }
      public string t_podt { get; set; }
      public string t_cuni { get; set; }

  

    }

  }
}
