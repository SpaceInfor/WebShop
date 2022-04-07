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
  public partial class tdtst1552m000 : System.Web.UI.Page
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
      string t_prbp;
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.Text;
      t_prbp = HttpContext.Current.Session["t_usid"].ToString();
      //SqlComm.Parameters.AddWithValue("@t_ofbp", HttpContext.Current.Session["t_usid"].ToString());
      SqlComm.CommandText = "select cps.*,bp.t_nama from swlive..ttdtst152100 cps  join swlive..ttccom100100 bp on (bp.t_bpid = cps.t_prbp) where cps.t_prbp = '"+ t_prbp + "'";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_worn"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_worn"].ToString() + "</td><td>" + dr["t_orno"].ToString() + "</td><td>" + dr["t_bpid"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td></tr>";
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
