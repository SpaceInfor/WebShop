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
  public partial class INNInvList : System.Web.UI.Page
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
        using (SqlCommand cmd = new SqlCommand("exec WS_CustInvList_INN"))
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
                t_idoc = sdr["t_idoc"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_cbrn = sdr["t_cbrn"].ToString(),
                t_item = sdr["t_item"].ToString(),
                t_item_desc = sdr["t_item_desc"].ToString(),
                t_dqua = sdr["t_dqua"].ToString(),
                t_cuni = sdr["t_cuni"].ToString(),
                t_pric = sdr["t_pric"].ToString(),
                t_amti = sdr["t_amti"].ToString(),
                t_orno = sdr["t_orno"].ToString(),
                t_worn = sdr["t_worn"].ToString(),
                t_lrno = sdr["t_lrno"].ToString(),
                t_lrdt = sdr["t_lrdt"].ToString(),
                t_lyno = sdr["t_lyno"].ToString(),
                transporter = sdr["transporter"].ToString(),
                t_fpon = sdr["t_fpon"].ToString()
            

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
      public string t_idoc { get; set; }
      public string t_date { get; set; }
      public string t_cbrn { get; set; }
      public string t_item { get; set; }
      public string t_item_desc { get; set; }
      public string t_dqua { get; set; }

      public string t_cuni { get; set; }
      public string t_pric { get; set; }
      public string t_amti { get; set; }
      public string t_orno { get; set; }
      public string t_worn { get; set; }
      public string t_lrno { get; set; }

      public string t_lrdt { get; set; }

      public string t_lyno { get; set; }
      public string transporter { get; set; }

      public string t_fpon { get; set; }
    

  

    }

  }
}
