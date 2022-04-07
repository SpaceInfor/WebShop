using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace WebShop
{
  public partial class CSInvList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

      if (!IsPostBack)
      {
        //GetInvList();
       // GetInvListNew();
      }
    }
    protected void Page_PreInit(object sender, EventArgs e)
    {
      // Create an event handler for the master page's contentCallEvent event
      Master.ContentCallEvent += new EventHandler(Master_TextChanged);
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      GetInvList();

    }
    protected void GetInvListNew()
    {
      string tabl;
      tabl = "";
      int count;
      count = 0;
      int i;
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
      }
      SqlComm.CommandText = "WS_CustInvList";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for(i = 0;i< count;i++)
        {
          tabl = tabl + "<tr><td>" + sProdPlanData.Rows[i]["t_nama"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_idoc"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_lrno"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_lrdt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_lyno"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_name"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_fpon"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dqua"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cuni"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_pric"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_amti"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_orno"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td></tr>";
        }
      //  order.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
    protected void GetInvList()
    {
      string tabl;
      tabl = "";
      int count;
      count = 0;
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      //SqlComm.Parameters.AddWithValue("@t_prbp",Session["t_usid"].ToString());
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
      }
      SqlComm.CommandText = "WS_CustInvList";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          count= table.Rows.Count;
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_nama"].ToString() + "</td><td>" + dr["t_idoc"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_cbrn"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_dqua"].ToString() + "</td><td>" + dr["t_cuni"].ToString() + "</td><td>" + dr["t_pric"].ToString() + "</td><td>"+ dr["t_amti"].ToString() + "</td><td>"+ dr["t_orno"].ToString() + "</td><td>" + dr["t_worn"].ToString() + "</td></tr>";
          }
        }
     //   order.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
      Response.Redirect("CustOrderBooking.aspx?SCP=1");
    }

    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesInvClass> GetSalesInvoice()
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustInvList @t_prbp = '" + r_ofbp + "'"))
        {
          cmd.Connection = con;
          List<SalesInvClass> SalesOrders = new List<SalesInvClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              SalesOrders.Add(new SalesInvClass
              {
                t_nama = sdr["t_nama"].ToString(),
                t_idoc = sdr["t_idoc"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_cbrn = sdr["t_cbrn"].ToString(),
                t_item = sdr["t_item"].ToString(),
                t_dqua = sdr["t_dqua"].ToString(),
                t_cuni = sdr["t_cuni"].ToString(),
                t_pric = sdr["t_pric"].ToString(),
                t_amti = sdr["t_amti"].ToString(),
                t_orno = sdr["t_orno"].ToString(),
                t_worn = sdr["t_worn"].ToString(),
                t_idat = sdr["t_idat"].ToString(),
                t_lrno = sdr["t_lrno"].ToString(),
                t_lrdt = sdr["t_lrdt"].ToString(),
                t_lyno = sdr["t_lyno"].ToString(),
                t_name = sdr["t_name"].ToString(),
                t_fpon = sdr["t_fpon"].ToString()
              });
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }
    public class SalesInvClass
    {
      public string t_nama { get; set; }
      public string t_idoc { get; set; }
      public string t_date { get; set; }
      public string t_cbrn { get; set; }
      public string t_item { get; set; }
      public string t_dqua { get; set; }
      public string t_cuni { get; set; }
      public string t_pric { get; set; }
      public string t_amti { get; set; }
      public string t_orno { get; set; }
      public string t_worn { get; set; }
      public string t_idat { get; set; }
      public string t_lrno { get; set; }
      public string t_lrdt { get; set; }
      public string t_lyno { get; set; }
      public string t_name { get; set; }
      public string t_fpon { get; set; }
    }

  }
}
