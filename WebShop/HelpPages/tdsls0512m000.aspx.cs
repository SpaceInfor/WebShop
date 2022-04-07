using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebShop.HelpPages
{
  public partial class tdsls0512m000 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        getsalesOfficeList();
        
      }
    }
    protected void getsalesOfficeList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@t_euni", Session["t_eunt"].ToString());
      SqlComm.CommandText = "WS_GetSalesOffice";
      DataSet sProdPlanData = new DataSet(); 
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_cwoc"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_cwoc"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td><td>" + dr["t_city"].ToString() + "</td></tr>";
          }
        }
        salesoff.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        //error.InnerHtml = ex.Message.ToString();
      }
    } 
  }
}
