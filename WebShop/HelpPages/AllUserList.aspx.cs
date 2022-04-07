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
    public partial class AllUserList : System.Web.UI.Page
    {
        string t_dept = string.Empty;
        int t_comm = 0;
        int communication;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {


                //if (Request.QueryString["t_comm"] != null)
                //{
                //    HttpContext.Current.Session.Add("t_comm", Request.QueryString["t_comm"].ToString());
                //}

                //if (Session["t_comm"] != null)
                //{
                //    HttpContext.Current.Session["t_comm"] = Session["t_comm"].ToString();
                //    t_comm =  Convert.ToInt32(Session["t_comm"]);
                //}
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
            //SqlComm.CommandText = "select t_usid,t_nama from swlive..ttdtst250100";
            //communication = Convert.ToInt32(t_comm);
            //if (communication == 1)
            //{
            //SqlComm.CommandText = "SELECT T1.t_usid,T2.t_nama as t_usiddesc,T1.t_dept,T3.t_desc as t_deptdesc,T1.t_levl from swlive..ttdtst170100 As T1 inner join swlive..ttdtst250100 As T2 ON T1.t_usid = T2.t_usid inner join swlive..ttdtst167100 As T3 ON T1.t_dept = T3.t_dept";
                SqlComm.CommandText = "SELECT T2.t_usid,T2.t_nama as t_usiddesc,T1.t_dept,T3.t_desc as t_deptdesc,T1.t_levl from swlive..ttdtst170100 As T1 right outer join swlive..ttdtst250100 As T2 ON T1.t_usid = T2.t_usid left outer join swlive..ttdtst167100 As T3 ON T1.t_dept = T3.t_dept";
            //}
            //else
            //{
            //    SqlComm.CommandText = "SELECT T1.t_usid,T2.t_nama as t_usiddesc,T1.t_dept,T3.t_desc as t_deptdesc,T1.t_levl from swlive..ttdtst170100 As T1 inner join swlive..ttdtst250100 As T2 ON T1.t_usid = T2.t_usid inner join swlive..ttdtst167100 As T3 ON T1.t_dept = T3.t_dept where T1.t_dept='"+ t_dept +"'";
            //}
            DataSet sProdPlanData = new DataSet();
            try
            {
                sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
                foreach (DataTable table in sProdPlanData.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_usid"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_usid"].ToString() + "</td><td>" + dr["t_usiddesc"].ToString() + "</td><td>" + dr["t_dept"].ToString() + "</td><td>" + dr["t_deptdesc"].ToString() + "</td><td>" + dr["t_levl"].ToString() + "</td></tr>";
                        //,'" + dr["t_dept"].ToString() + "'
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