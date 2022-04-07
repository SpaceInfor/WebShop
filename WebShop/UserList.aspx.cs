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
    public partial class UserList : System.Web.UI.Page
    {
        private static string message = string.Empty;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst250100> GetUserDetails()
        {

            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst250100> Prdlst = new List<ttdtst250100>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();

                    SqlCommand comm = new SqlCommand("testdb..[wh_GetUserList]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_flag", "S");
                    //comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    //comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new ttdtst250100
                        {
                            t_usid = sdr["t_usid"].ToString(),
                            t_emai = sdr["t_emai"].ToString(),
                            t_nama = sdr["t_nama"].ToString()

                        });
                    }
                    con.Close();
                    //message = (string)comm.Parameters["@t_mesg"].Value.ToString();
                    return Prdlst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
    public class ttdtst250100
    {
        public string t_usid { get; set; }
        public string t_emai { get; set; }
        public string t_nama { get; set; }
        public string t_dept { get; set; }
        public string t_desc { get; set; }
    }
}