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
  public partial class CompFileUpload : System.Web.UI.Page
  {
    string t_compid;
    protected void Page_Load(object sender, EventArgs e)
    {
     // this.Page.Form.Enctype = "multipart/form-data";

      t_compid =  Request.QueryString["t_cono"].ToString();

      if (!IsPostBack)
      {
        getComplaintFileList();
      }
    }
    protected void uploadFile_Click(object sender, EventArgs e)
    {
      String filename, downloadpath;
      if (UploadImages.HasFiles)
      {
        string folderPath = Server.MapPath("~/FileUpload/CustomerComplaint/" + HttpContext.Current.Session["t_usid"].ToString() + "/" + t_compid + "/");
        string Shortpath = "FileUpload/CustomerComplaint/" + HttpContext.Current.Session["t_usid"].ToString() + "/" + t_compid + "/";

        if (!Directory.Exists(folderPath))
        {
          Directory.CreateDirectory(folderPath);
        }
        foreach (HttpPostedFile uploadedFile in UploadImages.PostedFiles)
        {
          uploadedFile.SaveAs(folderPath + Path.GetFileName(uploadedFile.FileName));
          filename = folderPath + uploadedFile.FileName.Trim();
          downloadpath = Shortpath + uploadedFile.FileName.Trim();
          listofuploadedfiles.Text += String.Format("{0}<br />", uploadedFile.FileName);
          NBDataAccess NBData = new NBDataAccess();
          NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
          SqlCommand sqlcom = new SqlCommand();
          sqlcom.CommandType = CommandType.StoredProcedure;
          sqlcom.Parameters.AddWithValue("@t_worn", t_compid);
          sqlcom.Parameters.AddWithValue("@t_path", filename);
          sqlcom.Parameters.AddWithValue("@t_atph", downloadpath);
          sqlcom.Parameters.AddWithValue("@t_atnm", uploadedFile.FileName);
          sqlcom.CommandText = "WS_CustComplaintAttachments";

          string result = "", msg1 = "";
          try
          {
            result = NBData.ExecuteCommand(sqlcom, ref objErr);
            msg1 = result;
            if (result == "success")
            {
              getComplaintFileList();
            }
          }
          catch (Exception ex)
          {
            result = ex.Message;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + result + "')", true);
          }
        }
      }
    }

    protected void getComplaintFileList()
    {
      string tabl;
      tabl = "";
      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand SqlComm = new SqlCommand();
      SqlComm.CommandType = CommandType.Text;
      SqlComm.CommandText = "select * from swlive..ttdtst165100 where t_worn = '" + t_compid + "'";
      DataSet sProdPlanData = new DataSet();
      try
      {
        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        
        foreach (DataTable table in sProdPlanData.Tables)
        {
          foreach (DataRow dr in table.Rows)
          {
            tabl = tabl + "<tr><td>" + dr["t_pono"].ToString() + "</td><td>" + dr["t_atnm"].ToString() + "</td><td><a href='"+ dr["t_atph"].ToString() + "' target='_blank'><i class='fas fa-download'></i></a></td></tr>";
          }
        }
        sam.InnerHtml = tabl;
      }
      catch (Exception ex)
      {
        //error.InnerHtml = ex.Message.ToString();
      }
    }


  }
}
