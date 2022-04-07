using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
namespace WebShop
{
  public partial class INNDashboard : System.Web.UI.Page
  {
    String userid;
    protected void Page_PreInit(object sender, EventArgs e)
    {
      // Create an event handler for the master page's contentCallEvent event
      Master.ContentCallEvent += new EventHandler(Master_TextChanged);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
      try
      {
        if (Session["t_usid"] == null)
        {
          Response.Redirect("CustLogin.aspx");
        }
        if (Session["t_usid"].ToString() == null)
        {
          userid = Request.QueryString["UID"].ToString();
        }
        else
        {
          userid = Session["t_usid"].ToString();
        }
        if (!IsPostBack)
        {
          bind_dashboard();
          //ScriptManager.RegisterStartupScript(this, this.GetType(), "KeyClient", "<script>return getLocation();</Script>", false);
        }
      }
      catch (Exception ex)
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
      bind_dashboard();
    }

    protected void bind_dashboard()
    {
      bind_yourorder_sum();
     // bind_inventory_sum();
      bind_recentord_sum();
      bind_mtdord_sum();
    }

    protected void bind_recentord_sum()
    {
      try
      {
        string stblData = "";
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandTimeout = 0;
        SqlComm.CommandType = CommandType.StoredProcedure;
        if (Session["t_bpid"] != null)
        {
          SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
        }
        SqlComm.Parameters.AddWithValue("@t_sect", "ORDIN");
        SqlComm.CommandText = "WS_BuyerDashboard_OrdDetails";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              stblData = stblData + "<tr><td><span class='badge badge-success circle elevation-2'> " + dr["t_chan"].ToString() + "</span></td><td>" + dr["t_draf"].ToString() + "</td><td>" + dr["t_prep"].ToString() + "</td><td>" + dr["t_plan"].ToString() + "</td><td>" + dr["t_pack"].ToString() + "</td><td>" + dr["t_desp"].ToString() + "</td></tr>";
            }
          }
          stblData = stblData + "</tbody></table>";
          latestordlist.InnerHtml = stblData;
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }
      }
      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
    }
    protected void bind_mtdord_sum()
    {
      try
      {

        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();

        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_sect", "BOOK");
        SqlComm.CommandText = "WS_GetMgmtDashboard";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              //stblData = stblData + "<tr><td><span class='" + dr["t_class"].ToString() + " circle elevation-2'> " + dr["t_stat"].ToString() + "</span></td><td>" + dr["MTD_Nos"].ToString() + "</td><td>" + dr["MTD_Value"].ToString() + "</td><td>" + dr["YTD_Nos"].ToString() + "</td><td>" + dr["YTD_Value"].ToString() + "</td></tr>";
              //lbl_tltalapnos.Text = dr["AMTD_Nos"].ToString();
              //lbl_totalapval.Text = dr["AMTD_Value"].ToString();

              //lbl_tltalunapnos.Text = dr["UMTD_Nos"].ToString();
              //lbl_totalunapval.Text = dr["UMTD_Value"].ToString();


              //lbl_tltalapnos_ytd.Text = dr["AYTD_Nos"].ToString();
              //lbl_tltalunapval_ytd.Text = dr["AYTD_Value"].ToString();
              //lbl_tltalunapnos_ytd.Text = dr["UYTD_Nos"].ToString();
              //lbl_totalunapval_ytd.Text = dr["UYTD_Value"].ToString();
            }
          }

        }
        catch (Exception ex)
        {

        }
      }
      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
    }
    protected void bind_inventory_sum()
    {
      try
      {
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;

        if (Session["t_bpid"] != null)
        {
          SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
        }
        SqlComm.Parameters.AddWithValue("@t_sect", "DSH");
        SqlComm.CommandText = "WS_CustOrderList_details";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              //lblSales_Pending.InnerHtml = dr["Sales_Pending"].ToString();
              //lblPre_Plan_Pending.InnerHtml = dr["Pre_Plan_Pending"].ToString();
              //lblPlan_Pending.InnerHtml = dr["Plan_Pending"].ToString();
              //lblProd_Pending.InnerHtml = dr["Prod_Pending"].ToString();
              //lblDesp_Pending.InnerHtml = dr["Desp_Pending"].ToString();
            }
          }
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }
      }
      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }

    }
    protected void bind_yourorder_sum()
    {
      try
      {
        string stblData;
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        //SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_usid"].ToString());
        if (Session["t_bpid"] != null)
        {
          SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
        }
        SqlComm.Parameters.AddWithValue("@t_sect", "ORDI");
        SqlComm.CommandText = "WS_BuyerDashboard_OrdDetails";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              yourorder.InnerHtml = dr["t_tord"].ToString();
              yourinvoice.InnerHtml = dr["t_idoc"].ToString();
              yourpayables.InnerHtml = dr["t_ttdl"].ToString();
              //tobereceived.InnerHtml = dr["t_orec"].ToString();
            }
          }
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }
      }
      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
    }

    protected void bind_warehouse_Perc()
    {
      try
      {
        string stblData;
        stblData = "";
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
        SqlComm.Parameters.AddWithValue("@type", "PIE_WH");
        SqlComm.CommandText = "WS_GetInvDashboard_Details";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              stblData = stblData + "<li class='nav-item'>";
              stblData = stblData + "<a href = '#' class='nav-link'>";
              stblData = stblData + dr["t_dsca"].ToString();
              stblData = stblData + "<span class='float-right text-danger'><i class='fas fa-arrow-down text-sm'></i>";
              stblData = stblData + dr["t_perc"].ToString() + " %" + "</span></a></li>";
            }
          }
          //whperc.InnerHtml = stblData;
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }
      }
      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String Get_User_Info()
    {

      int i, count;
      count = 0;
      i = 0;
      String userimage = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_user", HttpContext.Current.Session["t_usid"].ToString());
      SqlComm.CommandText = "WS_GetUserData";
      DataTable sUserData = new DataTable();
      try
      {
        sUserData = NBData.GetDataSetViaSPTab(SqlComm, true, ref objErr);
        count = sUserData.Rows.Count;
        for (i = 0; i < count; i++)
        {
          userimage = sUserData.Rows[i]["t_ipth"].ToString();
        }
        return userimage;
      }
      catch (Exception ex)
      {
        return "";
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetStatusDetails()
    {
      string jsonData = "";

      try
      {
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;

        //if (Session["t_bpid"] != null)
        //{
        //  SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
        //}
        SqlComm.Parameters.AddWithValue("@t_sect", "DSH");
        SqlComm.CommandText = "WS_CustOrderList_Innopan";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              //lblSales_Pending.InnerHtml = dr["Sales_Pending"].ToString();
              //lblPre_Plan_Pending.InnerHtml = dr["Pre_Plan_Pending"].ToString();
              //lblPlan_Pending.InnerHtml = dr["Plan_Pending"].ToString();
              //lblProd_Pending.InnerHtml = dr["Prod_Pending"].ToString();
              //lblDesp_Pending.InnerHtml = dr["Desp_Pending"].ToString();

              var input = new
              {
                Sales_Pending = dr["Sales_Pending"].ToString(),
                Pre_Plan_Pending = dr["Pre_Plan_Pending"].ToString(),
                Plan_Pending = dr["Plan_Pending"].ToString(),
                Prod_Pending = dr["Prod_Pending"].ToString(),
                Desp_Pending = dr["Desp_Pending"].ToString()
              };
              jsonData = (new JavaScriptSerializer()).Serialize(input);
            }
          }
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }

        return jsonData;
      }

      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
      return jsonData;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetOrderStatDetails()
    {
      string jsonData = "";

      try
      {
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;

        //if (Session["t_bpid"] != null)
        //{
        //  SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
        //}
        SqlComm.Parameters.AddWithValue("@t_sect", "SIDB");
        SqlComm.CommandText = "WS_CustOrderList_Innopan";
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
            

              var input = new
              {
                r_c_redy = dr["r_c_redy"].ToString(),
                r_c_part = dr["r_c_part"].ToString(),
                f_c_redy = dr["f_c_redy"].ToString(),
                f_c_part = dr["f_c_part"].ToString(),
                r_v_redy = dr["r_v_redy"].ToString(),
                r_v_part = dr["r_v_part"].ToString(),
                f_v_redy = dr["f_v_redy"].ToString(),
                f_v_part = dr["f_v_part"].ToString()

              };
              jsonData = (new JavaScriptSerializer()).Serialize(input);
            }
          }
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }

        return jsonData;
      }

      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
      return jsonData;
    }

  }
}
