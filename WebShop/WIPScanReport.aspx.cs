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
  public partial class WIPScanReport : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<tiswc124> GetWIPData()
    {
      string r_ofbp;
      r_ofbp = "";
      //if (HttpContext.Current.Session["t_bpid"] != null)
      //{
      //  r_ofbp = HttpContext.Current.Session["t_bpid"].ToString();
      //}
      //else
      //{
      //  r_ofbp = "";
      //}
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select t_part,wip.t_cwoc,wc.t_dsca,CONVERT(varchar,t_date,113) as t_date,t_btch,t_user from swlive..ttiswc124100 wip join swlive..ttiswc101100 wc on (wc.t_cwoc = wip.t_cwoc) order by wip.t_btch,wip.t_part,wip.t_date,wip.t_cwoc"))
        {
          cmd.Connection = con;
          List<tiswc124> WIPData = new List<tiswc124>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              WIPData.Add(new tiswc124
              {
                t_part = sdr["t_part"].ToString(),
                t_cwoc = sdr["t_cwoc"].ToString(),
                t_dsca = sdr["t_dsca"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_btch = sdr["t_btch"].ToString(),
                t_user = sdr["t_user"].ToString()
               
              });
            }
          }
          con.Close();
          return WIPData;
        }
      }
    }


    public class tiswc124
    {
      public string t_part { get; set; }
      public string t_cwoc { get; set; }
      public string t_dsca { get; set; }
      public string t_date { get; set; }
      public string t_btch { get; set; }
      public string t_user { get; set; }
      

    }
  }
}
