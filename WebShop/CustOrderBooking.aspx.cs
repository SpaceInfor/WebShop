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
  public partial class CustOrderBooking : System.Web.UI.Page
  {
    string orderid;
    protected void Page_Load(object sender, EventArgs e)
    {

      if (!IsPostBack)
      {

        if (Request.QueryString["ORD"] != null)
        {
          bindOrderDetails(Request.QueryString["ORD"].ToString());    
        }
        if (Request.QueryString["SCP"] != null)
        {
          orderid = getNewOrderID();
          HttpContext.Current.Session.Add("t_orno", orderid);
        }

        if (t_cotp.SelectedIndex >= 1)
        {
          t_morn.Enabled = true;
          btnMorn.Disabled = false;
          t_morn.CssClass = t_morn.CssClass + " form-control";
        }
        else
        {
          t_morn.Enabled = false;
          btnMorn.Disabled = true;
          t_morn.CssClass = t_morn.CssClass + " form-control";
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
        String sQuery = "exec WS_GetCustOrdDetails @t_orno='" + t_orno + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();

        if (tab.Rows.Count > 0)
        {
          t_cotp.SelectedValue = tab.Rows[0]["t_qtyp"].ToString();
          t_ofbp.Text = tab.Rows[0]["t_bpid"].ToString();
          //t_ofbp_nama.InnerText = tab.Rows[0]["t_ofnam"].ToString();
          t_morn.Text = tab.Rows[0]["t_morn"].ToString();
          //t_stbp_nama.InnerText = tab.Rows[0]["t_stnam"].ToString();
          t_refb.Text = tab.Rows[0]["t_quot"].ToString();
          t_incl.Text = tab.Rows[0]["t_incl"].ToString();
          t_dlcd.Text = tab.Rows[0]["t_dlcd"].ToString();
          t_item.Text = tab.Rows[0]["t_item"].ToString();
          t_rmrk.Text = tab.Rows[0]["t_rmrk"].ToString();
          t_qoor.Text = tab.Rows[0]["t_qnty"].ToString();
        }
      }
      catch (Exception ex)
      {

      }
    }
    protected string getNewOrderID()
    {
      string pdnosqn, i_orno;
      String tabledata;
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_GetCustOrderNo";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_orno = (string)sqlcom.Parameters["@new_identity"].Value;
        HttpContext.Current.Session.Add("t_orno", i_orno);
        msg1 = result;
        if (result == "success")
        {
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
    protected void t_item_TextChanged(object sender, EventArgs e)
    {
      t_item_desc.InnerText = getItemName(t_item.Text);
    }
    protected void t_cprj_TextChanged(object sender, EventArgs e)
    {
      t_cprj_desc.InnerText = get_project_name(t_cprj.Text);
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
      SqlComm.Parameters.AddWithValue("@t_bpid", Session["UID"].ToString());
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
      }
      catch (Exception ex)
      {
      }
    }
    protected string get_project_name(string t_cprj)
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
        String sQuery = "select t_pnam from swlive..ttdtst106100 where ltrim(rtrim(t_cprj)) = '" + t_cprj + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();
        if (tab.Rows.Count > 0)
        {
          return (tab.Rows[0]["t_pnam"].ToString());
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
        String sQuery = "select t_dsca from swlive..ttdtst105100 where ltrim(rtrim(t_item)) = '" + t_item + "'";
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
    
    protected void t_ofbp_TextChanged(object sender, EventArgs e)
    {
      t_ofbp_nama.InnerText = getbpName(t_ofbp.Text);
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
        String sQuery = "select t_desc from swlive..ttdtst100100 where t_bpid = '" + t_bpid + "'";
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
    protected void uploadFile_Click(object sender, EventArgs e)
    {
      String filename, downloadpath;
      if (UploadImages.HasFiles)
      {
        string folderPath = Server.MapPath("~/FileUpload/"+ HttpContext.Current.Session["t_usid"].ToString() + "/" + Session["t_orno"].ToString().Trim() + "/");
        string Shortpath = "FileUpload/" + HttpContext.Current.Session["t_usid"].ToString() + "/" + Session["t_orno"].ToString().Trim() + "/";

        if (!Directory.Exists(folderPath))
        {
          Directory.CreateDirectory(folderPath);
        }
        foreach (HttpPostedFile uploadedFile in UploadImages.PostedFiles)
        {
          uploadedFile.SaveAs(folderPath + Path.GetFileName(uploadedFile.FileName));
          filename = folderPath + uploadedFile.FileName.Trim();
          downloadpath = Shortpath + uploadedFile.FileName.Trim();
          listofuploadedfiles.Text += String.Format("{0}<br />", uploadedFile.FileName);
          NBDataAccess NBData = new NBDataAccess();
          NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
          SqlCommand sqlcom = new SqlCommand();
          sqlcom.CommandType = CommandType.StoredProcedure;
          sqlcom.Parameters.AddWithValue("@t_worn", Session["t_orno"].ToString());
          sqlcom.Parameters.AddWithValue("@t_path", filename);
          sqlcom.Parameters.AddWithValue("@t_atph", downloadpath);
          sqlcom.Parameters.AddWithValue("@t_atnm", uploadedFile.FileName);
          sqlcom.CommandText = "WS_CustOrderAttachments";

          string result = "", msg1 = "";
          try
          {
            result = NBData.ExecuteCommand(sqlcom, ref objErr);
            msg1 = result;
            if (result == "success")
            {
            }
          }
          catch (Exception ex)
          {
            result = ex.Message;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + result + "')", true);
          }
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string t_refb,string t_ofbp, string t_morn, string t_incl, string t_dlcd, string t_item, string t_qoor,string t_qtyp,String t_rmrk,String t_cprj)
    {
      
      string pdnosqn, i_orno;
      String tabledata;
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_orno", HttpContext.Current.Session["t_orno"].ToString().Trim());
      sqlcom.Parameters.AddWithValue("@t_quot", t_refb);
      sqlcom.Parameters.AddWithValue("@t_ofbp", t_ofbp);
      sqlcom.Parameters.AddWithValue("@t_item", t_item);
      sqlcom.Parameters.AddWithValue("@t_qoor", Convert.ToDouble(t_qoor));
      sqlcom.Parameters.AddWithValue("@t_incl", t_incl);
      sqlcom.Parameters.AddWithValue("@t_dlcd", t_dlcd);
      sqlcom.Parameters.AddWithValue("@t_morn", t_morn);
      sqlcom.Parameters.AddWithValue("@t_qtyp", Convert.ToDouble(t_qtyp));
      sqlcom.Parameters.AddWithValue("@t_prbp", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_rmrk", t_rmrk);
      sqlcom.Parameters.AddWithValue("@t_cprj", t_cprj);
      sqlcom.Parameters.AddWithValue("@t_mode", "A");
      sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_SaveCustOrder";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_orno = (string)sqlcom.Parameters["@new_identity"].Value;
        HttpContext.Current.Session.Add("t_orno", null);
        msg1 = result;
        if (result == "success")
        {
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
    public static String bind_orderdata (string i_orno)
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



    protected void t_cotp_SelectedIndexChanged(object sender, EventArgs e)
    {
      if (t_cotp.SelectedIndex >= 1)
      {
        t_morn.Enabled = true;
        btnMorn.Disabled = false;
        t_morn.CssClass = t_morn.CssClass + " form-control";
      }
      else
      {
        t_morn.Enabled = false;
        btnMorn.Disabled = true;
        t_morn.CssClass = t_morn.CssClass + " form-control";
      }
    }
  }


}
