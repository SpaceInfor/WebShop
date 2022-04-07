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
    public partial class MgmtDashboard_Sales : Page
    {
        String userid;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
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


      protected void bind_dashboard()
      {
        //bind_inventory_sum();
        //bind_warehouse_sum();
         bind_recentord_sum();
        //bind_PieChart_sum();
        //bind_warehouse_Perc();
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
        SqlComm.CommandType = CommandType.StoredProcedure;
        if (Session["t_bpid"] != null)
        {
          SqlComm.Parameters.AddWithValue("@t_prbp", Session["t_bpid"].ToString());
        }
        SqlComm.Parameters.AddWithValue("@t_sect", "ORDLST");
        SqlComm.CommandText = "WS_BuyerDashboard_OrdDetails";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              stblData = stblData + "<tr><td>" + dr["t_nama"].ToString() + "</td><td><span class='badge badge-success circle elevation-2'> " + dr["t_worn"].ToString() + "</span></td><td>" + dr["t_lobn"].ToString() + "</td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_qnty"].ToString() + "</td><td><span class='" + dr["t_colr"].ToString() + "'>" + dr["t_stat"].ToString() + "</span></td></tr>";
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
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              //stblData = stblData + "<tr><td><span class='" + dr["t_class"].ToString() + " circle elevation-2'> " + dr["t_stat"].ToString() + "</span></td><td>" + dr["MTD_Nos"].ToString() + "</td><td>" + dr["MTD_Value"].ToString() + "</td><td>" + dr["YTD_Nos"].ToString() + "</td><td>" + dr["YTD_Value"].ToString() + "</td></tr>";
              lbl_tltalapnos.Text = dr["AMTD_Nos"].ToString();
              lbl_totalapval.Text = dr["AMTD_Value"].ToString();
              lbl_tltalunapnos.Text = dr["UMTD_Nos"].ToString();
              
              lbl_tltalunapnos_ytd.Text = dr["AYTD_Nos"].ToString();
              lbl_tltalunapval_ytd.Text = dr["AYTD_Value"].ToString();
              lbl_tltalunapnos_ytd.Text = dr["UYTD_Nos"].ToString();
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
        string stblData;
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
        SqlComm.Parameters.AddWithValue("@t_sect", "INV");
        SqlComm.CommandText = "WS_GetInvDashboard";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              invonhand.InnerHtml =  dr["t_qhnd"].ToString();
              invalloc.InnerHtml = dr["t_qall"].ToString();
              invonord.InnerHtml = dr["t_qord"].ToString();
              inveco.InnerHtml = dr["t_eqos"].ToString();
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
    protected void bind_warehouse_sum()
    {
      try
      {
        string stblData;
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
        SqlComm.Parameters.AddWithValue("@t_sect", "WAR");
        SqlComm.CommandText = "WS_GetInvDashboard";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              tobepacked.InnerHtml = dr["t_open"].ToString();
              tobeshipped.InnerHtml = dr["t_frez"].ToString();
              tobeinvoiced.InnerHtml = dr["t_invc"].ToString();
              tobereceived.InnerHtml = dr["t_orec"].ToString();
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
    protected void bind_PieChart_sum()
    {
      string Series;
      string ullist;
      ullist = "<ul class='chart-legend clearfix'>";
      Series = "<script type = 'text/javascript'>" + System.Environment.NewLine; 
      try
      {
        Series = Series + "var pieChartCanvas = $('#pieChart').get(0).getContext('2d')" + System.Environment.NewLine;
        Series = Series + "var pieData = { " + System.Environment.NewLine;
        Series = Series + "labels: [" + System.Environment.NewLine;
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
        SqlComm.Parameters.AddWithValue("@type", "PIE");
        SqlComm.CommandText = "WS_GetInvDashboard_Details";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              Series = Series + "'" + dr["t_cmnf"].ToString() + "'," + System.Environment.NewLine;
              ullist = ullist + "<li><i class='far fa-circle text-danger'></i> " + dr["t_cmnf"].ToString() + "</li>";
            }
          }
          ullist = ullist + "</ul>";
          Series = Series + System.Environment.NewLine +  "]," + System.Environment.NewLine;
          Series = Series + "datasets: [" + System.Environment.NewLine;
          Series = Series + "{" + System.Environment.NewLine; 
          Series = Series + "data: [" + System.Environment.NewLine;
          foreach (DataTable table1 in sProdPlanData.Tables)
          {
              foreach (DataRow dr in table1.Rows)
              {
                  Series = Series + dr["t_qhnd"].ToString() + ",";
              }
          }
          Series = Series + "]," + System.Environment.NewLine;
          Series = Series + "backgroundColor: ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'],";
          Series = Series + "}" + System.Environment.NewLine;
          Series = Series + "]" + System.Environment.NewLine;
          Series = Series + "}" + System.Environment.NewLine;
          Series = Series + "var pieOptions = {" + System.Environment.NewLine;
          Series = Series + "legend: {" + System.Environment.NewLine;
          Series = Series + "display: false" + System.Environment.NewLine;
          Series = Series + "}" + System.Environment.NewLine;
          Series = Series + "}" + System.Environment.NewLine;
          Series = Series + "var pieChart = new Chart(pieChartCanvas, {" + System.Environment.NewLine;
          Series = Series + "type: 'doughnut'," + System.Environment.NewLine;
          Series = Series + "data: pieData," + System.Environment.NewLine;
          Series = Series + "options: pieOptions" + System.Environment.NewLine;
          Series = Series + "})" + System.Environment.NewLine;
          Series = Series + "</script>";
          srcpt.InnerHtml = Series;
          pielist.InnerHtml = ullist;
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
          whperc.InnerHtml = stblData;
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

  }

}
