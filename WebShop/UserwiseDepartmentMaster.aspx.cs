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

namespace WebShop
{
    public partial class UserwiseDepartmentMaster : System.Web.UI.Page
    {
        private static string message = string.Empty;
        private static string message1 = string.Empty;
        private static string Errormessage = string.Empty;

        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst170100> GetUserwiseDepartmentDetails()
        {

            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst170100> Prdlst = new List<ttdtst170100>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();

                    SqlCommand comm = new SqlCommand("testdb..[WS_UserwiseDepartment]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst170100
                        {
                            t_usid = sdr["t_usid"].ToString(),
                            t_usiddesc = sdr["t_usiddesc"].ToString(),
                            t_dept = sdr["t_dept"].ToString(),
                            t_deptdesc = sdr["t_deptdesc"].ToString(),
                            t_levl = Convert.ToInt32(sdr["t_levl"].ToString())

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
        public static int deleteUserwiseDepartment(string t_usid)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand com = new SqlCommand("testdb..[WS_UserwiseDepartment]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                com.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@t_usid", t_usid);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@t_mesg"].Value.ToString();
                con.Close();
            }

            return i;
        }
        [WebMethod]
        public static List<ttdtst250100> GetUserName(string t_usid)
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
                    comm.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    //comm.Parameters.Add("@t_mesg", SqlDbType.Char, 500);
                    //comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdtst250100
                        {
                            t_usid = rdr["t_usid"].ToString(),
                            t_nama = rdr["t_nama"].ToString(),
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
        public static String[] saveUserDepartment(string t_usid, string t_dept, string t_levl, string t_flag)

        {

            string i_msg;
            i_msg = "";
            string[] output = new string[] { "", "" };
            WebDataAccess NBData = new WebDataAccess();
            WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
            SqlCommand sqlcom = new SqlCommand();
            sqlcom.CommandType = CommandType.StoredProcedure;

            if (t_dept == "")
            {
                sqlcom.Parameters.AddWithValue("@t_usid", null);
            }
            else
            {
                sqlcom.Parameters.AddWithValue("@t_usid", t_usid);
            }

            sqlcom.Parameters.AddWithValue("@t_dept", t_dept);
            sqlcom.Parameters.AddWithValue("@t_levl", t_levl);
            sqlcom.Parameters.AddWithValue("@t_flag", t_flag);

            sqlcom.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);

            sqlcom.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
            sqlcom.CommandText = "testdb..[WS_UserwiseDepartment]";

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
        public static List<ttdtst170100> GetUserwiseDepartmentwise(string t_usid)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("testdb..[WS_UserwiseDepartment]"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@t_flag", "S");
                    cmd.Parameters.Add(new SqlParameter("@t_usid", t_usid));
                    cmd.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    cmd.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    List<ttdtst170100> InputLines = new List<ttdtst170100>();
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            InputLines.Add(new ttdtst170100
                            {
                                t_usid = sdr["t_usid"].ToString(),
                                t_usiddesc = sdr["t_usiddesc"].ToString(),
                                t_dept = sdr["t_dept"].ToString(),
                                t_deptdesc = sdr["t_deptdesc"].ToString(),
                                t_levl = Convert.ToInt32(sdr["t_levl"].ToString())
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
    public class ttdtst170100
    {

        public string t_usid { get; set; }
        public string t_usiddesc { get; set; }
        public string t_dept { get; set; }
        public string t_deptdesc { get; set; }
        public int t_levl { get; set; }
    }
}
