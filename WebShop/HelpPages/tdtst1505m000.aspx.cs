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
  public partial class tdtst1505m000 : System.Web.UI.Page
  {
    string bpid;
    protected void Page_Load(object sender, EventArgs e)
    {
      bpid = Request.QueryString["param1"].ToString();
      if (!IsPostBack)
      {
        getItemList();
      }
    }
    protected void getItemList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
      SqlComm.Parameters.AddWithValue("@item",null);
      SqlComm.CommandText = "WS_GetCustItemMaster";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_item"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_item"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td><td>" + dr["t_unit"].ToString() + "</td></tr>";
          }
        }
        sam.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        //error.InnerHtml = ex.Message.ToString();
      }
    } 
  }
}
