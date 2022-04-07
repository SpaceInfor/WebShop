<%@ WebHandler Language="C#" Class="CIFDetailHandler" %>

using System;
using System.Web;
using System.Collections.Generic;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.Services;


public class CIFDetailHandler : IHttpHandler
{
  private static string message = string.Empty;
  public void ProcessRequest(HttpContext context)
  {
    string i_msg;
    string comb = string.Empty;
    i_msg = "";
    string result = "", msg = "";

    string t_fnam = string.Empty;
    string t_fpat = string.Empty;
    string[] output = new string[] { "", "" };
    string fname = string.Empty;
    string fpath = string.Empty;
    string downloadpath1 = string.Empty;

    ///////////////////////////////////////////////


    //string form = context.Request.Form;
    string t_bpid = context.Request.Form[0];
    string t_remk = context.Request.Form[1];
    string t_flag = context.Request.Form[2];


    //if (context.Request.Files.Count > 0)
    //{

    var t_custId = context.Request.Form[0];
    HttpFileCollection files = context.Request.Files;
    for (int i = 0; i < files.Count; i++)
    {
      HttpPostedFile file = files[i];

      string folderPath1 = HttpContext.Current.Server.MapPath("~/ComplaintAttachment/" + "/" + t_custId + "/");

      string Shortpath1 = "ComplaintAttachment/" + t_custId + "/";
      if (!Directory.Exists(folderPath1))
      {
        Directory.CreateDirectory(folderPath1);
      }

      if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE" || HttpContext.Current.Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
      {
        string[] testfiles = file.FileName.Split(new char[] { '\\' });
        fname = testfiles[testfiles.Length - 1];
      }
      else
      {
        fname = file.FileName;

      }

      file.SaveAs(Path.Combine(folderPath1, file.FileName.ToLower()));
      //file.SaveAs(fname);
      downloadpath1 = Shortpath1 + file.FileName.Trim();

     
    }
    if (context.Request.Files.Count > 0)
    {
      t_fnam = fname;
      t_fpat = downloadpath1;
    }
    else
    {
      t_fnam = "";
      t_fpat = "";
    }
    
    //////////////////////////////////////
    NBDataAccess NBData1 = new NBDataAccess();
    NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
    SqlCommand sqlcom = new SqlCommand();
    sqlcom.CommandType = CommandType.StoredProcedure;
    sqlcom.Parameters.AddWithValue("@t_bpid", t_bpid);
    sqlcom.Parameters.AddWithValue("@t_remk", t_remk);
    sqlcom.Parameters.AddWithValue("@t_attc", t_fnam);
    sqlcom.Parameters.AddWithValue("@t_path", t_fpat);
    sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
    sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
    sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
    sqlcom.CommandText = "testdb.dbo.[WS_LOBCIFDetails]";

    try
    {
      result = NBData1.ExecuteCommand(sqlcom, ref objErr);
      //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
      i_msg = (string)sqlcom.Parameters["@message"].Value.ToString();

      msg = result;

      comb = i_msg;
      output = comb.Split(',');
    }
    catch (Exception ex)
    {
      result = ex.Message;

    }
    context.Response.Write(i_msg);

    //}
  }

  public bool IsReusable
  {
    get
    {
      return false;
    }
  }
}

