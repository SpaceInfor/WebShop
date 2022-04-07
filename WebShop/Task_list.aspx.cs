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
    public partial class Task_list : System.Web.UI.Page
    {
        private static string message = string.Empty;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["t_tano"] != null)
                    HttpContext.Current.Session.Add("t_tano", Request.QueryString["t_tano"].ToString());
                //HttpContext.Current.Session.Add("userId", Request.QueryString["userId"].ToString());
                if (Session["t_usid"] != null)
                {
                    HttpContext.Current.Session["t_usid"] = Session["t_usid"].ToString();
                }
                if (Session["t_nama"] != null)
                {
                    HttpContext.Current.Session["t_nama"] = Session["t_nama"].ToString();
                }
                if (Session["t_dept"] != null)
                {
                    HttpContext.Current.Session["t_dept"] = Session["t_dept"].ToString();
                }
                //HttpContext.Current.Session["t_dept"] = Session["t_dept"].ToString();
                // Session["t_comm"] = $('#yourDDL :selected').text(); ; 

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static void SetCommunication(string t_comm)
        {
            if (t_comm != null)
            {
                //Session["t_comm"] = t_comm;
                HttpContext.Current.Session["t_comm"] = t_comm;
            }
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskDetails(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> Prdlst = new List<ttdtst166100>();
                //int t_levl = Convert.ToInt32(HttpContext.Current.Session["t_levl"]);
                //string t_dept = (HttpContext.Current.Session["t_dept"].ToString());

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_usid", t_usid);
                    comm.Parameters.AddWithValue("@t_odep", t_odep);
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_odep = sdr["t_odep"].ToString(),
                            orgindept = sdr["orgindept"].ToString()
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
        public static List<ttdtst166100> GetTaskDetailsLevel3(string t_usid)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> Prdlst = new List<ttdtst166100>();
                //int t_levl = Convert.ToInt32(HttpContext.Current.Session["t_levl"]);
                //string t_dept = (HttpContext.Current.Session["t_dept"].ToString());

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_usid", t_usid);

                    comm.Parameters.AddWithValue("@t_flag", "LVL3");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_odep = sdr["t_odep"].ToString(),
                            orgindept = sdr["orgindept"].ToString()
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
        public static List<ttdtst166100> GetDeptwiseTaskDetails(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> Prdlst = new List<ttdtst166100>();
                //int t_levl = Convert.ToInt32(HttpContext.Current.Session["t_levl"]);
                //string t_dept = (HttpContext.Current.Session["t_dept"].ToString());


                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_odep", t_odep);
                    comm.Parameters.AddWithValue("@t_flag", "INTRA");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_odep = sdr["t_odep"].ToString(),
                            orgindept = sdr["orgindept"].ToString()
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
        public static List<ttdtst166100> GetTaskNowiseDetails(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> Prdlst = new List<ttdtst166100>();
                //int t_levl = Convert.ToInt32(HttpContext.Current.Session["t_levl"]);
                //string t_dept = (HttpContext.Current.Session["t_dept"].ToString());

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_TaskMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_tano", t_tano);
                    comm.Parameters.AddWithValue("@t_flag", "TANO");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_fpat = sdr["t_fpat"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_odep = sdr["t_odep"].ToString(),
                            orgindept = sdr["orgindept"].ToString()

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
        public static int deleteTask(string t_tano)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand com = new SqlCommand("testdb..[wh_TaskMaster]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                com.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                com.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                com.Parameters["@new_identity"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@t_tano", t_tano);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@t_mesg"].Value.ToString();
                con.Close();
            }

            return i;
        }
       

        [WebMethod]
        public static List<ttdtst166100> CheckSalesOrderExist(string t_orno)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> prclst = new List<ttdtst166100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_GetSalesOrder]", con);
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.Add(new SqlParameter("@t_orno", t_orno));
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdtst166100
                        {
                            t_sord = rdr["t_orno"].ToString(),

                        });
                    }
                    con.Close();

                    return prclst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public static List<ttdtst167100> GetDepartmentDes(string t_dept)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst167100> prclst = new List<ttdtst167100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_Department]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add(new SqlParameter("@t_dept", t_dept));
                    comm.Parameters.Add("@t_mesg", SqlDbType.Char, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdtst167100
                        {
                            t_dept = rdr["t_dept"].ToString(),
                            t_desc = rdr["t_desc"].ToString(),
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

    }

    public class ttdtst166100
    {

        public string t_link { get; set; }
        public string t_tano { get; set; }
        public string t_usid { get; set; }
        public string originname { get; set; }
        public string username { get; set; }
        public string t_taat { get; set; }
        public string assignname { get; set; }
        public int t_comm { get; set; }
        public string t_dept { get; set; }
        public string assigndept { get; set; }
        public string t_crdt { get; set; }
        public string t_codt { get; set; }
        public string t_fnam { get; set; }
        public string t_fpat { get; set; }
        public HttpPostedFileBase postedFiles { get; set; }
        public int t_stat { get; set; }
        public string t_rmrk { get; set; }
        public string t_sord { get; set; }
        public string t_tdes { get; set; }
        public string t_tnam { get; set; }
        public string t_odep { get; set; }
        public string orgindept { get; set; }
        public string ResponseTime { get; set; }
        public string CloserTime { get; set; }
        public string OpenTime { get; set; }
        public string t_cldt { get; set; }
        public string t_ipdt { get; set; }
        public string t_flag { get; set; }
        public string t_nama { get; set; }
        public int t_pono { get; set; }
        public string new_identity { get; set; }
    }
    
}
