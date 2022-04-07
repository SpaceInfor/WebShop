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
using System.Web.Services;

namespace WebShop
{
    public partial class TaskDetail : System.Web.UI.Page
    {
        private static string message = string.Empty;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            //HttpContext.Current.Session["userId"] = t_usid;
            if (Request.QueryString["t_tano"] != null)
                HttpContext.Current.Session.Add("t_tano", Request.QueryString["t_tano"].ToString());
            //HttpContext.Current.Session["t_tano"] = Request.QueryString["t_tano"].ToString();
            //HttpContext.Current.Session.Add("userId", Request.QueryString["userId"].ToString());
            if (Session["userId"] != null)
            {
                HttpContext.Current.Session["userId"] = Session["userId"].ToString();
            }
            if (Session["userName"] != null)
            {
                HttpContext.Current.Session["userName"] = Session["userName"].ToString();
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskWise(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[wh_TaskMaster]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "R");
                    cmd.Parameters.Add(new SqlParameter("@t_tano", t_tano));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    cmd.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                    List<ttdtst166100> InputLines = new List<ttdtst166100>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new ttdtst166100
                            {

                                t_tano = sdr["t_tano"].ToString(),
                                t_tnam = sdr["t_tnam"].ToString(),
                                t_usid = sdr["t_usid"].ToString(),
                                t_taat = sdr["t_taat"].ToString(),
                                assignname = sdr["assignname"].ToString(),
                                t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                                t_dept = sdr["t_dept"].ToString(),
                                assigndept = sdr["assigndept"].ToString(),
                                t_crdt = sdr["t_crdt"].ToString(),
                                t_codt = sdr["t_codt"].ToString(),
                                t_fnam = sdr["t_fnam"].ToString(),
                                t_fpat = sdr["t_fpat"].ToString(),
                                t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                                t_tdes = sdr["t_tdes"].ToString(),
                                t_rmrk = sdr["t_rmrk"].ToString(),
                                t_sord = sdr["t_sord"].ToString(),
                                t_odep = sdr["t_odep"].ToString()
                                //orgindept = sdr["orgindept"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }

        [WebMethod]
        public static List<ttdtst250100> GetUserName(string t_taat)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst250100> prclst = new List<ttdtst250100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_GetUserList]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add(new SqlParameter("@t_usid", t_taat));
                    //comm.Parameters.Add("@t_mesg", SqlDbType.Char, 500);
                    //comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdtst250100
                        {
                            t_usid = rdr["t_usid"].ToString(),
                            t_nama = rdr["t_nama"].ToString(),
                            t_dept = rdr["t_dept"].ToString(),
                            t_desc = rdr["t_desc"].ToString(),
                        });
                    }
                    con.Close();
                    //message = (string)comm.Parameters["@t_mesg"].Value;
                    return prclst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [System.Web.Services.WebMethod]
        public static String[] updateAssignUser(string t_tano, string t_taat1, string t_flag)

