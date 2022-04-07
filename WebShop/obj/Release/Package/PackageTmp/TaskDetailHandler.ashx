<%@ WebHandler Language="C#" Class="TaskDetailHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.Services;


public class TaskDetailHandler : IHttpHandler
{
    private static string message = string.Empty;
    public void ProcessRequest(HttpContext context)
    {
        string i_msg;
        string comb = string.Empty;
        i_msg = "";
        string result1 = "", msg = "";
        string t_pono = string.Empty;
        string t_fnam = string.Empty;
        string t_fpat = string.Empty;
        string[] output = new string[] { "", "" };
        string fname = string.Empty;
        string fpath = string.Empty;
        string downloadpath1 = string.Empty;

        ///////////////////////////////////////////////

        //string form = context.Request.Form;
        string t_tano = context.Request.Form[0];
        string t_usid = context.Request.Form[1];
        string t_rmrk = context.Request.Form[2];
        string t_stat = context.Request.Form[3];
        string t_flag = context.Request.Form[4];
        //string tdet_t_fnam = context.Request.Form[6];
        //string tdett_fpat = context.Request.Form[7];

        if (t_flag != "I")
        {
            t_pono = context.Request.Form[1];
        }
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            HttpPostedFile file = files[0];
            string Shortpath1 = "UploadAttachment/" + t_usid + "/";
            downloadpath1 = Shortpath1 + file.FileName.Trim();
            t_fnam = file.FileName;
            t_fpat = downloadpath1;
        }
        else
        {
            if (t_fnam != "" || t_fpat != "")
            {
                t_fnam = context.Request.Form[5];
                t_fpat = context.Request.Form[6];
            }
        }


        //////////////////////////////////////
        WebDataAccess NBData = new WebDataAccess();
        WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
        SqlCommand sqlcom = new SqlCommand();
        sqlcom.CommandType = CommandType.StoredProcedure;
        if (t_tano != "")
        {
            sqlcom.Parameters.AddWithValue("@t_tano", t_tano);
        }
        sqlcom.Parameters.AddWithValue("@t_usid", t_usid);
        sqlcom.Parameters.AddWithValue("@t_rmrk", t_rmrk.Trim());
        sqlcom.Parameters.AddWithValue("@t_fnam", t_fnam);
        sqlcom.Parameters.AddWithValue("@t_fpat", t_fpat);
        sqlcom.Parameters.AddWithValue("@t_stat", t_stat);
        sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
        sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
        sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);

        sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
        sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;

        sqlcom.CommandText = "testdb..[wh_TaskDetails]";

        string result = "", msg1 = "";
        try
        {
            result = NBData.ExecuteCommand(sqlcom, ref objErr);
            //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
            i_msg = (string)sqlcom.Parameters["@t_mesg"].Value.ToString();
            t_pono = (string)sqlcom.Parameters["@new_identity"].Value.ToString();

            msg1 = result;

            comb = i_msg;
            output = comb.Split(',');
            //output = comb.ToString();
            //if (result == "success")
            //{
            //    context.Response.ContentType = "text/plain";
            //    context.Response.Write("Record inserted Successfully..!!");
            //    //return output;
            //}
            //else
            //{
            //    string comb1 = result;
            //    output = comb1.Split(',');
            //    context.Response.Write("Error while inserting data..!!");
            //    //return output;
            //}
        }
        catch (Exception ex)
        {
            result = ex.Message;
            //return output;
        }

        if (context.Request.Files.Count > 0)
        {


            var t_userId = context.Request.Form[1];
            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];

                string folderPath1 = HttpContext.Current.Server.MapPath("~/UploadAttachment/" + "/" + t_userId + "/");

                string Shortpath1 = "UploadAttachment/" + t_userId + "/";
                if (!Directory.Exists(folderPath1))
                {
                    Directory.CreateDirectory(folderPath1);
                }
                //string FileType = Path.GetExtension(file.FileName).ToLower().Trim();
                //if (FileType != ".jpg" && FileType != ".jpeg" && FileType != ".png" && FileType != ".pdf" && FileType != ".doc" && FileType != ".docx" && FileType != ".xls" && FileType != ".xlsx" && FileType != ".xlsx")
                //{
                //    context.Response.Write("File does not in upload in proper format");
                //    //output = "File Format Not Supported. Only .jpg, .jpeg, .png file formats are allowed while uploading profile picture.";
                //    //return output;
                //}
                //else 
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

                if (t_flag != "I")
                {
                    t_tano = context.Request.Form[12];
                }
                if (context.Request.Files.Count > 0)
                {
                    t_fnam = fname;
                    t_fpat = downloadpath1;
                }
                else
                {
                    if (t_fnam != "" || t_fpat != "")
                    {
                        t_fnam = context.Request.Form[13];
                        t_fpat = context.Request.Form[14];
                    }
                }
                //////////////////////////////////////
                WebDataAccess NBData1 = new WebDataAccess();
                WebDataAccess.ErrorAttributes objErr1 = new WebDataAccess.ErrorAttributes();
                SqlCommand sqlcom1 = new SqlCommand();
                sqlcom1.CommandType = CommandType.StoredProcedure;
                //if (t_tano != "")
                //{
                //    sqlcom1.Parameters.AddWithValue("@t_tano", t_tano);
                //}

                sqlcom1.Parameters.AddWithValue("@t_tano", t_tano);
                sqlcom1.Parameters.AddWithValue("@t_pono", t_pono);
                sqlcom1.Parameters.AddWithValue("@t_fnam", t_fnam);
                sqlcom1.Parameters.AddWithValue("@t_fpat", t_fpat);
                sqlcom1.Parameters.AddWithValue("@t_flag", "IN");
                sqlcom1.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);

                sqlcom1.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                sqlcom1.CommandText = "testdb..[wh_TaskAttachment]";


                try
                {
                    result1 = NBData1.ExecuteCommand(sqlcom1, ref objErr1);
                    //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
                    i_msg = (string)sqlcom1.Parameters["@t_mesg"].Value.ToString();

                    msg = result1;

                    comb = i_msg;
                    output = comb.Split(',');
                    //output = comb.ToString();

                }
                catch (Exception ex)
                {
                    result1 = ex.Message;
                    //return output;
                }
            }

        }
        context.Response.Write(i_msg);

        //if (result == "success")
        //{
        //    context.Response.ContentType = "text/plain";
        //    context.Response.Write("Record inserted Successfully..!!");
        //    context.Response.Write(i_msg);


        //    //return output;
        //}
        //else
        //{

        //    string comb1 = result;
        //    output = comb1.Split(',');
        //    //context.Response.Write("Error while inserting data..!!");
        //    context.Response.Write(i_msg);
        //    //return output;
        //}
        //if (result1 == "success")
        //{
        //    //context.Response.ContentType = "text/plain";
        //    //context.Response.Write("Record inserted Successfully..!!");
        //    //return output;
        //}
        //else
        //{
        //    string comb1 = result1;
        //    output = comb1.Split(',');
        //    //context.Response.Write("Error while inserting data..!!");
        //    //return output;
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
public class ttdtst168100
{
    public string t_tano { get; set; }
    public string t_pono { get; set; }
    public string t_usid { get; set; }
    public string t_rpdt { get; set; }
    public string t_rmrk { get; set; }
    public int t_stat { get; set; }
    public string t_fnam { get; set; }
    public string t_fpat { get; set; }
    public HttpPostedFileBase postedFiles { get; set; }
    public string t_flag { get; set; }

}