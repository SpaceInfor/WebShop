using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace WebShop
{
  public partial class SalesOrderRemarkList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
        GetOrderList();
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
      /*if (Session["t_orno"] != null)
      {
        SqlComm.Parameters.AddWithValue("@t_ofbp", Session["t_bpid"].ToString());
      }*/

      SqlComm.CommandText = "WS_GetSoExceptions";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><a href='ExceptionForm.aspx?ORD=" + dr["t_orno"].ToString() + "'><i class='fa fa-fw fa-arrow-right'></i></a></td><td>" + dr["t_orno"].ToString() + "</td><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_odat"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td><td>" + dr["t_oamt"].ToString() + "</td><td>" + dr["t_rmsh"].ToString() + "</td><td>" + dr["t_dldt"].ToString() + "</td><td>" + dr["t_devi"].ToString() + "</td><td>" + dr["t_appr"].ToString() + "</td><td>" + dr["t_apus"].ToString() + "</td></tr>";
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
