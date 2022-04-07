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
  public partial class ttcmcs013100_PaymentTerms : System.Web.UI.Page
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

      //SqlComm.Parameters.AddWithValue("@t_ofbp", HttpContext.Current.Session["t_usid"].ToString());
      SqlComm.CommandText = "SELECT t_cpay,t_dsca FROM swlive..ttcmcs013100";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_cpay"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_cpay"].ToString() + "</td><td>" + dr["t_dsca"].ToString() + "</td></tr>";
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
