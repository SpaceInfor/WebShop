using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web;

namespace WebShop.HelpPages
{
  public partial class tdsls4500m001 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
      //  getOrderList();
        
      }
    }
    protected void getOrderList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.StoredProcedure;
  
      SqlComm.CommandText = "ws_getPackedSalesOrders";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_orno"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_orno"].ToString() + "</td><td>" + dr["t_ofbp"].ToString() + "</td><td>" + dr["t_stbp"].ToString() + "</td><td>" + dr["t_pdat"].ToString() + "</td><td>" + dr["t_qoor"].ToString() + "</td><td>" + dr["t_nopk"].ToString() + "</td><td>" + dr["t_stat"].ToString() + "</td></tr>";
          }
        }
        //sam.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        //error.InnerHtml = ex.Message.ToString();
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetSalesOrders()
    {
     
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec  ws_getPackedSalesOrders"))
        {
          cmd.Connection = con;
          List<SalesOrderClass> SalesOrders = new List<SalesOrderClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              SalesOrders.Add(new SalesOrderClass
              {
                t_olnk = "<button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + sdr["t_orno"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button>",
                t_orno = sdr["t_orno"].ToString(),
                t_ofbp = sdr["t_ofbp"].ToString(),
                t_stbp = sdr["t_stbp"].ToString(),
                t_pdat = sdr["t_pdat"].ToString(),
                t_qoor = sdr["t_qoor"].ToString(),
                t_nopk = sdr["t_nopk"].ToString(),
                t_stat = sdr["t_stat"].ToString()

              }); ; ;
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }

  }

  public class SalesOrderClass
  {
    public string t_olnk { get; set; }
    public string t_orno { get; set; }
    public string t_ofbp { get; set; }
    public string t_stbp { get; set; }
    public string t_pdat { get; set; }
    public string t_qoor { get; set; }
    public string t_nopk { get; set; }
    public string t_stat { get; set; }

  }
}
