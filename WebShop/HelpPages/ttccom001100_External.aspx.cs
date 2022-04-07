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
  public partial class ttccom001100_External : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        getList();
      }
    }
    protected void getList()
    {
      string tabl;
      tabl = "";

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.Text;

      //SqlComm.CommandText = "select distinct t1.t_osrp,t2.t_nama from swlive..ttccom110100 as t1 left join swlive..ttccom001100 as t2 on t1.t_osrp=t2.t_emno";
      SqlComm.CommandText = "select t_emno as t_osrp,t_nama from swlive..ttccom001100";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_osrp"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_osrp"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td></tr>";
          }
        }
        sam.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        ex.Message.ToString();
      }
    }
  }
}
