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
namespace WebShop
{
  public partial class LoadingScan : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!Page.IsPostBack)
      {
     
      }
    }
    protected void getOrderDetails(string t_orno)
    {
      try
      {
        string Constring = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        SqlConnection Con = new SqlConnection();
        Con.ConnectionString = Constring;
        SqlConnection.ClearAllPools();
        Con.Close();
        Con.Open();
        t_orno = t_orno.ToUpper();
        DataTable tab = new DataTable();
        String sQuery = "WS_GetSoInfo @t_orno = '" + t_orno + "'";
        SqlDataAdapter da = new SqlDataAdapter(sQuery, Con);
        da.Fill(tab);
        Con.Close();
        Con.Dispose();

        if (tab.Rows.Count > 0)
        {
          //dvinfo.Visible = true;
          //lbl_t_orno.Text = tab.Rows[0]["t_orno"].ToString();
          //lblt_cprj.Text = tab.Rows[0]["Project_Details"].ToString();
          //lblt_ofbp.Text = tab.Rows[0]["sold_to_bp_name"].ToString();
          //lblt_stbp.Text = tab.Rows[0]["ship_to_bp_name"].ToString();
          //lblt_dest.Text = tab.Rows[0]["Destination"].ToString();
          //lblt_stat.Text = tab.Rows[0]["t_hdst"].ToString();
        }
        else
        {

          //dvinfo.Visible = true;
          //lbl_t_orno.Text = "";
          //lblt_cprj.Text =  "";
          //lblt_ofbp.Text = "";
          //lblt_stbp.Text = "";
          //lblt_dest.Text = "";
          //lblt_stat.Text = "";
        }
      }
      catch (Exception ex)
      {
      }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
    //  getOrderDetails(t_orno.Value.ToString());
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static String ProcessIT(string loadno,string t_boxs)
    {
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_load",loadno);
      sqlcom.Parameters.AddWithValue("@t_boxs",t_boxs);
      sqlcom.CommandText = "WS_SaveLoad";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return "";
      }
      return "";
    }
  }
}