        {

            //string i_tano;
            string i_msg;
            i_msg = "";

            string[] output = new string[] { "", "" };


            WebDataAccess NBData = new WebDataAccess();
            WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
            SqlCommand sqlcom = new SqlCommand();
            sqlcom.CommandType = CommandType.StoredProcedure;

            if (t_tano == "")
            {
                sqlcom.Parameters.AddWithValue("@t_tano", null);
            }
            else
            {
                sqlcom.Parameters.AddWithValue("@t_tano", t_tano);
            }

            sqlcom.Parameters.AddWithValue("@t_taat", t_taat1);

            sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
            sqlcom.Parameters.Add("@new_identity", SqlDbType.Char, 500);
            sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
            sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
            sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
            sqlcom.CommandText = "testdb..[wh_TaskMaster]";

            string result = "", msg1 = "";
            try
            {
                result = NBData.ExecuteCommand(sqlcom, ref objErr);
                //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
                i_msg = (string)sqlcom.Parameters["@t_mesg"].Value.ToString();

                msg1 = result;

                string comb = i_msg;
                output = comb.Split(',');
                //output = comb.ToString();
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
        public static List<ttdtst168100> GetTaskDetails(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst168100> Prdlst = new List<ttdtst168100>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskDetails]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add(new SqlParameter("@t_tano", t_tano));
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst168100
                        {
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            t_pono = Convert.ToInt32(sdr["t_pono"].ToString()),
                            t_nama = sdr["t_nama"].ToString(),
                            t_rpdt = sdr["t_rpdt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_fnam = sdr["t_fnam"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString()

                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@t_mesg"].Value.ToString();
                    return Prdlst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst168100> GetHeaderDetails(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst168100> Prdlst = new List<ttdtst168100>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskDetails]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "H");
                    comm.Parameters.Add(new SqlParameter("@t_tano", t_tano));
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst168100
                        {
                            t_tsrn = Convert.ToInt32(sdr["t_tsrn"].ToString()),
                            t_tano = sdr["t_tano"].ToString(),
                            t_pono = Convert.ToInt32(sdr["t_pono"].ToString()),
                            t_fnam = sdr["t_fnam"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString())


                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@t_mesg"].Value.ToString();
                    return Prdlst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        [WebMethod]
        public static List<ttdtst166100> GetTaskStatus(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> prclst = new List<ttdtst166100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "ST");
                    comm.Parameters.Add(new SqlParameter("@t_tano", t_tano));
                    comm.Parameters.Add("@t_mesg", SqlDbType.Char, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters.Add("@new_identity", SqlDbType.Char, 500);
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdtst166100
                        {
                            t_tano = rdr["t_tano"].ToString(),
                            t_stat = Convert.ToInt32(rdr["t_stat"].ToString()),
                            t_usid = rdr["t_usid"].ToString(),
                            t_odep = rdr["t_odep"].ToString(),
                            t_dept = rdr["t_dept"].ToString(),
                            t_comm = Convert.ToInt32(rdr["t_comm"].ToString()),
                            t_taat = rdr["t_taat"].ToString(),
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@t_mesg"].Value;
                    return prclst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst168100> GetAttachDetails(string t_tano, string t_pono)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst168100> Prdlst = new List<ttdtst168100>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskDetails]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "V");
                    comm.Parameters.Add(new SqlParameter("@t_tano", t_tano));
                    comm.Parameters.Add(new SqlParameter("@t_pono", t_pono));
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst168100
                        {
                            t_tano = sdr["t_tano"].ToString(),
                            t_tsrn = Convert.ToInt32(sdr["t_tsrn"].ToString()),
                            t_pono = Convert.ToInt32(sdr["t_pono"].ToString()),
                            t_fnam = sdr["t_fnam"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString()

                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@t_mesg"].Value.ToString();
                    return Prdlst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        [System.Web.Services.WebMethod]
        public static String[] UpdateHeaderStatus(string t_tano, string t_stat)
        {
            string i_msg, status; ;
            string comb = string.Empty;
            i_msg = "";
            string[] output = new string[] { "", "" };

            WebDataAccess NBData = new WebDataAccess();
            WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
            SqlCommand sqlcom = new SqlCommand();
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@t_flag", "M");
            sqlcom.Parameters.AddWithValue("@t_tano", t_tano);
            sqlcom.Parameters.AddWithValue("@t_stat", t_stat);
            sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
            sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
            sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
            sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
            sqlcom.CommandText = "testdb..[wh_TaskMaster]";

            string result = "", msg1 = "";
            try
            {
                result = NBData.ExecuteCommand(sqlcom, ref objErr);
                //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
                i_msg = (string)sqlcom.Parameters["@t_mesg"].Value.ToString();
                status = (string)sqlcom.Parameters["@new_identity"].Value.ToString();
                //t_tano = (string)sqlcom.Parameters["@new_identity"].Value.ToString();
                msg1 = result;
                comb = i_msg + "," + status;
                //comb = i_msg;
                output = comb.Split(',');
                //output = comb.ToString();
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

        [System.Web.Services.WebMethod]
        public static String[] UpdateAcknowledgeStatus(string t_tano, string t_stat)
        {
            string i_msg, status;
            //string status = string.Empty;
            //string comb = string.Empty;
            i_msg = "";
            string[] output = new string[] { "", "" };

            WebDataAccess NBData = new WebDataAccess();
            WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
            SqlCommand sqlcom = new SqlCommand();
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@t_flag", "M");
            sqlcom.Parameters.AddWithValue("@t_tano", t_tano);
            sqlcom.Parameters.AddWithValue("@t_stat", t_stat);
            sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
            sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
            sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
            sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
            sqlcom.CommandText = "testdb..[wh_TaskMaster]";

            string result = "", msg1 = "";
            try
            {
                result = NBData.ExecuteCommand(sqlcom, ref objErr);
                //i_tano = (string)sqlcom.Parameters["@new_identity"].Value;
                i_msg = (string)sqlcom.Parameters["@t_mesg"].Value.ToString();
                status = (string)sqlcom.Parameters["@new_identity"].Value.ToString();
                msg1 = result;
                string comb = i_msg + "," + status;
                //comb = i_msg + "," status;
                //i_dorn + "," + i_msg;
                output = comb.Split(',');
                //output = comb.ToString();
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
    }
    public class ttdtst168100
    {

        public string t_tano { get; set; }
        public int t_pono { get; set; }
        public string t_usid { get; set; }
        public string t_rpdt { get; set; }
        public string t_rmrk { get; set; }
        public int t_tsrn { get; set; }
        public int t_stat { get; set; }
        public string t_fnam { get; set; }
        public string t_fpat { get; set; }
        public string t_nama { get; set; }
        public HttpPostedFileBase postedFiles { get; set; }

    }


}