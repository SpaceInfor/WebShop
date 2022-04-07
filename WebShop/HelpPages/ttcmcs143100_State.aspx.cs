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
  public partial class ttcmcs143100_State : System.Web.UI.Page
  {
    string t_ccty = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        if (Session["t_ccty"] != null)
        {
          HttpContext.Current.Session["t_ccty"] = Session["t_ccty"].ToString();
          t_ccty = Convert.ToString(Session["t_ccty"]);
        }
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

      //SqlComm.Parameters.AddWithValue("@t_ofbp", HttpContext.Current.Session["t_usid"].ToString());
      SqlComm.CommandText = "select t_cste,t_dsca from swlive..ttcmcs143100 where t_ccty='"+ t_ccty + "'";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_cste"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_cste"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td></tr>";
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
