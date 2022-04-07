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
    public partial class RMPlanningReport : System.Web.UI.Page
    {
        private static string message = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<twhwmd215100> GetWarehouseDes(string t_cwar)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<twhwmd215100> prclst = new List<twhwmd215100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("select t_cwar,t_dsca from swlive..ttcmcs003100 where t_cwar = '"+ t_cwar + "'", con);
                    comm.CommandType = CommandType.Text;
                    
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new twhwmd215100
                        {
                            t_dsca = rdr["t_dsca"].ToString(),
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
        public static List<ttdipu001100> GetSupplierDes(string t_otbp)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<ttdipu001100> prclst = new List<ttdipu001100>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_supplierList]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add(new SqlParameter("@t_otbp", t_otbp));
                    comm.Parameters.Add("@t_mesg", SqlDbType.Char, 500);
                    comm.Parameters["@t_mesg"].Direction = ParameterDirection.Output;
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new ttdipu001100
                        {
                            t_nama = rdr["t_nama"].ToString(),
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
        public static List<twhwmd215100_table> GetWPlanningDetails(string t_cwar, string t_bpid, string t_bmsl)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<twhwmd215100_table> prclst = new List<twhwmd215100_table>();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("testdb..[wh_planning_dashboard]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add(new SqlParameter("@t_cwar", t_cwar));
                    if (t_bpid!="")
                      comm.Parameters.Add(new SqlParameter("@t_bpid", t_bpid));
                    if (t_bmsl!="")
                      comm.Parameters.Add(new SqlParameter("@t_bmsl", t_bmsl));
                    
                  
                    SqlDataReader rdr = comm.ExecuteReader();
                    while (rdr.Read())
                    {
                        prclst.Add(new twhwmd215100_table
                        {
                            ItemGroup = rdr["ItemGroup"].ToString(),
                            ItemGroupDesc = rdr["ItemGroupDesc"].ToString(),
                            ItemCode = rdr["ItemCode"].ToString(),
                            ItemDescription = rdr["ItemDescription"].ToString(),
                            UnitOfMeasure = rdr["UnitOfMeasure"].ToString(),
                            SupplierCode = rdr["SupplierCode"].ToString(),
                            SupplierName = rdr["SupplierName"].ToString(),
                            Warehouse = rdr["Warehouse"].ToString(),
                            OnHandInventory = rdr["Inventory"].ToString(),
                            AMC = rdr["AMC"].ToString(),
                            MSL = rdr["MSL"].ToString(),
                            ReOrderPoint = rdr["ReOrderPoint"].ToString(),
                            SupplyTime = rdr["SupplyTime"].ToString(),
                            Blocked = rdr["Blocked"].ToString(),
                            Allocated = rdr["Allocated"].ToString(),
                            OnOrder = rdr["OnOrder"].ToString(),
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
    }
    public class twhwmd215100
    {
        public string t_cwar { get; set; }
        public string t_dsca { get; set; }
    }
    public class ttdipu001100
    {
        public string t_otbp { get; set; }
        public string t_nama { get; set; }
    }
    public class twhwmd215100_table
    {
        public string ItemGroup { get; set; }
        public string ItemGroupDesc { get; set; }
        public string ItemCode { get; set; }
        public string ItemDescription { get; set; }
        public string UnitOfMeasure { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierName { get; set; }
        public string Warehouse { get; set; }
        public string OnHandInventory { get; set; }
        public string AMC { get; set; }
        public string MSL { get; set; }
        public string ReOrderPoint { get; set; }
        public string SupplyTime { get; set; }
        public string Blocked { get; set; }
        public string Allocated { get; set; }
        public string OnOrder { get; set; }
    }

}
