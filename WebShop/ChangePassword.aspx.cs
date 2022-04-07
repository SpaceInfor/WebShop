using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace WebShop
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            NBDataAccess NBData = new NBDataAccess();
            NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
            SqlCommand sqlcom = new SqlCommand();
            DataSet Email = new DataSet();
            string sSql;  
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@password", txtNewPass.Text);
            sqlcom.Parameters.AddWithValue("@userid", Session["t_usid"].ToString());
            sqlcom.CommandText = "WS_ChangePassword";
            string result = "", msg1 = "";
            try
            {
                result = NBData.ExecuteCommand(sqlcom, ref objErr);
                msg1 = result;

                if (result == "success")
                {
                    hdmsg.InnerHtml = "Password has been changed successfully";
                    txtOldPass.Text = "";
                    txtNewPass.Text = "";
                    txtConfPass.Text = "";
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + result + "')", true);
            }
        }
    }
}
