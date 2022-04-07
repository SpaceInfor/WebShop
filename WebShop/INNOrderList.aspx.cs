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
  public partial class INNOrderList : System.Web.UI.Page
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_Innopan @t_sect='DTL' , @t_ofbp = '" + r_ofbp + "'"))
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
                t_ccit = sdr["t_ccit"].ToString(),
                Sales_Order = sdr["Sales_Order"].ToString(),
                Sales_Order_Date = sdr["Sales_Order_Date"].ToString(),
                Sales_Qty = sdr["Sales_Qty"].ToString(),
                Sales_Amount = sdr["Sales_Amount"].ToString(),
                Sales_Status = sdr["Sales_Status"].ToString(),
                Pre_Plan_Qty = sdr["Pre_Plan_Qty"].ToString(),
                Pre_Planning_Status = sdr["Pre_Planning_Status"].ToString(),
                Plan_Qty = sdr["Plan_Qty"].ToString(),
                Planning_Status = sdr["Planning_Status"].ToString(),
                Prouced_Qty = sdr["Prouced_Qty"].ToString(),
                Production_Status = sdr["Production_Status"].ToString(),
                Dispatched_Qty = sdr["Dispatched_Qty"].ToString(),
                Despatch_Status = sdr["Despatch_Status"].ToString(),
                t_dldt = sdr["t_dldt"].ToString(),
                t_rmsh = sdr["t_rmsh"].ToString(),
                t_devi = sdr["t_devi"].ToString(),
                t_appr = sdr["t_appr"].ToString(),
                t_devl = sdr["t_devl"].ToString(),
                t_pckl = sdr["t_pckl"].ToString(),
                t_nopk = sdr["t_nopk"].ToString()
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
      public string t_ccit { get; set; }
      public string Sales_Order { get; set; }
      public string Sales_Order_Date { get; set; }
      public string t_refa { get; set; }
      public string t_refb { get; set; }

      public string t_corn { get; set; }
      public string Sales_Qty { get; set; }
      public string Sales_Amount { get; set; }
      public string Sales_Status { get; set; }
      public string Pre_Plan_Qty { get; set; }
      public string Pre_Planning_Status { get; set; }
      public string Plan_Qty { get; set; }
      public string Planning_Status { get; set; }
      public string Prouced_Qty { get; set; }
      public string Production_Status { get; set; }
      public string Dispatched_Qty { get; set; }
      public string Despatch_Status { get; set; }
      public string t_dldt { get; set; }

      public string t_rmsh { get; set; }
      public string t_devi { get; set; }
      public string t_appr { get; set; }
      public string t_apst { get; set; }



      public string t_devl { get; set; }
      public string t_pckl { get; set; }
      public string t_nopk { get; set; }

    }

  }
}
