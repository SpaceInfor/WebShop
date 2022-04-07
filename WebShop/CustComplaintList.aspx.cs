using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;


namespace WebShop
{
  public partial class CustComplaintList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst141100> GetComplaintLines(string t_flag)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("testdb..WS_GetComplaints"))
        {
          cmd.Connection = con;
          cmd.CommandType = CommandType.StoredProcedure;
          if (HttpContext.Current.Session["t_usid"] != null)
          {
            cmd.Parameters.AddWithValue("@t_prbp", HttpContext.Current.Session["t_usid"].ToString());
          }

          cmd.Parameters.AddWithValue("@t_flag", t_flag);

          List<ttdtst141100> InputLines = new List<ttdtst141100>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              InputLines.Add(new ttdtst141100
              {
              //  t_link = sdr["t_link"].ToString(),
                t_cono = sdr["t_cono"].ToString(),
                t_codt = sdr["t_codt"].ToString(),
                t_worn = sdr["t_worn"].ToString(),
                t_orno = sdr["t_orno"].ToString(),
                t_prbp = sdr["t_prbp"].ToString(),
                t_comt = sdr["t_comt"].ToString(),
                t_rsol = sdr["t_rsol"].ToString(),
                t_cost = sdr["t_cost"].ToString(),
                t_cldt = sdr["t_cldt"].ToString(),
                t_user = sdr["t_user"].ToString()
              });
            }
            con.Close();
            return InputLines;
          }
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetStatusDetails()
    {
      string jsonData = "";

      try
      {
        NBDataAccess NBData = new NBDataAccess();
        NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
        SqlCommand SqlComm = new SqlCommand();
        SqlComm.CommandType = CommandType.StoredProcedure;


        SqlComm.CommandText = "WS_ComplaintDashboard";
        //SqlComm.Parameters.AddWithValue("@t_prbp",Session["t_usid"].ToString());
        if (HttpContext.Current.Session["t_usid"].ToString() != null)
        {
          SqlComm.Parameters.AddWithValue("@t_prbp", HttpContext.Current.Session["t_usid"].ToString());
        }
        SqlComm.CommandTimeout = 0;
        DataSet sProdPlanData = new DataSet();
        try
        {
          sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
          foreach (DataTable table in sProdPlanData.Tables)
          {
            foreach (DataRow dr in table.Rows)
            {


              var input = new
              {
                t_open = dr["t_open"].ToString(),
                t_inpr = dr["t_inpr"].ToString(),
                t_clos = dr["t_clos"].ToString(),
                t_pnfs = dr["t_pnfs"].ToString(),
                t_pnfu = dr["t_pnfu"].ToString()
              };
              jsonData = (new JavaScriptSerializer()).Serialize(input);
            }
          }
        }
        catch (Exception ex)
        {
          //error.InnerHtml = ex.Message.ToString();
        }

        return jsonData;
      }

      catch (Exception ex)
      {
        // error.InnerHtml = ex.Message.ToString();
      }
      return jsonData;
    }
  }

  public class ttdtst141100
  {
  //  public string t_link { get; set; }
    public string t_cono { get; set; }

    public string t_codt { get; set; }
    public string t_worn { get; set; }
    public string t_orno { get; set; }

    public string t_prbp { get; set; }
    public string t_nama { get; set; }
    public string t_rsol { get; set; }
    public string t_comt { get; set; }

    public string t_cost { get; set; }
    public string t_user { get; set; }
    public string t_cldt { get; set; }

    public string t_prio { get; set; }
  }
}
