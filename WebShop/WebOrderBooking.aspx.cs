  using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;


namespace WebShop
{
  public partial class WebOrderBooking : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        if (Request.QueryString["ORD"] != null)
        {
          bindOrderDetails(Request.QueryString["ORD"].ToString());
        }
      }
    }
    protected void bindOrderDetails(string t_orno)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "exec WS_OrderDashboard @t_euni = '" + Session["t_eunt"].ToString() + "',@type='WEBDETL'" + ",@orno='" + t_orno + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();

        if (tab.Rows.Count > 0)
        {
          t_ofbp.Text = tab.Rows[0]["t_ofbp"].ToString();
          t_ofbp_nama.InnerText = tab.Rows[0]["t_ofnam"].ToString();
          t_stbp.Text = tab.Rows[0]["t_stbp"].ToString();
          t_stbp_nama.InnerText = tab.Rows[0]["t_stnam"].ToString();
          t_cwar.Text = tab.Rows[0]["t_cwar"].ToString();
          t_cwar_nama.InnerText = tab.Rows[0]["t_warn"].ToString();
          t_cofc.Text = tab.Rows[0]["t_cofc"].ToString();
          t_cofc_nama.InnerText = tab.Rows[0]["t_salnm"].ToString(); 
          t_corn.Text = tab.Rows[0]["t_corn"].ToString();
          t_refb.Text = tab.Rows[0]["t_refb"].ToString();

          string tabl;
          Double r_qnty, r_amnt;
          r_qnty = 0;
          r_amnt = 0;
          tabl = "";
          NBDataAccess NBData = new NBDataAccess();
          NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
          SqlCommand SqlComm = new SqlCommand();
          SqlComm.CommandType = CommandType.StoredProcedure;
          SqlComm.Parameters.AddWithValue("@t_orno", t_orno);
          SqlComm.CommandText = "WS_GetQuotationDetails";
          DataSet sProdPlanData = new DataSet();
          try
          {
            sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
            foreach (DataTable table in sProdPlanData.Tables)
            {
              foreach (DataRow dr in table.Rows)
              {
                tabl = tabl + "<tr><td><span class='badge bg-warning'>" + dr["t_pono"].ToString() + "</span></td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td><td>" + dr["t_qnty"].ToString() + "</td><td>" + dr["t_uom"].ToString() + "</td><td>" + dr["t_pric"].ToString() + "</td><td>" + dr["t_oamt"].ToString() + "</td><td class=project-actions text-ight'><button class='btn btn-danger btn-sm' OnClick='Delete_Row();return false;'><i class='fas fa-trash'></i></button></td></tr>";
                r_qnty = r_qnty + Convert.ToDouble(dr["t_qnty"]);
                r_amnt = r_amnt + Convert.ToDouble(dr["t_oamt"]);
              }
            }
            tabl = tabl + "<tr><td></td><td></td><td><strong>Total</strong></td><td><strong>" + r_qnty.ToString() + "</strong><td></td><td></td><td><strong>" + r_amnt.ToString() + "</strong></td></tr>";
            tb1.InnerHtml = tabl;
          }
          catch (Exception ex)
          {
            
          }
        }
      }
      catch (Exception ex)
      {
        
      }
    }
  
    protected void t_ofbp_TextChanged(object sender, EventArgs e)
    {
      t_ofbp_nama.InnerText = getbpName(t_ofbp.Text);
      if (t_stbp.Text == "")
      {
        t_stbp.Text = t_ofbp.Text;
        t_stbp_nama.InnerText = getbpName(t_stbp.Text);
      }
    }
    protected void t_stbp_TextChanged(object sender, EventArgs e)
    {
      t_stbp_nama.InnerText = getbpName(t_stbp.Text);
    }
    protected void t_cwar_TextChanged(object sender, EventArgs e)
    {
      t_cwar_nama.InnerText = getWarehouseName(t_cwar.Text);
    }
    protected void t_cofc_TextChanged(object sender, EventArgs e)
    {
      t_cofc_nama.InnerText = getSalesOffName(t_cofc.Text);
    }
    protected void t_item_TextChanged(object sender, EventArgs e)
    {
      t_item_desc.InnerText = getItemName(t_item.Text);
    }
    protected void t_qoor_TextChanged(object sender, EventArgs e)
    {
      string tabl;
      double i_pric, i_qoor, i_oamt;
      string i_unit;
      tabl = "";
      i_unit = "";
      i_pric = 0;
      i_qoor = Convert.ToDouble(t_qoor.Text);
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_bpid", t_ofbp.Text);
      SqlComm.Parameters.AddWithValue("@item", t_item.Text);
      SqlComm.CommandText = "WS_GetItemMaster";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            i_pric = Convert.ToDouble(dr["t_bapr"]);
            i_unit = dr["t_cuni"].ToString();
          }
        }
      }
      catch (Exception ex)
      {
        i_pric = 0;
      }
      try
      {
        i_oamt = (i_qoor * i_pric);
        //t_pric.Text = i_pric.ToString();
        //t_oamt.Text = i_oamt.ToString();
        t_cuni.Text = i_unit;
      }
      catch (Exception ex)
      {

      }

    }
    protected string getItemName(string t_item)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "select case when itm.t_cdf_dsc1 = '' then itm.t_dsca else itm.t_cdf_dsc1 end  as t_desc from swlive..ttcibd001100 itm where ltrim(rtrim(t_item)) = '" + t_item + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_desc"].ToString());
        }
        else
        {
          return ("");
        }
      }
      catch (Exception ex)
      {
        return ("");
      }
    }
    protected string getbpName(string t_bpid)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "select t_nama from swlive..ttccom100100 where t_bpid = '" + t_bpid + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_nama"].ToString());
        }
        else
        {
          return ("");
        }
      }
      catch (Exception ex)
      {
        return ("");
      }
    }
    protected string getSalesOffName(string t_cofc)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "select t_dsca from swlive..ttcmcs065100 where t_cwoc = '" + t_cofc + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_dsca"].ToString());
        }
        else
        {
          return ("");
        }
      }
      catch (Exception ex)
      {
        return ("");
      }
    }
    protected string getWarehouseName(string t_cwar)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        DataTable tab = new DataTable();
        String sQuery = "select t_dsca from swlive..ttcmcs003100 where t_cwar = '" + t_cwar + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_dsca"].ToString());
        }
        else
        {
          return ("");
        }
      }
      catch (Exception ex)
      {
        return ("");
      }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
      try
      {
        //orderfile.PostedFile.SaveAs("DestinationPath");
      }
      catch (Exception ex)
      {

      }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
      string aqty;
      int rqty;
      string pdnosqn, i_orno;
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_quot", t_refb.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_ofbp", t_ofbp.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_cotp", t_cotp.SelectedValue.ToString());
      sqlcom.Parameters.AddWithValue("@t_stbp", t_stbp.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_corn", t_corn.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_refb", t_ofbp.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_cwar", t_cwar.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_cofc", t_cofc.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_item", t_item.Text.ToString());
      sqlcom.Parameters.AddWithValue("@t_qoor", Convert.ToDouble(t_qoor.Text));
      sqlcom.Parameters.AddWithValue("@t_pric", Convert.ToDouble(t_pric.Text));
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      if (Session["t_orno"] != null)
      {
        sqlcom.Parameters.AddWithValue("@t_orno", Session["t_orno"].ToString());
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_orno", null);
      }

      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_SaveWebOrder";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_orno = (string)sqlcom.Parameters["@new_identity"].Value;
        Session.Add("t_orno", i_orno);
        msg1 = result;
        if (result == "success")
        {
          bind_orderdata(i_orno);
          t_qoor.Text = "";
          //t_item.Text = "";
          t_pric.Text = "";
          t_cuni.Text = "";
          //t_oamt.Text = "";
          //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + result + "')", true);
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + result + "')", true);
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string t_cotp,string t_ofbp, string t_stbp, string t_cwar, string t_cofc, string t_refb, string t_corn, string t_item, string t_qoor, string t_pric)
    {
      string aqty;
      int rqty;
      string pdnosqn, i_orno;
      String tabledata;
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_quot", t_refb);
      sqlcom.Parameters.AddWithValue("@t_cotp", t_cotp); 
      sqlcom.Parameters.AddWithValue("@t_ofbp", t_ofbp);
      sqlcom.Parameters.AddWithValue("@t_stbp", t_stbp);
      sqlcom.Parameters.AddWithValue("@t_corn", t_corn);
      sqlcom.Parameters.AddWithValue("@t_refb", t_refb);
      sqlcom.Parameters.AddWithValue("@t_cwar", t_cwar);
      sqlcom.Parameters.AddWithValue("@t_cofc", t_cofc);
      sqlcom.Parameters.AddWithValue("@t_item", t_item);
      sqlcom.Parameters.AddWithValue("@t_qoor", Convert.ToDouble(t_qoor));
      sqlcom.Parameters.AddWithValue("@t_pric", Convert.ToDouble(t_pric));
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      if (HttpContext.Current.Session["t_orno"] != null)
      {
        sqlcom.Parameters.AddWithValue("@t_orno", HttpContext.Current.Session["t_orno"].ToString());
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_orno", null);
      }
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_SaveWebOrder";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_orno = (string)sqlcom.Parameters["@new_identity"].Value;
        HttpContext.Current.Session.Add("t_orno", i_orno);
        msg1 = result;
        if (result == "success")
        {
          //tabledata = bind_orderdata(i_orno);
          //return tabledata;
          return i_orno;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
      return "";
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String bind_orderdata(string i_orno)
    {
      string tabl;
      Double r_qnty, r_amnt;
      r_qnty = 0;
      r_amnt = 0;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_orno", i_orno);
      SqlComm.CommandText = "WS_GetQuotationDetails";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><span class='badge bg-warning'>" + dr["t_pono"].ToString() + "</span></td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td><td>" + dr["t_qnty"].ToString() + "</td><td>" + dr["t_uom"].ToString() + "</td><td>" + dr["t_pric"].ToString() + "</td><td>" + dr["t_oamt"].ToString() + "</td><td class=project-actions text-ight'><button class='btn btn-danger btn-sm' OnClick='Delete_Row();return false;'><i class='fas fa-trash'></i></button></td></tr>";
            r_qnty = r_qnty + Convert.ToDouble(dr["t_qnty"]);
            r_amnt = r_amnt + Convert.ToDouble(dr["t_oamt"]);
          }
        }
        tabl = tabl + "<tr><td></td><td></td><td><strong>Total</strong></td><td><strong>" + r_qnty.ToString() + "</strong><td></td><td></td><td><strong>" + r_amnt.ToString() + "</strong></td></tr>";
        return tabl;
      }
      catch (Exception ex)
      {
        return "";
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] GetPrice(string t_ofbp, string t_item)
    {
        string i_pric;
        string i_unit;
        string[] a_pric;
        i_pric = "";
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;
        SqlComm.Parameters.AddWithValue("@t_bpid",t_ofbp);
        SqlComm.Parameters.AddWithValue("@item", t_item);
        SqlComm.CommandText = "WS_GetItemMaster";
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {
              i_pric = dr["t_bapr"].ToString() + "," + dr["t_cuni"].ToString();

            }
          }
        }
        catch (Exception ex)
        {
          i_pric = "";
        }
        try
        {
          a_pric  = i_pric.Split(',');
          return a_pric;
        }
        catch (Exception ex)
        {
          return null;
        }
    }
  }
}
