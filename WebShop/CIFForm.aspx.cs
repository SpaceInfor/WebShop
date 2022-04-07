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
  public partial class CIFForm : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!Page.IsPostBack)
      {
        populateCity();
      }
    }
    protected void populateCity()
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
        String sQuery = "select * from swlive..ttccom139100 where t_ccty='IND'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();

        if (tab.Rows.Count > 0)
        {
          t_ccit.DataSource = tab;
          t_ccit.DataTextField = "t_dsca";
          t_ccit.DataValueField = "t_city";
          t_ccit.DataBind();
        }
        else
        {

        }
      }
      catch (Exception ex)
      {

      }
    }
    
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String bind_CustomerData(string t_prbp)
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
      SqlComm.Parameters.AddWithValue("@t_prbp", t_prbp);
      SqlComm.CommandText = "WS_getSecondaryBP";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><span class='badge bg-warning'>" + dr["t_bpid"].ToString() + "</span></td><td>" + dr["t_desc"].ToString() + "</td><td>" + dr["t_ln01"].ToString() + "</td><td>" + dr["t_ln02"].ToString() + "</td><td>" + dr["t_ccit"].ToString() + "</td><td>" + dr["t_phne"].ToString() + "</td><td>" + dr["t_mail"].ToString() + "</td><td class=project-actions text-ight'><button class='btn btn-danger btn-sm' OnClick='Delete_Row();return false;'><i class='fas fa-trash'></i></button></td></tr>";
          }
        }
        return tabl;
      }
      catch (Exception ex)
      {
        return "";
      }
    }
    
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string t_nama, string t_phne, string t_mail, string t_ln01, string t_ln02,string t_ccit)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom  = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_prbp", HttpContext.Current.Session["t_usid"].ToString());
      sqlcom.Parameters.AddWithValue("@t_nama", t_nama);
      sqlcom.Parameters.AddWithValue("@t_phne", t_phne);
      sqlcom.Parameters.AddWithValue("@t_mail", t_mail);
      sqlcom.Parameters.AddWithValue("@t_ln01", t_ln01);
      sqlcom.Parameters.AddWithValue("@t_ln02", t_ln02);
      sqlcom.Parameters.AddWithValue("@t_ccit", t_ccit);
      sqlcom.Parameters.AddWithValue("@t_ccty", "IND");
      sqlcom.CommandText = "WS_SaveCIFForm";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
      return "";
    }
  }
}
