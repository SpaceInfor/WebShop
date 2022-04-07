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
    public partial class SupplierList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getBpList();

            }
        }
        protected void getBpList()
        {
            string tabl;
            tabl = "";
            NBDataAccess NBData = new NBDataAccess();
            NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
            SqlCommand SqlComm = new SqlCommand();
            SqlComm.CommandType = CommandType.Text;
            SqlComm.CommandText = "select distinct ipd.t_otbp as t_bpid,bp.t_nama as t_nama from swlive..ttdipu001100 ipd join swlive..ttccom100100 bp on(bp.t_bpid = ipd.t_otbp)";
            DataSet sProdPlanData = new DataSet();
            try
            {
                sProdPlanData = NBData.GetDataSetViaSP(SqlComm, true, ref objErr);
                foreach (DataTable table in sProdPlanData.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        tabl = tabl + "<tr><td><button type='button' class='btn btn-block btn-secondary' OnClick=javascript:GetSelectedRow('" + dr["t_bpid"].ToString() + "')><i class='fas fa-arrow-circle-left'></i></button></td><td>" + dr["t_bpid"].ToString() + "</td><td>" + dr["t_nama"].ToString() + "</td></tr>";
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