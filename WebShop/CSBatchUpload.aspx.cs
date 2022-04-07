using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.IO;
using System.Data.OleDb;

using System.Linq;
using System.Web;
using System.Text;
using System.Web.Script.Serialization;

namespace WebShop
{

  public partial class CSBatchUpload : Page
    {
    string getFileName;
    protected void Page_PreInit(object sender, EventArgs e)
    {
      Master.ContentCallEvent += new EventHandler(Master_TextChanged);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
      {
        
      }
    }
    private void Master_TextChanged(object sender, EventArgs e)
    {
      string t_bpid;
      TextBox bpid = (TextBox)Master.FindControl("t_ofbp");
      t_bpid = bpid.Text.ToString();
      t_bpid = bpid.Text.ToString();
      Session["t_bpid"] = t_bpid;
      //GetOrderList();
      //GetOrderList_New();
    }
    protected void uploadFile_Click(object sender, EventArgs e)
    {
      //Upload and save the file
      string i_msg = "";
      StringBuilder sb = new StringBuilder();
      string excelPath = Server.MapPath("~/FileUpload/") + Path.GetFileName(UploadBatch.PostedFile.FileName);
      UploadBatch.SaveAs(excelPath);

      string conString = string.Empty;
      string extension = Path.GetExtension(UploadBatch.PostedFile.FileName);
      switch (extension)
      {
        case ".xls": //Excel 97-03
          conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
          break;
        case ".xlsx": //Excel 07 or higher
          conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
          break;

      }
      conString = string.Format(conString, excelPath);
      using (OleDbConnection excel_con = new OleDbConnection(conString))
      {
        excel_con.Open();
        string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
        DataTable dtExcelData = new DataTable();

        

        //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
        dtExcelData.Columns.AddRange(new DataColumn[2] { new DataColumn("t_orno", typeof(string)),
                new DataColumn("t_btno", typeof(string))
                 });

        using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
        {
          oda.Fill(dtExcelData);
        }
        excel_con.Close();

        string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;


        for (int i = 0; i < dtExcelData.Rows.Count; i++)
        {
          NBDataAccess NBData = new NBDataAccess();
          NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
          SqlCommand sqlcom = new SqlCommand();
          sqlcom.CommandType = CommandType.StoredProcedure;
          sqlcom.Parameters.AddWithValue("@t_orno", dtExcelData.Rows[i]["t_orno"].ToString());
          sqlcom.Parameters.AddWithValue("@t_btno", dtExcelData.Rows[i]["t_btno"].ToString());
          sqlcom.Parameters.Add("@t_message", SqlDbType.Char, 500);
          sqlcom.Parameters["@t_message"].Direction = ParameterDirection.Output;
          sqlcom.CommandText = "WS_UploadBatchNo";
          string result = "", msg1 = "";
          try
          {
            result = NBData.ExecuteCommand(sqlcom, ref objErr);

            i_msg = (string)sqlcom.Parameters["@t_message"].Value;

            msg1 = result;


            if (result == "success")
            {
              if (i_msg != "Added")
              {
                sb.Append("<tr><td>"+ dtExcelData.Rows[i]["t_orno"].ToString() + "</td><td>" + dtExcelData.Rows[i]["t_btno"].ToString() + "</td><td>" + i_msg +"</td>");
              }

            }
          }
          catch (Exception ex)
          {
            result = ex.Message;

          }
        }
        
      }
      tbl1.InnerHtml = sb.ToString();
    }
    [System.Web.Services.WebMethod(EnableSession = true)]

    public static List<SalesOrderClass> GetBatchNo()
    {
   
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      using (SqlConnection con = new SqlConnection(constr))
      {
        using (SqlCommand cmd = new SqlCommand("exec  WS_ShowBatchNo"))
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
               
                t_orno = sdr["t_orno"].ToString(),
                t_btno = sdr["t_btno"].ToString(),
                t_date = sdr["t_date"].ToString()
              });
            }
          }
          con.Close();
          return SalesOrders;
        }
      }
    }
    [WebMethod]
    public static string GetData()
    {
      using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConn"].ToString()))
      {
        SqlCommand cmd = new SqlCommand("exec  WS_ShowBatchNo");
        using (SqlDataAdapter sda = new SqlDataAdapter())
        {
          cmd.Connection = con;
          sda.SelectCommand = cmd;
          using (DataSet ds = new DataSet())
          {
            sda.Fill(ds);
            return ds.GetXml();
          }
        }
      }
    }

    public class SalesOrderClass
    {
    
      public string t_orno { get; set; }
      public string t_btno { get; set; }
      public string t_date { get; set; }
      

    }

  }
}



