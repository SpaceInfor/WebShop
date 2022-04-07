using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace WebShop
{
  [WebService(Namespace = "https://scp.spacewood.in")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class GetStockInHand : System.Web.Services.WebService
  {

    [WebMethod]

    public void GetStock(string t_item)
    {
      var cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      var stock = new List<wh_stock>();
      using (var con = new SqlConnection(cs))
      {
        var cmd = new SqlCommand("select t_item,t_qhnd from swlive..twhwmd215100 where t_cwar='FG-NIM' and ltrim(rtrim(t_item)) = '"+ t_item + "'", con) { CommandType = CommandType.Text };
        con.Open();
        var dr = cmd.ExecuteReader();
        while (dr.Read())
        {
          var item_stock = new wh_stock
          {
            t_item = dr[0].ToString(),
            t_qhnd = Convert.ToInt32(dr[1].ToString())
          };
          stock.Add(item_stock);
        }
      }
      var js = new JavaScriptSerializer();
      Context.Response.Write(js.Serialize(stock));
    }
    
    
  }
}
