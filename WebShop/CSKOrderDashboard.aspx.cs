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
  public partial class CSKOrderDashboard : System.Web.UI.Page
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CSKDashboard_Nos @t_mode = 'SUM'"))
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
                
                FullReady_Qty = Convert.ToInt32(sdr["FullReady_Qty"]),
                FullReady_Val = Convert.ToInt32(sdr["FullReady_Val"]),
                BalPartReady_Qty = Convert.ToInt32(sdr["BalPartReady_Qty"]),
                BalPartReady_Val = Convert.ToInt32(sdr["BalPartReady_Val"]),
                PartReady_Qty = Convert.ToInt32(sdr["PartReady_Qty"]),
                PartReady_Val = Convert.ToInt32(sdr["PartReady_Val"]),
                WIP_Qty = Convert.ToInt32(sdr["WIP_Qty"]),
                WIP_Val = Convert.ToInt32(sdr["WIP_Val"]),
                Planning_Qty = Convert.ToInt32(sdr["Planning_Qty"]),
                Planning_Val = Convert.ToInt32(sdr["Planning_Val"]),
                FOC_FullReady_Qty = Convert.ToInt32(sdr["FOC_FullReady_Qty"]),
                FOC_PartReady_Qty = Convert.ToInt32(sdr["FOC_PartReady_Qty"]),
                FOC_WIP_Qty = Convert.ToInt32(sdr["FOC_WIP_Qty"]),
                FOC_Login_Nos = Convert.ToInt32(sdr["FOC_Login_Nos"]),

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

      
      public double FullReady_Qty { get; set; }
      public double FullReady_Val { get; set; }
      public double BalPartReady_Qty { get; set; }
      public double BalPartReady_Val { get; set; }
      public double PartReady_Qty { get; set; }
      public double PartReady_Val { get; set; }
      public double WIP_Qty { get; set; }
      public double WIP_Val { get; set; }
      public double Planning_Qty { get; set; }
      public double Planning_Val { get; set; }
      public double FOC_FullReady_Qty { get; set; }
      public double FOC_PartReady_Qty { get; set; }
      public double FOC_WIP_Qty { get; set; }
      public double FOC_Login_Nos { get; set; }

    }
  }
}
