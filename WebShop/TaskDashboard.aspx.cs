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
    public partial class TaskDashboard : System.Web.UI.Page
    {
        private static string message = string.Empty;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //For Level 1
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskDetails(int t_stat)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_stat", t_stat);
                    //comm.Parameters.AddWithValue("@t_odep", t_odep);
                    //comm.Parameters.AddWithValue("@t_usid", t_taat);

                    comm.Parameters.AddWithValue("@t_flag", "RT");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;


                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
                            t_odep = sdr["t_odep"].ToString(),
                            ResponseTime = sdr["ResponseTime"].ToString(),
                            CloserTime = sdr["CloserTime"].ToString(),
                            OpenTime = sdr["OpenTime"].ToString(),
                            t_cldt = sdr["t_cldt"].ToString(),
                            t_ipdt = sdr["t_ipdt"].ToString()
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
        //For Level 2 Intra 
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetIntraTaskDetails(string t_odep)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_odep", t_odep);


                    comm.Parameters.AddWithValue("@t_flag", "INTRA");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;


                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
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
        //For Level 2 Open Task Show  
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetInOpenTask(string t_odep, string t_stat)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_odep", t_odep);
                    comm.Parameters.AddWithValue("@t_stat", t_stat);

                    comm.Parameters.AddWithValue("@t_flag", "OPN");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;


                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
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
        //For Level 2 In Process Task Show  
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetInProcessTask(string t_odep, string t_stat)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_odep", t_odep);
                    comm.Parameters.AddWithValue("@t_stat", t_stat);

                    comm.Parameters.AddWithValue("@t_flag", "INP");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;


                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
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
        //For Level 2 In Close Task Show  
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetInCloseTask(string t_odep, string t_stat)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_odep", t_odep);
                    comm.Parameters.AddWithValue("@t_stat", t_stat);

                    comm.Parameters.AddWithValue("@t_flag", "INC");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;


                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst166100
                        {
                            t_link = sdr["t_link"].ToString(),
                            t_tano = sdr["t_tano"].ToString(),
                            t_sord = sdr["t_sord"].ToString(),
                            t_tnam = sdr["t_tnam"].ToString(),
                            t_tdes = sdr["t_tdes"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            originname = sdr["originname"].ToString(),
                            //t_tdes = sdr["t_tdes"].ToString(),
                            t_taat = sdr["t_taat"].ToString(),
                            assignname = sdr["assignname"].ToString(),
                            t_comm = Convert.ToInt32(sdr["t_comm"].ToString()),
                            t_dept = sdr["t_dept"].ToString(),
                            assigndept = sdr["assigndept"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_codt = sdr["t_codt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString()),
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

        //For Level 3 
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
        //For Level 3 Open
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskDetailsLevel3Open(string t_usid)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_usid", t_usid);
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_flag", "LVL3O");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    //comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    //comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

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
        //For Level 3 In Process
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskDetailsLevel3InProc(string t_usid)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_usid", t_usid);
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_flag", "LVL3I");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    //comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    //comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

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
        //For Level 3 Close
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetTaskDetailsLevel3InClose(string t_usid)
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
                    SqlCommand comm = new SqlCommand("testdb..[WS_GetDashboardUser]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_usid", t_usid);
                    //comm.Parameters.AddWithValue("@t_stat", t_stat);
                    comm.Parameters.AddWithValue("@t_flag", "LVL3C");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    //comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    //comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;

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

        //For Level 1 Open Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetOpenTaskWise1(string t_stat)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "O");
                    cmd.Parameters.Add(new SqlParameter("@t_stat", t_stat));

                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_open = sdr["t_open"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 2 Open Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetOpenTaskWise2(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L2O");
                    //cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid)); t_odep = @t_odep
                    cmd.Parameters.Add(new SqlParameter("@t_odep", t_odep));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_open = sdr["t_open"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 3 Open Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetOpenTaskWise3(string t_usid)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L3O");
                    cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));

                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_open = sdr["t_open"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }

        //For Total Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetTotalTaskWise(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "T");
                    //cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add(new SqlParameter("@t_odep", t_odep));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_ttas = sdr["t_ttas"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 1 In Progress Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetInProgressTaskWise1(string t_stat)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "IN");

                    cmd.Parameters.Add(new SqlParameter("@t_stat", t_stat));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_inpr = sdr["t_inpr"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 2 In Progress Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetInProgressTaskWise2(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L2IN");
                    //cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add(new SqlParameter("@t_odep", t_odep));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_inpr = sdr["t_inpr"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 3 In Progress Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetInProgressTaskWise3(string t_usid)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L3IN");
                    cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    //cmd.Parameters.Add(new SqlParameter("@t_stat", t_stat));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_inpr = sdr["t_inpr"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 1 Close Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetCloseTaskWise1(string t_stat)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "C");
                    //cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add(new SqlParameter("@t_stat", t_stat));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_clos = sdr["t_clos"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 2 Close Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetCloseTaskWise2(string t_odep)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L2C");
                    //cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add(new SqlParameter("@t_odep", t_odep));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_clos = sdr["t_clos"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
        //For Level 3 Close Task
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<Dashboard> GetCloseTaskWise3(string t_usid)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_GetDashboardUser]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "L3CL");
                    cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    List<Dashboard> InputLines = new List<Dashboard>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new Dashboard
                            {
                                t_clos = sdr["t_clos"].ToString()

                            });
                        }

                        con.Close();
                        message = (string)cmd.Parameters["@t_mesg"].Value.ToString();
                        return InputLines;
                    }
                }
            }
        }
    }

    public class Dashboard
    {

        public string t_usid { get; set; }
        public string t_nama { get; set; }
        public string t_ttas { get; set; }
        public string t_asgn { get; set; }
        public string t_open { get; set; }
        public string t_inpr { get; set; }
        public string t_clos { get; set; }
        public string t_flag { get; set; }

    }

}