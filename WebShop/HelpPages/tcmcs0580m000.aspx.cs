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
  public partial class tcmcs0580m000 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {

        
      }
    }



    [System.Web.Services.WebMethod(EnableSession = true)]

    
    public static List<CarrierLsp> GetCarrierLsp()
    {
     
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("select * from swlive..ttcmcs080100"))
        {
          cmd.Connection = con;
          List<CarrierLsp> CarrierLsp = new List<CarrierLsp>();
          con.Open();
          using (SqlDataReader sdr = cmd.ExecuteReader())
          {
            while (sdr.Read())
            {
              CarrierLsp.Add(new CarrierLsp
              {
                t_olnk = "<button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + sdr["t_cfrw"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button>",
                t_cfrw = sdr["t_cfrw"].ToString(),
                t_dsca = sdr["t_dsca"].ToString()

              }); ; ;
            }
          }
          con.Close();
          return CarrierLsp;
        }
      }
    }
   
  }


  public class CarrierLsp
  {
    public string t_olnk { get; set; }
    public string t_cfrw { get; set; }
    public string t_dsca { get; set; }
    

  }

}
