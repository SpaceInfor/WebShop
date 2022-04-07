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
  public partial class CSKOrderDashboard_Nos_Report : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetOrders()
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CSKDashboard_Nos @t_prbp = '" + r_ofbp + "'"))
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
                FullReady_Qty = sdr["FullReady_Qty"].ToString(),
                FullReady_Val = sdr["FullReady_Val"].ToString(),
                BalPartReady_Qty = sdr["BalPartReady_Qty"].ToString(),
                BalPartReady_Val = sdr["BalPartReady_Val"].ToString(),
                PartReady_Qty = sdr["PartReady_Qty"].ToString(),
                PartReady_Val = sdr["PartReady_Val"].ToString(),
                WIP_Qty = sdr["WIP_Qty"].ToString(),
                WIP_Val = sdr["WIP_Val"].ToString(),
                Planning_Qty = sdr["Planning_Qty"].ToString(),
                Planning_Val = sdr["Planning_Val"].ToString(),
                FOC_FullReady_Qty = sdr["FOC_FullReady_Qty"].ToString(),
                FOC_PartReady_Qty = sdr["FOC_PartReady_Qty"].ToString(),
                FOC_WIP_Qty = sdr["FOC_WIP_Qty"].ToString(),
                FOC_Login_Nos = sdr["FOC_Login_Nos"].ToString(),

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
      public string FullReady_Qty { get; set; }
      public string FullReady_Val { get; set; }
      public string BalPartReady_Qty { get; set; }
      public string BalPartReady_Val { get; set; }
      public string PartReady_Qty { get; set; }
      public string PartReady_Val { get; set; }
      public string WIP_Qty { get; set; }
      public string WIP_Val { get; set; }
      public string Planning_Qty { get; set; }
      public string Planning_Val { get; set; }
      public string FOC_FullReady_Qty { get; set; }
      public string FOC_PartReady_Qty { get; set; }
      public string FOC_WIP_Qty { get; set; }
      public string FOC_Login_Nos { get; set; }

    }
  }
}
