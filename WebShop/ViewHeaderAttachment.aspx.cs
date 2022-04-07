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
    public partial class ViewHeaderAttachment : System.Web.UI.Page
    {
        private static string message = string.Empty;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ttdtst166100> GetHeaderDetails(string t_tano)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdtst166100> Prdlst = new List<ttdtst166100>();

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
                        Prdlst.Add(new ttdtst166100
                        {
                            t_tano = sdr["t_tano"].ToString(),
                            t_usid = sdr["t_usid"].ToString(),
                            t_nama = sdr["t_nama"].ToString(),
                            t_crdt = sdr["t_crdt"].ToString(),
                            t_rmrk = sdr["t_rmrk"].ToString(),
                            t_stat = Convert.ToInt32(sdr["t_stat"].ToString())
                            //t_pono = Convert.ToInt32(sdr["t_pono"].ToString()),

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
    }
}