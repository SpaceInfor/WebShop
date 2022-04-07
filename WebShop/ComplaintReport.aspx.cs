using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Net;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;
namespace WebShop
{
  public partial class ComplaintReport : System.Web.UI.Page
  {
    private static string message = string.Empty;
 
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst141100_142> GetComplaintDetails(string t_codtF, string t_codtT)
    {
      //string t_usid,
      //string Fromdate = string.Empty;
      //string ToDate = string.Empty;
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst141100_142> Prdlst = new List<ttdtst141100_142>();
    
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_GetComplaintReport]", con);
          comm.CommandType = CommandType.StoredProcedure;
          //comm.Parameters.AddWithValue("@t_usid", t_usid);
          //Fromdate = t_codtF.ToString("yyyy-MM-dd");
          //ToDate = t_codtT.ToString("yyyy-MM-dd");
          comm.Parameters.AddWithValue("@t_codtF", t_codtF);
          comm.Parameters.AddWithValue("@t_codtT", t_codtT);
          comm.Parameters.AddWithValue("@t_flag", "S");
         

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst141100_142
            {
              t_cono = sdr["Complaint_No"].ToString(),
              t_codt = sdr["Complaint_Date"].ToString(),
              t_worn = sdr["CPS_Order_No"].ToString(),
              t_orno = sdr["Sales_Order"].ToString(),
              t_prbp = sdr["Customer_Id"].ToString(),
              t_nama = sdr["Customer_Name"].ToString(),
              t_rsol = sdr["Complaint_Redressal"].ToString(),
              t_comt = sdr["Complaint_Text"].ToString(),
              t_cost = sdr["Complaint_Status"].ToString(),
              t_user = sdr["UserId"].ToString(),
              t_namauser = sdr["UserName"].ToString(),
              t_cldt = sdr["Closure_Date"].ToString(),
              t_prio = sdr["Priority_Status"].ToString(),
              t_ackn = Convert.ToInt32(sdr["Acknowledge"].ToString()),
              t_lmdt = sdr["LastModificationDate"].ToString(),
              //t_lmus = sdr["t_lmus"].ToString(),
              t_appr = Convert.ToInt32(sdr["apprStatus"].ToString()),
              t_reco = Convert.ToInt32(sdr["Recommend_For_FOC"].ToString()),
              t_pono = Convert.ToInt32(sdr["Position"].ToString()),
              t_date = sdr["Update_Date"].ToString(),
              t_rsolLine = sdr["Complaint_Redressal_Line"].ToString(),
              t_userd = sdr["Closed_By"].ToString(),
              updatedUser = sdr["Closed_By_User"].ToString()
            });
          }
          con.Close();
          //message = (string)comm.Parameters["@t_mesg"].Value.ToString();
          return Prdlst;
        }


      }
      catch (Exception ex)
      {
        throw ex;
      }

    }


  }

  public class ttdtst141100_142
  {


    public string t_cono { get; set; }
    public string t_codt { get; set; }
    public string t_worn { get; set; }
    public string t_orno { get; set; }
    public string t_prbp { get; set; }
    public string t_nama { get; set; }
    public string t_comt { get; set; }
    public string t_rsol { get; set; }

    public string t_cost { get; set; }
    public string t_prio { get; set; }
    public string t_cldt { get; set; }
    public string t_user { get; set; }
    public string t_namauser { get; set; }
    public int t_ackn { get; set; }
    public string t_lmdt { get; set; }
    public string t_lmus { get; set; }
    public int t_appr { get; set; }
    public int t_reco { get; set; }

    public int t_pono { get; set; }
    public string t_date { get; set; }
    public string t_rsolLine { get; set; }
    public string t_userd { get; set; }
    public string updatedUser { get; set; }

    //public string Complaint_No { get; set; }
    //public string Complaint_Date { get; set; }
    //public string CPS_Order_No { get; set; }
    //public string Sales_Order { get; set; }
    //public string Customer_Id { get; set; }
    //public string Customer_Name { get; set; }
    //public string Complaint_Text { get; set; }
    //public string Complaint_Redressal { get; set; }

    //public string Complaint_Status { get; set; }
    //public string Priority_Status { get; set; }
    //public string Closure_Date { get; set; }
    //public string UserId { get; set; }
    //public string UserName { get; set; }
    //public int Acknowledge { get; set; }
    //public string LastModificationDate { get; set; }
    ////public string t_lmus { get; set; }
    //public int apprStatus { get; set; }
    //public int Recommend_For_FOC { get; set; }

    //public int Position { get; set; }
    //public string Update_Date { get; set; }
    //public string Complaint_Redressal_Line { get; set; }
    //public string Closed_By { get; set; }
    //public string Closed_By_User { get; set; }

  }


}
