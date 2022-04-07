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
  public partial class CSOrderList : System.Web.UI.Page
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
        GetOrderList_New();
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
      GetOrderList_New();
    }
    protected void GetOrderList()
    {
      string tabl;
      tabl = "";
      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.CommandTimeout = 0;
      //SqlComm.Parameters.AddWithValue("@t_ofbp",Session["t_usid"].ToString());
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_sect", "DTL");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr class='expandable-body'><td><a href='CustOrderEdit.aspx?ORD=" + dr["t_worn"].ToString()+ "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + dr["bp_code_name"].ToString() + "</td><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_cprj"].ToString() + "</td><td>" + dr["t_scbp"].ToString() + "</td><td>" + dr["t_incl"].ToString() + "</td><td>" + dr["t_dlcd"].ToString() + "</td><td>" + dr["t_quot"].ToString() + "</td><td>" + dr["t_rmrk"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_qtyp"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["Sales_Qty"].ToString() + "</td><td>" + dr["Sales_Status"].ToString() + "</td><td>" + dr["Sales_Order"].ToString() + "</td><td>" + dr["Sales_Amount"].ToString() + "</td><td>" + dr["Pre_Planning_Status"].ToString() + "</td><td>" + dr["Pre_Plan_Qty"].ToString() + "</td><td>" + dr["Planning_Status"].ToString() + "</td><td>" + dr["Plan_Qty"].ToString() + "</td><td>" + dr["Production_Status"].ToString() + "</td><td>" + dr["Prouced_Qty"].ToString() + "</td><td>" + dr["Despatch_Status"].ToString() + "</td><td>" + dr["Dispatched_Qty"].ToString() + "</td><td><a href='CustFileUpload.aspx?ORD="+dr["t_worn"].ToString() + "' data-toggle='lightbox' data-title='Download Files For Customer Portal Orders'><i class='nav-icon fas fa-copy'></i></a></td><td><a href='ChatSupport.aspx?ORD=" + dr["t_worn"].ToString() + "'><i class='fas fa-comments'></i></a></td></tr>";
          }
        }
        //order.Text = tabl;
      }
      catch (Exception ex)
      {

      }
    }
    protected void GetOrderList_New()
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
      SqlComm.CommandTimeout = 0;
      //SqlComm.Parameters.AddWithValue("@t_ofbp",Session["t_usid"].ToString());
      if (Session["t_bpid"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
      }
      SqlComm.Parameters.AddWithValue("@t_sect", "DTL");
      SqlComm.CommandText = "WS_CustOrderList_details";
      DataTable sProdPlanData = new DataTable();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sProdPlanData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          tabl = tabl + "<tr><td><a href='CustOrderEdit.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + sProdPlanData.Rows[i]["bp_code_name"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_worn"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_cprj"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_scbp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_incl"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dlcd"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_quot"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmrk"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_date"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_qtyp"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_item"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Sales_Amount"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Pre_Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Planning_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Plan_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Production_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Prouced_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Despatch_Status"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["Dispatched_Qty"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_rmsh"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_dldt"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_devi"].ToString() + "</td><td>" + sProdPlanData.Rows[i]["t_apst"].ToString() + "</td><td><a href='CustFileUpload.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "' data-toggle='lightbox' data-title='Download Files For Customer Portal Orders'><i class='nav-icon fas fa-copy'></i></a></td><td><a href='ChatSupport.aspx?ORD=" + sProdPlanData.Rows[i]["t_worn"].ToString() + "'><i class='fas fa-comments'></i></a></td><td><a href='ExceptionForm.aspx?ORD=" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'><i class='fa fa-fw fa-object-ungroup'></i></a></td><td><a href='SoPacking.aspx?t_orno=" + sProdPlanData.Rows[i]["Sales_Order"].ToString() + "'><i class='fa fa-fw fa-cubes'></i></a></td></tr>";
          
        }
       // order.Text = tabl;
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
        using (SqlCommand cmd = new SqlCommand("exec  WS_CustOrderList_details @t_sect='DTL' , @t_ofbp = '" + r_ofbp + "'"))
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
                Sales_Order_date = sdr["Sales_Order_date"].ToString(),
                Batch_No = sdr["Batch_No"].ToString(),
                Sales_Order_Status = sdr["Sales_Order_Status"].ToString(),
                t_odat = Convert.ToDateTime(sdr["t_odat"]),
                Pre_Plan_Qty = sdr["Pre_Plan_Qty"].ToString(),
                Pre_Planning_Status = sdr["Pre_Planning_Status"].ToString(),
                Pre_Planning_Date = sdr["Pre_Planning_Date"].ToString(),
                Plan_Qty = sdr["Plan_Qty"].ToString(),
                Planning_Status = sdr["Planning_Status"].ToString(),
                Planning_Date = sdr["Planning_Date"].ToString(),
                Prouced_Qty = sdr["Prouced_Qty"].ToString(),
                Production_Status = sdr["Production_Status"].ToString(),
                FGMT_Date = sdr["FGMT_Date"].ToString(),
                Dispatched_Qty = sdr["Dispatched_Qty"].ToString(),
                Despatch_Status = sdr["Despatch_Status"].ToString(),
                Despatch_Date = sdr["Despatch_Date"].ToString(),
                t_dldt = sdr["t_dldt"].ToString(),
                t_rmsh = sdr["t_rmsh"].ToString(),
                t_devi = sdr["t_devi"].ToString(),
                t_appr = sdr["t_appr"].ToString(),
                t_apst = sdr["t_apst"].ToString(),
                t_dowp = sdr["t_dowp"].ToString(),
                t_chat = sdr["t_chat"].ToString(),
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

      public string Batch_No { get; set; }
      public string Sales_Order_Status { get; set; }
      
      public string Sales_Status { get; set; }
      public string Sales_Order_date { get; set; }
      public DateTime t_odat { get; set; }

      public string Pre_Plan_Qty { get; set; }
      public string Pre_Planning_Status { get; set; }
      public string Pre_Planning_Date { get; set; }
      public string Plan_Qty { get; set; }
      public string Planning_Status { get; set; }

      public string Planning_Date { get; set; }
      public string Prouced_Qty { get; set; }
      public string Production_Status { get; set; }
      public string FGMT_Date { get; set; }
      public string Dispatched_Qty { get; set; }
      public string Despatch_Status { get; set; }

      public string Despatch_Date { get; set; }
      public string t_dldt { get; set; }

      public string t_rmsh { get; set; }
      public string t_devi { get; set; }
      public string t_appr { get; set; }
      public string t_apst { get; set; }

      public string t_dowp { get; set; }
      public string t_chat { get; set; }
      public string t_devl { get; set; }
      public string t_pckl { get; set; }
      public string t_nopk { get; set; }

    }

  }
}
