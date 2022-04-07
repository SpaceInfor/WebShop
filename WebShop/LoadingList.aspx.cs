  using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;


namespace WebShop
{
  public partial class LoadingList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        if (Request.QueryString["ORD"] != null)
        {
          
        }
      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<LoadingHeaderClass> GetLoadingHeader()
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec WSL_GetLoadingHeaders"))
        {
          cmd.Connection = con;
          List<LoadingHeaderClass> LoadingHeader = new List<LoadingHeaderClass>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              LoadingHeader.Add(new LoadingHeaderClass
              {
                t_link = "<a href='LoadingSlip.aspx?t_stat="+sdr["t_stta"].ToString()+"&load=" + sdr["t_load"].ToString() + "'><i class='fas fa-arrow-circle-right'></i></a>",
                t_load = sdr["t_load"].ToString(),
                t_orno = sdr["t_orno"].ToString(),
                t_ofbp = sdr["t_ofbp"].ToString(),
                t_stbp = sdr["t_stbp"].ToString(),
                t_date = sdr["t_date"].ToString(),
                t_dest = sdr["t_dest"].ToString(),
                t_lyno = sdr["t_lyno"].ToString(),
                t_lrno = sdr["t_lrno"].ToString(),
                t_lrdt = sdr["t_lrdt"].ToString(),
                t_npak = sdr["t_npak"].ToString(),
                t_carp = sdr["t_carp"].ToString(),
                t_lopk = sdr["t_lopk"].ToString(),
                t_stat = sdr["t_stat"].ToString(),
                t_stta = sdr["t_stta"].ToString(),

              });
            }
          }
          con.Close();
          return LoadingHeader;
        }
      }
    }
  }
  public class LoadingHeaderClass
  {
    public string t_link { get; set; }
    public string t_load { get; set; }
    public string t_orno{ get; set; }
    public string t_ofbp{ get; set; }
    public string t_stbp { get; set; }
    public string t_date { get; set; }
    public string t_dest  { get; set; }
    public string t_lyno  { get; set; }
    public string t_lrno { get; set; }
    public string t_lrdt { get; set; }
    public string t_npak { get; set; }
    public string t_carp { get; set; }
    public string t_lopk { get; set; }
    public string t_stat { get; set; }

    public string t_stta { get; set; }

  }
}
