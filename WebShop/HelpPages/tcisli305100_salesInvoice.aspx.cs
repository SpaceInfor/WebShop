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
using System.Web.Script.Services;

namespace WebShop.HelpPages
{
  public partial class tcisli305100_salesInvoice : System.Web.UI.Page
  {
    string message = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        //getInvoiceList();
      }
    }
  
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<saleInvoice> GetSalesInvoiceDetails()
    {

      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<saleInvoice> Prdlst = new List<saleInvoice>();

        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("testdb.dbo.[WS_POD]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_flag", "SI");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new saleInvoice
            {
              t_idoc = sdr["t_idoc"].ToString()
            
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
  public class saleInvoice
  {
    public string t_idoc { get; set; }
 
  }
}
