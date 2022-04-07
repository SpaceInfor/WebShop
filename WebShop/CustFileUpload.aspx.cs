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
  public partial class CustFileUpload : System.Web.UI.Page
  {
    string t_worn;
    protected void Page_Load(object sender, EventArgs e)
    {

      if (Request.QueryString["ORD"] != null)
      {
        t_worn = Request.QueryString["ORD"].ToString();
      }
      if (!IsPostBack)
      {
        GetOrderFileList();
      }
    }
    protected void GetOrderFileList()
    {
      string tabl;
      String weburl;
      tabl = "";
      weburl = System.Configuration.ConfigurationManager.ConnectionStrings["DownloadPath"].ConnectionString;

      string customerid = Session["t_usid"].ToString();
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_worn", t_worn);
      SqlComm.CommandText = "WS_GetCustOrderFile";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_pono"].ToString() + "</td><td>"+ dr["t_atnm"].ToString() + "</td><td><a href='" + weburl + dr["t_atph"].ToString() + "' class='btn btn-default btn - sm float-right' target='_blank'><i class='fas fa-cloud-download-alt'></i></a></td></tr>";
          }
        }
        order.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
      }
    }
  }
}
