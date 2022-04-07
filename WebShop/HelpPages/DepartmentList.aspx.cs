using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebShop.HelpPages
{
    public partial class DepartmentList : System.Web.UI.Page
    {
        string t_dept = string.Empty;
        int t_comm = 0;
        int t_levl = 0;
        int communication;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["t_comm"] != null)
                {
                    HttpContext.Current.Session["t_comm"] = Session["t_comm"].ToString();
                    t_comm = Convert.ToInt32(Session["t_comm"]);
                }
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
                    t_dept = Session["t_dept"].ToString();
                }
                if (Session["t_levl"] != null)
                {
                    HttpContext.Current.Session["t_levl"] = Session["t_levl"].ToString();
                    t_levl = Convert.ToInt32(Session["t_levl"].ToString());
                }
                getBpList();

            }
        }

        protected void getBpList()
        {
            string tabl;
            tabl = "";
            WebDataAccess NBData = new WebDataAccess();
            WebDataAccess.ErrorAttributes objErr = new WebDataAccess.ErrorAttributes();
            SqlCommand SqlComm = new SqlCommand();
            SqlComm.CommandType = CommandType.Text;
            communication = Convert.ToInt32(t_comm);
            if (t_levl == 1 && communication == 1)
            {
                //SqlComm.CommandText = "select distinct t1.t_dept,t1.t_desc,t2.t_levl from swlive..ttdtst167100 as t1 INNER JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept";
                SqlComm.CommandText = "select distinct t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 where t1.t_dept != '"+ t_dept +"'";
               
            }
            else if(t_levl == 1 && communication == 2)
            {
                //SqlComm.CommandText = "select t1.t_dept,t1.t_desc,t2.t_levl from swlive..ttdtst167100 as t1 INNER JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept where t2.t_levl=1 and t2.t_dept != '" + t_dept + "'";
                SqlComm.CommandText = "select t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 LEFT JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept where t2.t_levl=1 and t2.t_dept != '" + t_dept + "'";
            }
            else if (t_levl == 2 && communication == 1)
            {
                //SqlComm.CommandText = "select t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 LEFT JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept where t2.t_levl = 1 or t2.t_levl = 2 and t2.t_dept != '" + t_dept + "'";
                SqlComm.CommandText = "select t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 WHERE t1.t_dept != '" + t_dept + "'";
                //where t2.t_levl = 1 or t2.t_levl = 2
            }
            else if (t_levl == 2 && communication == 2)
            {
                SqlComm.CommandText = "select DISTINCT t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 LEFT JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept where t2.t_dept='" + t_dept + "'";
            }
            else if(t_levl == 3 && communication == 2)
            {
                SqlComm.CommandText = "select DISTINCT t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1 LEFT JOIN swlive..ttdtst170100 as t2 on t1.t_dept=t2.t_dept where t2.t_dept='" + t_dept + "'";
                //where t2.t_levl = 1 or t2.t_levl = 2
            }
            else
            {
                SqlComm.CommandText = "select t1.t_dept,t1.t_desc from swlive..ttdtst167100 as t1";
            }
            

            DataSet sProdPlanData = new DataSet();
            try
            {
                sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
                foreach (DataTable table in sProdPlanData.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_dept"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_dept"].ToString() + "</td><td>" + dr["t_desc"].ToString() + "</td></tr>";
                        //<td>" + dr["t_levl"].ToString() + "</td>
                    }
                }
                sam.InnerHtml = tabl;
            }
            catch (Exception ex)
            {
                //error.InnerHtml = ex.Message.ToString();
                ex.ToString();
            }
        }
    }
}
