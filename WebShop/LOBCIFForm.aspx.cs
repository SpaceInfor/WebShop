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
  public partial class LOBCIFForm : System.Web.UI.Page
  {
    private static string message = string.Empty;
    private static string message1 = string.Empty;
    private static string Errormessage = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
      {
        
      }
    }
    
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs010100> GetCountryName(string t_ccty)
    {
      HttpContext.Current.Session["t_ccty"] = t_ccty;
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs010100> lst = new List<ttcmcs010100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_ccty", t_ccty);
          comm.Parameters.AddWithValue("@t_flag", "CON");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs010100
            {
              t_ccty = sdr["t_ccty"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs010100> GetShippingCountryName(string t_ccty)
    {
      HttpContext.Current.Session["t_ccty"] = t_ccty;
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs010100> lst = new List<ttcmcs010100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_ccty", t_ccty);
          comm.Parameters.AddWithValue("@t_flag", "CON");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs010100
            {
              t_ccty = sdr["t_ccty"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs143100> GetStateName(string t_cste)
    {
      HttpContext.Current.Session["t_cste"] = t_cste;
    
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs143100> lst = new List<ttcmcs143100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_cste", t_cste);
          comm.Parameters.AddWithValue("@t_flag", "STA");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs143100
            {
              t_cste = sdr["t_cste"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs143100> GetShippingStateName(string t_cste)
    {
      HttpContext.Current.Session["t_cste"] = t_cste;

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs143100> lst = new List<ttcmcs143100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_cste", t_cste);
          comm.Parameters.AddWithValue("@t_flag", "STA");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs143100
            {
              t_cste = sdr["t_cste"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttccom139100> GetCityName(string t_ccit)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttccom139100> lst = new List<ttccom139100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_ccit", t_ccit);
          comm.Parameters.AddWithValue("@t_flag", "CTY");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttccom139100
            {
              t_city = sdr["t_city"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttccom139100> GetShippingCityName(string t_ccit)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttccom139100> lst = new List<ttccom139100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_ccit", t_ccit);
          comm.Parameters.AddWithValue("@t_flag", "CTY");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttccom139100
            {
              t_city = sdr["t_city"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs066100> GetChannelName(string t_chan)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs066100> lst = new List<ttcmcs066100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_chan", t_chan);
          comm.Parameters.AddWithValue("@t_flag", "CHN");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs066100
            {
              t_chan = sdr["t_chan"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs013100> GetPaymentTermsName(string t_cpay)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs013100> lst = new List<ttcmcs013100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_cpay", t_cpay);
          comm.Parameters.AddWithValue("@t_flag", "PAY");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs013100
            {
              t_cpay = sdr["t_cpay"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }
    
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttfcmg003100> GetPaymentModeName(string t_paym)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttfcmg003100> lst = new List<ttfcmg003100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_paym", t_paym);
          comm.Parameters.AddWithValue("@t_flag", "PAM");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttfcmg003100
            {
              t_paym = sdr["t_paym"].ToString(),
              t_desc = sdr["t_desc"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttcmcs031100> GetSalesSegment(string t_cbrn)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttcmcs031100> lst = new List<ttcmcs031100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_cbrn", t_cbrn);
          comm.Parameters.AddWithValue("@t_flag", "SEG");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttcmcs031100
            {
              t_cbrn = sdr["t_cbrn"].ToString(),
              t_dsca = sdr["t_dsca"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttccom110100> GetInternalCollResponsible(string t_crep)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttccom110100> lst = new List<ttccom110100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_crep", t_crep);
          comm.Parameters.AddWithValue("@t_flag", "INT");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttccom110100
            {
              t_crep = sdr["t_crep"].ToString(),
              t_nama = sdr["t_nama"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttccom110100> GetExternalCollResponsible(string t_osrp)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttccom110100> lst = new List<ttccom110100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_osrp", t_osrp);
          comm.Parameters.AddWithValue("@t_flag", "EXT");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            lst.Add(new ttccom110100
            {
              t_osrp = sdr["t_osrp"].ToString(),
              t_nama = sdr["t_nama"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return lst;
        }
      }
      catch (Exception ex)
      {
        throw ex;

      }
    }

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public static List<ListItem> GetProduct(string t_cbrn)
    //{
    //  string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    //  string query = "select t_pdid,t_item from swlive..ttdtst174100 where t_cbrn='"+ t_cbrn +"'";
    //  //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    //  using (SqlConnection con = new SqlConnection(constr))
    //  {
    //    using (SqlCommand cmd = new SqlCommand(query))
    //    {
    //      List<ListItem> customers = new List<ListItem>();
    //      cmd.CommandType = CommandType.Text;
    //      cmd.Connection = con;
    //      con.Open();
    //      using (SqlDataReader sdr = cmd.ExecuteReader())
    //      {
    //        while (sdr.Read())
    //        {
    //          customers.Add(new ListItem
    //          {
    //            Value = sdr["t_pdid"].ToString(),
    //            Text = sdr["t_item"].ToString()
    //          });
    //        }
    //      }
    //      con.Close();
    //      return customers;
    //    }
    //  }
    //}
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ListItem> GetBrand(string t_cbrn)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      string query = "select t_brid,t_brnd from swlive..ttdtst175100 where t_cbrn='" + t_cbrn + "'";
      //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand(query))
        {
          List<ListItem> customers = new List<ListItem>();
          cmd.CommandType = CommandType.Text;
          cmd.Connection = con;
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              customers.Add(new ListItem
              {
                Value = sdr["t_brid"].ToString(),
                Text = sdr["t_brnd"].ToString()
              });
            }
          }
          con.Close();
          return customers;
        }
      }
    }

    [System.Web.Services.WebMethod]
    public static String[] saveLOBCIF(string t_bpid,string t_cbrn, string t_nama, string t_phne, string t_mail, string t_ln01,
    string t_ln02, string t_ccit,string t_ccty,string t_cste,string t_shsz, string t_brnd, string t_find, string t_swdi, string t_keye, string t_remk,string t_brdd, string t_chan, string t_badd, string t_pstc, string t_bgst, string t_panu, string t_sadd, string t_spin, string t_sgst, string t_shfr, string t_tofl, string t_cpay, string t_paym, string t_crli, string t_cday, string t_sals, string t_crep, string t_osrp, string t_emsr, string t_cntp, string t_namd,string t_cntr,string t_stte,string t_city,string t_samb,string t_crus, string t_cnmo, string t_cnem,string t_noos,string t_nook,string t_noow,string t_flag)
    {
      
    
      string i_msg;
      i_msg = "";
     
      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_bpid", t_bpid);
      sqlcom.Parameters.AddWithValue("@t_cbrn", t_cbrn);
      sqlcom.Parameters.AddWithValue("@t_nama", t_nama);
      sqlcom.Parameters.AddWithValue("@t_phne", t_phne);
      sqlcom.Parameters.AddWithValue("@t_mail", t_mail);
      sqlcom.Parameters.AddWithValue("@t_ln01", t_ln01);
      sqlcom.Parameters.AddWithValue("@t_ln02", t_ln02);
      sqlcom.Parameters.AddWithValue("@t_ccit", t_ccit);
      sqlcom.Parameters.AddWithValue("@t_ccty", t_ccty);
      sqlcom.Parameters.AddWithValue("@t_cste", t_cste);

      sqlcom.Parameters.AddWithValue("@t_shsz", t_shsz);
     
      sqlcom.Parameters.AddWithValue("@t_brnd", t_brnd);


      if(t_find=="")
      {
        sqlcom.Parameters.AddWithValue("@t_find", "");
      }
      else
      { 
      sqlcom.Parameters.AddWithValue("@t_find", t_find);
      }
      sqlcom.Parameters.AddWithValue("@t_swdi", t_swdi);
      sqlcom.Parameters.AddWithValue("@t_keye", t_keye);
      sqlcom.Parameters.AddWithValue("@t_remk", t_remk);
   
      sqlcom.Parameters.AddWithValue("@t_brdd", t_brdd);

      sqlcom.Parameters.AddWithValue("@t_chan", t_chan);
      sqlcom.Parameters.AddWithValue("@t_badd", t_badd);
      sqlcom.Parameters.AddWithValue("@t_pstc", t_pstc);
      sqlcom.Parameters.AddWithValue("@t_bgst", t_bgst);
      sqlcom.Parameters.AddWithValue("@t_panu", t_panu);
      sqlcom.Parameters.AddWithValue("@t_sadd", t_sadd);
      sqlcom.Parameters.AddWithValue("@t_spin", t_spin);
      sqlcom.Parameters.AddWithValue("@t_sgst", t_sgst);
      sqlcom.Parameters.AddWithValue("@t_shfr", t_shfr);
      sqlcom.Parameters.AddWithValue("@t_tofl", t_tofl);
      sqlcom.Parameters.AddWithValue("@t_cpay", t_cpay);
      sqlcom.Parameters.AddWithValue("@t_paym", t_paym);
      sqlcom.Parameters.AddWithValue("@t_crli", t_crli);
      sqlcom.Parameters.AddWithValue("@t_cday", t_cday);
      sqlcom.Parameters.AddWithValue("@t_sals", t_sals);
      sqlcom.Parameters.AddWithValue("@t_crep", t_crep);
      sqlcom.Parameters.AddWithValue("@t_osrp", t_osrp);
      sqlcom.Parameters.AddWithValue("@t_emsr", t_emsr);
      sqlcom.Parameters.AddWithValue("@t_cntp", t_cntp);
      sqlcom.Parameters.AddWithValue("@t_namd", t_namd);
      sqlcom.Parameters.AddWithValue("@t_cntr", t_cntr);
      sqlcom.Parameters.AddWithValue("@t_stte", t_stte);
      sqlcom.Parameters.AddWithValue("@t_city", t_city);
      sqlcom.Parameters.AddWithValue("@t_samb", t_samb);
      sqlcom.Parameters.AddWithValue("@t_crus", t_crus);
      sqlcom.Parameters.AddWithValue("@t_cnmo", t_cnmo);
      sqlcom.Parameters.AddWithValue("@t_cnem", t_cnem);
      sqlcom.Parameters.AddWithValue("@t_noos", t_noos);
      sqlcom.Parameters.AddWithValue("@t_nook", t_nook);
      sqlcom.Parameters.AddWithValue("@t_noow", t_noow);
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
    
      sqlcom.CommandText = "testdb..[WS_LOBCIFForm]";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
       
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString().Trim();
        msg1 = result;
        string comb =  i_msg ;
        output = comb.Split(',');
        if (result == "success")
        {
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      return output;
    }

    [System.Web.Services.WebMethod]
    public static String[] saveLOBCIFDetails(string t_bpid,string t_rmak, string t_flag)
    {


      string i_msg;
      i_msg = "";

      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_bpid", t_bpid);
      sqlcom.Parameters.AddWithValue("@t_remk", t_rmak);
     
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;

      sqlcom.CommandText = "testdb..[WS_LOBCIFDetails]";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);

        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString().Trim();
        msg1 = result;
        string comb = i_msg;
        output = comb.Split(',');
        if (result == "success")
        {
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      return output;
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst173100> GetCIFForm(string t_bpid)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst173100> Prdlst = new List<ttdtst173100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_bpid", t_bpid);

          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst173100
            {
              
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
              t_paym = sdr["t_paym"].ToString().Trim(),
              t_crli = sdr["t_crli"].ToString().Trim(),
              t_cday = sdr["t_cday"].ToString().Trim(),
              t_sals = sdr["t_sals"].ToString().Trim(),
              t_crep = sdr["t_crep"].ToString().Trim(),
              t_osrp = sdr["t_osrp"].ToString().Trim(),
              t_emsr = sdr["t_emsr"].ToString().Trim(),
              t_cntp = sdr["t_cntp"].ToString().Trim(),
              t_namd = sdr["t_namd"].ToString().Trim(),
              t_cntr = sdr["t_cntr"].ToString().Trim(),
              t_cntrdesc = sdr["t_cntrdesc"].ToString().Trim(),
              t_stte = sdr["t_stte"].ToString().Trim(),
              t_sttedesc = sdr["t_sttedesc"].ToString().Trim(),
              t_city = sdr["t_city"].ToString().Trim(),
              t_citydesc = sdr["t_citydesc"].ToString().Trim(),
              t_samb=Convert.ToInt32(sdr["t_samb"].ToString().Trim()),
              t_cnmo = sdr["t_cnmo"].ToString().Trim(),
              t_cnem = sdr["t_cnem"].ToString().Trim(),
              t_swdi =sdr["t_swdi"].ToString().Trim(),
              t_noos =sdr["t_noos"].ToString().Trim(),
              t_nook =sdr["t_nook"].ToString().Trim(),
              t_noow =sdr["t_noow"].ToString().Trim()

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

    [System.Web.Services.WebMethod]
    public static String[] deleteCIFDetails(string t_bpid)
    {
      string i_msg;
      string comb = string.Empty;
      i_msg = "";
     
      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_bpid", t_bpid);
      sqlcom.Parameters.AddWithValue("@t_flag", "D");
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "testdb..[WS_LOBCIFForm]";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString();
      
        msg1 = result;
        comb = i_msg ;
        output = comb.Split(',');

        if (result == "success")
        {
          return output;
        }
        else
        {
          string comb1 = result;
          output = comb1.Split(',');
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      //return output;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst176100> BindCIFDetails(string t_bpid)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst176100> Prdlst = new List<ttdtst176100>();
     

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_LOBCIFDetails]", con);
          comm.CommandType = CommandType.StoredProcedure;
          //comm.Parameters.AddWithValue("@t_usid", t_usid);
          comm.Parameters.AddWithValue("@t_bpid", t_bpid);
          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
         
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst176100
            {
              t_bpid = sdr["t_bpid"].ToString(),
              t_pono = Convert.ToInt32(sdr["t_pono"].ToString()),
              t_remk = sdr["t_remk"].ToString(),
              t_attc = sdr["t_attc"].ToString(),
              t_path = sdr["t_path"].ToString(),
        
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
    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public static List<ttdtst173100> BindCIFForm(string t_crus)
    //{
    //  string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
    //  try
    //  {
    //    List<ttdtst173100> Prdlst = new List<ttdtst173100>();
    //    using (SqlConnection con = new SqlConnection(constr))
    //    {

    //      con.Open();
    //      SqlCommand comm = new SqlCommand("testdb..[WS_LOBCIFForm]", con);
    //      comm.CommandType = CommandType.StoredProcedure;
    //      comm.Parameters.AddWithValue("@t_crus", t_crus);
    //      comm.Parameters.AddWithValue("@t_flag", "S");
    //      comm.Parameters.Add("@message", SqlDbType.VarChar, 500);

    //      comm.Parameters["@message"].Direction = ParameterDirection.Output;

    //      SqlDataReader sdr = comm.ExecuteReader();
    //      while (sdr.Read())
    //      {
    //        Prdlst.Add(new ttdtst173100
    //        {
    //          t_bpid = sdr["t_bpid"].ToString().Trim(),
    //          t_cbrn = sdr["t_cbrn"].ToString().Trim(),
    //          t_nama = sdr["t_nama"].ToString().Trim(),
    //          t_phne = sdr["t_phne"].ToString().Trim(),
    //          t_mail = sdr["t_mail"].ToString().Trim(),
    //          t_ln01 = sdr["t_ln01"].ToString().Trim(),
    //          t_ln02 = sdr["t_ln02"].ToString().Trim(),
    //          t_ccit = sdr["t_ccit"].ToString().Trim(),
    //          t_ccitdesc = sdr["t_ccitdesc"].ToString(),
    //          t_ccty = sdr["t_ccty"].ToString().Trim(),
    //          t_cctydesc = sdr["t_cctydesc"].ToString(),
    //          t_cste = sdr["t_cste"].ToString(),
    //          t_cstedesc = sdr["t_cstedesc"].ToString(),
    //          t_shsz = sdr["t_shsz"].ToString().Trim(),
    //          t_prod = sdr["t_prod"].ToString().Trim(),
    //          t_brnd = sdr["t_brnd"].ToString().Trim(),
    //          t_find = sdr["t_find"].ToString().Trim(),
    //          t_swdi = sdr["t_swdi"].ToString().Trim(),
    //          t_keye = sdr["t_keye"].ToString().Trim(),
    //          t_remk = sdr["t_remk"].ToString().Trim(),
    //          t_prdd = sdr["t_prdd"].ToString().Trim(),
    //          t_brdd = sdr["t_brdd"].ToString().Trim(),
    //          t_chan = sdr["t_chan"].ToString().Trim(),
    //          t_badd = sdr["t_badd"].ToString().Trim(),
    //          t_pstc = sdr["t_pstc"].ToString().Trim(),
    //          t_bgst = sdr["t_bgst"].ToString().Trim(),
    //          t_panu = sdr["t_panu"].ToString().Trim(),
    //          t_sadd = sdr["t_sadd"].ToString().Trim(),
    //          t_spin = sdr["t_spin"].ToString().Trim(),
    //          t_sgst = sdr["t_sgst"].ToString().Trim(),
    //          t_shfr = sdr["t_shfr"].ToString().Trim(),
    //          t_tofl = sdr["t_tofl"].ToString().Trim(),
    //          t_cpay = sdr["t_cpay"].ToString().Trim(),
    //          t_paym = sdr["t_paym"].ToString().Trim(),
    //          t_crli = sdr["t_crli"].ToString().Trim(),
    //          t_cday = sdr["t_cday"].ToString().Trim(),
    //          t_sals = sdr["t_sals"].ToString().Trim(),
    //          t_crep = sdr["t_crep"].ToString().Trim(),
    //          t_osrp = sdr["t_osrp"].ToString().Trim(),
    //          t_emsr = sdr["t_emsr"].ToString().Trim(),
    //          t_cntp = sdr["t_cntp"].ToString().Trim(),
    //          t_namd = sdr["t_namd"].ToString().Trim(),
    //          t_cntr = sdr["t_cntr"].ToString().Trim(),
    //          t_cntrdesc = sdr["t_cntrdesc"].ToString().Trim(),
    //          t_stte = sdr["t_stte"].ToString().Trim(),
    //          t_sttedesc = sdr["t_sttedesc"].ToString().Trim(),
    //          t_city = sdr["t_city"].ToString().Trim(),
    //          t_citydesc = sdr["t_citydesc"].ToString().Trim(),
    //          t_samb = Convert.ToInt32(sdr["t_samb"].ToString().Trim())

    //        });
    //      }
    //      con.Close();
    //      message = (string)comm.Parameters["@message"].Value.ToString();
    //      return Prdlst;
    //    }
    //  }
    //  catch (Exception ex)
    //  {
    //    throw ex;
    //  }

    //}


  }
  public class ttdtst173100
  {
    public string t_link { get; set; }
    public string t_bpid { get; set; }
    public string t_cbrn { get; set; }
    public string t_nama { get; set; }
    public string t_phne { get; set; }
    public string t_mail { get; set; }
    public string t_ln01 { get; set; }
    public string t_ln02 { get; set; }
    public string t_ccit { get; set; }
    public string t_ccitdesc { get; set; }
    public string t_ccty { get; set; }
    public string t_cctydesc { get; set; }
    public string t_cste { get; set; }
    public string t_cstedesc { get; set; }
    public string t_time { get; set; }
    public string t_shsz { get; set; }
    //public string t_prod { get; set; }
    public string t_brnd { get; set; }
    public string t_find { get; set; }
  
    public string t_keye { get; set; }
    public string t_remk { get; set; }
    //public string t_prdd { get; set; }
    public string t_brdd { get; set; }
    public string t_chan { get; set; }
    public string t_chandesc { get; set; }
    public string t_badd { get; set; }
    public string t_pstc { get; set; }
    public string t_bgst { get; set; }
    public string t_panu { get; set; }
    public string t_sadd { get; set; }
    public string t_spin { get; set; }
    public string t_sgst { get; set; }
    public string t_shfr { get; set; }
    public string t_tofl { get; set; }
    public string t_cpay { get; set; }
    public string t_cpaydesc { get; set; }
    public string t_paym { get; set; }
    public string t_paymdesc { get; set; }
    public string t_crli { get; set; }
    public string t_cday { get; set; }
    public string t_sals { get; set; }
    public string t_salsdesc { get; set; }
    public string t_crep { get; set; }
    public string t_crepdesc { get; set; }
    public string t_osrp { get; set; }
    public string t_osrpdesc { get; set; }
    public string t_emsr { get; set; }
    public string t_cntp { get; set; }
    public string t_namd { get; set; }
    public string t_cntr { get; set; }
    public string t_cntrdesc { get; set; }
    public string t_stte { get; set; }
    public string t_sttedesc { get; set; }
    public string t_city { get; set; }
    public string t_citydesc { get; set; }
    public int t_samb { get; set; }
    public string t_crus { get; set; }
    public string t_cnmo { get; set; }
    public string t_cnem { get; set; }

    public string t_swdi { get; set; }
    public string t_noos { get; set; }
    public string t_nook { get; set; }
    public string t_noow { get; set; }


  }
  public class ttcmcs010100
  {
    public string t_ccty { get; set; }
    public string t_dsca { get; set; }
  
  }
  public class ttcmcs143100
  {
    public string t_cste { get; set; }
    public string t_dsca { get; set; }

  }
  public class ttccom139100
  {
    public string t_city { get; set; }
    public string t_dsca { get; set; }

  }
  // CHANNEL
  public class ttcmcs066100
  {
    public string t_chan { get; set; }
    public string t_dsca { get; set; }

  }
  //Payment Terms
  public class ttcmcs013100
  {
    public string t_cpay { get; set; }
    public string t_dsca { get; set; }

  }
  //Payment Method
  public class ttfcmg003100
  {
    public string t_paym { get; set; }
    public string t_desc { get; set; }

  }

  public class ttcmcs031100
  {
    public string t_cbrn { get; set; }
    public string t_dsca { get; set; }

  }
  public class ttccom110100
  {
    public string t_crep { get; set; }
    public string t_osrp { get; set; }
    public string t_nama { get; set; }

  }

  public class ttdtst176100
  {
    public string t_bpid { get; set; }
    public int t_pono { get; set; }
    public string t_remk { get; set; }
    public string t_attc { get; set; }
    public string t_path { get; set; }

  }
}
