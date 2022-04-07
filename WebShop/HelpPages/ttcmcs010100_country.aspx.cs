using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AdminMaster.HelpPages
{
  public partial class ttcmcs010100_country : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        getOrderList();

      }
    }
    protected void getOrderList()
    {
      string tabl;
      tabl = "";
     
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.Text;

      SqlComm.CommandText = "select t_ccty,t_dsca from swlive..ttcmcs010100";
      //SqlComm.CommandText = "select t_ccty,t_dsca from swlive..ttcmcs010100 where t_ccty='IND'";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_ccty"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_ccty"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td></tr>";
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
