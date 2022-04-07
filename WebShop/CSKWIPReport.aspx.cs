using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web;


namespace WebShop
{
  public partial class CSKWIPReport : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='WIP' , @t_ofbp = '" + r_ofbp + "'"))
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
                t_date = sdr["t_date"].ToString(),
                t_qtyp = sdr["t_qtyp"].ToString(),
                t_scbp = sdr["t_scbp"].ToString(),
                Sales_Order = sdr["Sales_Order"].ToString(),
                Sales_Qty = sdr["Sales_Qty"].ToString(),
                Sales_Order_Date = sdr["Sales_Order_Date"].ToString(),
                Sales_Amount = sdr["Sales_Amount"].ToString(),
                Pl_Release_Date = sdr["Pl_Release_Date"].ToString(),
                t_rmsh = sdr["t_rmsh"].ToString(),
                t_devi = sdr["t_devi"].ToString(),
                t_apst = sdr["t_apst"].ToString(),
                Batch_No = sdr["Batch_No"].ToString()
              });
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetFOCOrders()
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details_foc @t_sect='WIP' , @t_ofbp = '" + r_ofbp + "'"))
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
                t_date = sdr["t_date"].ToString(),
                t_qtyp = sdr["t_qtyp"].ToString(),
                t_scbp = sdr["t_scbp"].ToString(),
                Sales_Order = sdr["Sales_Order"].ToString(),
                Sales_Qty = sdr["Sales_Qty"].ToString(),
                Sales_Order_Date = sdr["Sales_Order_Date"].ToString(),
                Sales_Amount = sdr["Sales_Amount"].ToString(),
                Pl_Release_Date = sdr["Pl_Release_Date"].ToString(),
                t_rmsh = sdr["t_rmsh"].ToString(),
                t_devi = sdr["t_devi"].ToString(),
                t_apst = sdr["t_apst"].ToString()
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
      public string t_scbp { get; set; }
      public string t_date { get; set; }
      public string t_qtyp { get; set; }
      public string Sales_Order { get; set; }
      public string Sales_Qty { get; set; }
      public string Sales_Amount { get; set; }
      public string Sales_Order_Date { get; set; }
      public string Pl_Release_Date { get; set; }

      public string Batch_No { get; set; }
      public string t_rmsh { get; set; }
      public string t_devi { get; set; }
      public string t_apst { get; set; }
    }
  }
}
