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

  public partial class CSKOrderAgeing : Page
    {
    string getFileName;
    protected void Page_PreInit(object sender, EventArgs e)
    {
      Master.ContentCallEvent += new EventHandler(Master_TextChanged);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
      {
        
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
      //GetOrderList_New();
    }
    protected void uploadFile_Click(object sender, EventArgs e)
    {
     
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetCustomers(string basis,string t_frdt,string t_todt)
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
       
        using (SqlCommand cmd = new SqlCommand("exec  WS_AgeingNumbers @t_sect='" + basis + "',@t_prbp='" + r_ofbp + "',@t_frdt='" + t_frdt + "',@t_todt='" +t_todt+"'"))
        {
          cmd.Connection = con;
          cmd.CommandTimeout = 1000;

          List<SalesOrderClass> SalesOrders = new List<SalesOrderClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              SalesOrders.Add(new SalesOrderClass
              {
               
                bp_code_name = sdr["bp_code_name"].ToString(),
                b1 = sdr["b1"].ToString(),
                b2 = sdr["b2"].ToString(),
                b3 = sdr["b3"].ToString(),
                b4 = sdr["b4"].ToString(),
                b5 = sdr["b5"].ToString(),
                b6 = sdr["b6"].ToString(),
                b7 = sdr["b7"].ToString(),
                b8 = sdr["b8"].ToString()

              });
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }
    [WebMethod]
    public static string GetData()
    {
      using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConn"].ToString()))
      {
        SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='DTL'");
        using (SqlDataAdapter sda = new SqlDataAdapter())
        {
          cmd.Connection = con;
          sda.SelectCommand = cmd;
          using (DataSet ds = new DataSet())
          {
            sda.Fill(ds);
            return ds.GetXml();
          }
        }
      }
    }

    public class SalesOrderClass
    {
    
      public string bp_code_name { get; set; }
      public string b1 { get; set; }
      
      public string b2 { get; set; }
      public string b3 { get; set; }
      public string b4 { get; set; }
      public string b5 { get; set; }
      public string b6 { get; set; }
      public string b7 { get; set; }

      public string b8 { get; set; }


    }

  }
}



