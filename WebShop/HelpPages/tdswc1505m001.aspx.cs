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
  public partial class tdswc1505m001 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        getBpList();

      }
    }
    protected void getBpList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.Text;
      SqlComm.CommandText = "select t1.t_orno,t2.t_bpid,t2.t_nama from swlive..ttdswc105100 as t1 left join swlive..ttccom100100 as t2 on t1.t_bpid=t2.t_bpid";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            //tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_orno"].ToString().Trim() + "')><i class='fas fa-arrow-circle-left'></i></button></td>" +
            //  "<td>" + dr["t_orno"].ToString().Trim() + "</td>" +
            //  "<td>" + dr["t_bpid"].ToString().Trim() + "</td>+<td>" + dr["t_nama"].ToString().Trim() + "</td></tr>";
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_orno"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_orno"].ToString() + "</td><td>" + dr["t_bpid"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td></tr>";
            //tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_dorn"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_dorn"].ToString() + "</td><td>" + dr["t_cprj"].ToString() + "</td><td>" + dr["t_date"].ToString() + "</td><td>" + dr["t_clag"].ToString() + "</td><td>" + dr["t_cmod"].ToString() + "</td></tr>";
          }

        }
        sam.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        //error.InnerHtml = ex.Message.ToString();
        throw ex;
      }
    }
  }
}
