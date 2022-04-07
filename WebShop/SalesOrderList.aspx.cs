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
    public partial class SalesOrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //getBpList();

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<salesorder> GetSalesOrderDetails()
        {

            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<salesorder> Prdlst = new List<salesorder>();

                using (SqlConnection con = new SqlConnection(constr))
                {

                    con.Open();

                    SqlCommand comm = new SqlCommand("testdb..[wh_GetSalesOrder]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_flag", "S");
                    //comm.Parameters.Add("@t_mesg", SqlDbType.VarChar, 500);
                    //comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;

                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        Prdlst.Add(new salesorder
                        {
                            t_orno = sdr["t_orno"].ToString(),
                            t_stbp = sdr["t_stbp"].ToString(),
                            t_nama = sdr["t_nama"].ToString(),


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
        //protected void getBpList()
        //{
        //    string tabl;
        //    tabl = "";
        //    WebDataAccess NBData = new WebDataAccess();
        //    WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
        //    SqlCommand SqlComm = new SqlCommand();
        //    SqlComm.CommandType = CommandType.StoredProcedure;
        //    SqlComm.CommandText = "wh_GetSalesOrder";
        //    DataSet sProdPlanData = new DataSet();
        //    try
        //    {
        //        sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
        //        foreach (DataTable table in sProdPlanData.Tables)
        //        {
        //            foreach (DataRow dr in table.Rows)
        //            {
        //                tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_orno"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_orno"].ToString() + "</td></tr>";
        //            }
        //        }
        //        sam.InnerHtml = tabl;
        //    }
        //    catch (Exception ex)
        //    {
        //        //error.InnerHtml = ex.Message.ToString();
        //        ex.ToString();
        //    }
        //}
    }
    public class salesorder
    {
        public string t_orno { get; set; }
        public string t_stbp { get; set; }
        public string t_nama { get; set; }

    }
}