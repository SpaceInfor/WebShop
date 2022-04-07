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

namespace AdminCIF
{
  public partial class CIFFormList : System.Web.UI.Page
  {
    private static string message = string.Empty;
    private static string message1 = string.Empty;
    private static string Errormessage = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst173100> BindCIFForm(string t_crus)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst173100> Prdlst = new List<ttdtst173100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_crus", t_crus);
          comm.Parameters.AddWithValue("@t_flag", "B");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);

          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst173100
            {
              t_link = sdr["t_link"].ToString().Trim(),
              t_bpid = sdr["t_bpid"].ToString().Trim(),
              t_cbrn = sdr["t_cbrn"].ToString().Trim(),
              t_nama = sdr["t_nama"].ToString().Trim(),
              t_phne = sdr["t_phne"].ToString().Trim(),
              t_mail = sdr["t_mail"].ToString().Trim(),
              t_ln01 = sdr["t_ln01"].ToString().Trim(),
              t_ln02 = sdr["t_ln02"].ToString().Trim(),
              t_ccit = sdr["t_ccit"].ToString().Trim(),
              t_ccitdesc = sdr["t_ccitdesc"].ToString(),
              t_ccty = sdr["t_ccty"].ToString().Trim(),
              t_cctydesc = sdr["t_cctydesc"].ToString(),
              t_cste = sdr["t_cste"].ToString().Trim(),
              t_cstedesc = sdr["t_cstedesc"].ToString(),
              t_shsz = sdr["t_shsz"].ToString().Trim(),
              //t_prod = sdr["t_prod"].ToString().Trim(),
              t_brnd = sdr["t_brnd"].ToString().Trim(),
              t_find = sdr["t_find"].ToString().Trim(),
              t_keye = sdr["t_keye"].ToString().Trim(),
              t_remk = sdr["t_remk"].ToString().Trim(),
              //t_prdd = sdr["t_prdd"].ToString().Trim(),
              t_brdd = sdr["t_brdd"].ToString().Trim(),
              t_chan = sdr["t_chan"].ToString().Trim(),
              t_chandesc = sdr["t_chandesc"].ToString().Trim(),
              t_badd = sdr["t_badd"].ToString().Trim(),
              t_pstc = sdr["t_pstc"].ToString().Trim(),
              t_bgst = sdr["t_bgst"].ToString().Trim(),
              t_panu = sdr["t_panu"].ToString().Trim(),
              t_sadd = sdr["t_sadd"].ToString().Trim(),
              t_spin = sdr["t_spin"].ToString().Trim(),
              t_sgst = sdr["t_sgst"].ToString().Trim(),
              t_shfr = sdr["t_shfr"].ToString().Trim(),
              t_tofl = sdr["t_tofl"].ToString().Trim(),
              t_cpay = sdr["t_cpay"].ToString().Trim(),
              t_cpaydesc = sdr["t_cpaydesc"].ToString().Trim(),
              t_paym = sdr["t_paym"].ToString().Trim(),
              t_paymdesc = sdr["t_paymdesc"].ToString().Trim(),
              t_crli = sdr["t_crli"].ToString().Trim(),
              t_cday = sdr["t_cday"].ToString().Trim(),
              t_sals = sdr["t_sals"].ToString().Trim(),
              t_salsdesc = sdr["t_salsdesc"].ToString().Trim(),
              t_crep = sdr["t_crep"].ToString().Trim(),
              t_crepdesc = sdr["t_crepdesc"].ToString().Trim(),
              t_osrp = sdr["t_osrp"].ToString().Trim(),
              t_osrpdesc = sdr["t_osrpdesc"].ToString().Trim(),
              t_emsr = sdr["t_emsr"].ToString().Trim(),
              t_cntp = sdr["t_cntp"].ToString().Trim(),
              t_namd = sdr["t_namd"].ToString().Trim(),
              t_cntr = sdr["t_cntr"].ToString().Trim(),
              t_cntrdesc = sdr["t_cntrdesc"].ToString().Trim(),
              t_stte = sdr["t_stte"].ToString().Trim(),
              t_sttedesc = sdr["t_sttedesc"].ToString().Trim(),
              t_city = sdr["t_city"].ToString().Trim(),
              t_citydesc = sdr["t_citydesc"].ToString().Trim(),
              t_samb = Convert.ToInt32(sdr["t_samb"].ToString().Trim()),
              t_cnmo = sdr["t_cnmo"].ToString().Trim(),
              t_cnem = sdr["t_cnem"].ToString().Trim(),
              t_swdi = sdr["t_swdi"].ToString(),
              t_noos = sdr["t_noos"].ToString(),
              t_nook = sdr["t_nook"].ToString(),
              t_noow = sdr["t_noow"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Prdlst;
        }
      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

  }
}
