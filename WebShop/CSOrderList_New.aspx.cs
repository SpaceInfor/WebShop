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
  public partial class CSOrderList_New : System.Web.UI.Page
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
 
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
   
     
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
      Response.Redirect("CustOrderBooking.aspx?SCP=1");
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
        //using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='DTL' , @t_ofbp = '" + r_ofbp + "'"))
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='DTL1'"))
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
                ord_link = sdr["ord_link"].ToString(),
                bp_code_name = sdr["bp_code_name"].ToString(),
                t_worn = sdr["t_worn"].ToString(),
                t_cprj = sdr["t_cprj"].ToString(),
                t_quot = sdr["t_quot"].ToString(),
                t_incl = sdr["t_incl"].ToString(),
                t_dlcd = sdr["t_dlcd"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_qtyp = sdr["t_qtyp"].ToString(),
                t_scbp = sdr["t_scbp"].ToString(),
                t_item = sdr["t_item"].ToString(),
                t_qnty = sdr["t_qnty"].ToString(),
                t_rmrk = sdr["t_rmrk"].ToString(),
                t_ccit = sdr["t_ccit"].ToString(),
                Sales_Order = sdr["Sales_Order"].ToString(),
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
                t_dowp = sdr["t_dowp"].ToString(),
                t_chat = sdr["t_chat"].ToString(),
                t_devl = sdr["t_devl"].ToString(),
                t_pckl = sdr["t_pckl"].ToString()
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
      public string ord_link { get; set; }
      public string bp_code_name { get; set; }
      public string t_worn { get; set; }

      public string t_cprj { get; set; }
      public string t_quot { get; set; }
      public string t_incl { get; set; }
      public string t_dlcd { get; set; }
      public string t_date { get; set; }
      public string t_qtyp { get; set; }
      public string t_scbp { get; set; }
      public string t_item { get; set; }
      public string t_qnty { get; set; }
      public string t_rmrk { get; set; }

      public string t_ccit { get; set; }
      public string Sales_Order { get; set; }
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

      public string t_dowp { get; set; }
      public string t_chat { get; set; }
      public string t_devl { get; set; }
      public string t_pckl { get; set; }

    }
  }
}
