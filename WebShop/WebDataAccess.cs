using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for WebDataAccess
/// </summary>
public class WebDataAccess
{

    public struct ErrorAttributes
    {
        public int Number;
        public string Message;
        public string Source;
        public string SystemMessage;
        public string ErrorLocation;
        public string RedirectionURL;
        public string RedirectMessage;
        public string Location;
    }

    public WebDataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    private SqlConnection GetConnectionObj(ref ErrorAttributes oErrObj)
    {
        SqlConnection oConn = new SqlConnection();

        try
          {
            oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString);
            //oConn = new SqlConnection("Data Source = 192.168.1.24,49936; Initial Catalog = PeopleConnect; User ID = sa; Password = Info@2019; Integrated Security = False");
            return oConn;
        }
        catch (Exception Ex)
        {
            oErrObj.Message = "Error while opening a data connection. Please refer this error to Admin for further resolution.";
            oErrObj.Source = Ex.Source;
            oErrObj.Number = 1;
            oErrObj.ErrorLocation = "GetConnectionObject";
            oErrObj.SystemMessage = Ex.Message;
            CloseConnection(oConn);
            return null;
        }
    }

    public void InitError(ErrorAttributes oErrAtt)
    {
        oErrAtt.Number = 0;
        oErrAtt.Message = "";
        oErrAtt.Source = "";
        oErrAtt.SystemMessage = "";
        oErrAtt.ErrorLocation = "";
        oErrAtt.RedirectionURL = "";
        oErrAtt.RedirectMessage = "";
        oErrAtt.Location = "";
    }

    public void CloseConnection(SqlConnection oConn)
    {
        try
        {
            if (oConn.State == ConnectionState.Open)
            {
                oConn.Close();
                oConn.Dispose();
                oConn = null;
            }
            else
            {
                oConn = null;
            }
        }
        catch (Exception ex)
        {
            oConn = null;
        }
    }

    //'#
    //'#
    //'#
    //'#
    //'Function to create and return DataReader Object
    public SqlDataReader GetDataReader(string sCommandText, bool ConnectionClose, ref ErrorAttributes oErrObj)
    {

        ConnectionClose = true;
        SqlConnection oConnect;
        oConnect = GetConnectionObj(ref oErrObj);

        if (oErrObj.Message != "")
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataReader";
            CloseConnection(oConnect);
            return null;
        }

        SqlCommand oCommand = new SqlCommand();
        //SqlDataReader oDataReader = SqlDataReader();

        try
        {
            oCommand.CommandText = sCommandText;
            oCommand.Connection = oConnect;
            oConnect.Open();
            SqlDataReader oDataReader = oCommand.ExecuteReader(CommandBehavior.CloseConnection);

            oCommand.Dispose();
            oCommand = null;
            return oDataReader;
        }
        catch (Exception ex)
        {
            oErrObj.Message = "Error while running a data procedure. Please refer this error to Admin for further resolution.";
            oErrObj.Source = ex.Source;
            oErrObj.Number = 2;
            oErrObj.ErrorLocation = "GetDataReader" + " :: " + sCommandText;
            oErrObj.SystemMessage = ex.Message;
            oCommand = null;
            CloseConnection(oConnect);
            return null;
        }
    }

    // '#
    // '#
    // '#
    // '#
    // 'Function to create and return DataSet Object        
    public DataSet GetDataSet(string sCommandText, CommandType CmdType, bool ConnectionClose, ref ErrorAttributes oErrObj)
    {
        ConnectionClose = true;
        SqlConnection oConnect;
        oConnect = GetConnectionObj(ref oErrObj);

        if (oErrObj.Message != "" && oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
            CloseConnection(oConnect);
            return null;
        }
        if (oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
            CloseConnection(oConnect);
            return null;
        }
        SqlDataAdapter oDataAdapter = new SqlDataAdapter();
        DataSet oDataSet = new DataSet();
        try
        {
            oDataAdapter = new SqlDataAdapter(sCommandText, oConnect);
            oDataAdapter.Fill(oDataSet);
            oDataAdapter.Dispose();
            if (ConnectionClose == true)
            {
                CloseConnection(oConnect);
            }
            return oDataSet;
        }
        catch (Exception Ex)
        {

            oErrObj.Message = "Error while running a data set. Please refer this error to Admin for further resolution.";
            oErrObj.Source = Ex.Source;
            oErrObj.Number = 3;
            oErrObj.ErrorLocation = "GetDataSet" + " :: " + sCommandText;
            oErrObj.SystemMessage = Ex.Message;
            oDataAdapter = null;
            oDataSet = null;
            CloseConnection(oConnect);
            return null;
        }
    }
    public DataSet GetDataSetViaSP(SqlCommand SqlComm, bool ConnectionClose, ref ErrorAttributes oErrObj)
    {
        ConnectionClose = true;
        SqlConnection oConnect;
        oConnect = GetConnectionObj(ref oErrObj);
        SqlComm.Connection = oConnect;
        if (oErrObj.Message != "" && oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
            CloseConnection(oConnect);
            return null;
        }
        if (oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
            CloseConnection(oConnect);
            return null;
        }
        SqlDataAdapter oDataAdapter = new SqlDataAdapter();
        DataSet oDataSet = new DataSet();
        try
        {
            oDataAdapter = new SqlDataAdapter(SqlComm);
            oDataAdapter.Fill(oDataSet);
            oDataAdapter.Dispose();
            if (ConnectionClose == true)
            {
                CloseConnection(oConnect);
            }
            return oDataSet;
        }
        catch (Exception Ex)
        {

            oErrObj.Message = "Error while running a data set. Please refer this error to Admin for further resolution.";
            oErrObj.Source = Ex.Source;
            oErrObj.Number = 3;
            oErrObj.ErrorLocation = "GetDataSetViaSp";
            oErrObj.SystemMessage = Ex.Message;
            oDataAdapter = null;
            oDataSet = null;
            CloseConnection(oConnect);
            return null;
        }
    }
  public DataTable GetDataSetViaSPTab(SqlCommand SqlComm, bool ConnectionClose, ref ErrorAttributes oErrObj)
  {
    ConnectionClose = true;
    SqlConnection oConnect;
    oConnect = GetConnectionObj(ref oErrObj);
    SqlComm.Connection = oConnect;
    if (oErrObj.Message != "" && oErrObj.Message != null)
    {
      oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
      CloseConnection(oConnect);
      return null;
    }
    if (oErrObj.Message != null)
    {
      oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "GetDataSet ";
      CloseConnection(oConnect);
      return null;
    }
    SqlDataAdapter oDataAdapter = new SqlDataAdapter();
    DataTable oDataSet = new DataTable();
    try
    {
      oDataAdapter = new SqlDataAdapter(SqlComm);
      oDataAdapter.Fill(oDataSet);
      oDataAdapter.Dispose();
      if (ConnectionClose == true)
      {
        CloseConnection(oConnect);
      }
      return oDataSet;
    }
    catch (Exception Ex)
    {

      oErrObj.Message = "Error while running a data set. Please refer this error to Admin for further resolution.";
      oErrObj.Source = Ex.Source;
      oErrObj.Number = 3;
      oErrObj.ErrorLocation = "GetDataSetViaSp";
      oErrObj.SystemMessage = Ex.Message;
      oDataAdapter = null;
      oDataSet = null;
      CloseConnection(oConnect);
      return null;
    }
  }

  public string ExecuteQuery(string sCommandText, ref ErrorAttributes oErrObj)
    {
        string sMessage = "";
        SqlConnection oConnect;
        oConnect = GetConnectionObj(ref oErrObj);
        if (oErrObj.Message != "" && oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "ExecuteQuery ";
            CloseConnection(oConnect);
            return null;
        }
        SqlCommand oCommand = new SqlCommand();
        try
        {
            oCommand.CommandText = sCommandText.Replace("&apos;", "''");
            oCommand.Connection = oConnect;
            oConnect.Open();
            oCommand.ExecuteNonQuery();
            sMessage = "success";
            oCommand.Dispose();
            oCommand = null;
            CloseConnection(oConnect);
            return sMessage;
        }
        catch (Exception ex)
        {
            oErrObj.Message = "Error while updating data. Please refer this error to Admin for further resolution";
            oErrObj.Source = ex.Source;
            oErrObj.Number = 4;
            oErrObj.ErrorLocation = "ExecuteQuery :: " + sCommandText;
            oErrObj.SystemMessage = ex.Message;
            oCommand = null;
            CloseConnection(oConnect);
            return ex.Message;
        }
    }

    public string ExecuteCommand(SqlCommand oCommand, ref ErrorAttributes oErrObj)
    {
        string sMessage = "";
        SqlConnection oConnect;
        oConnect = GetConnectionObj(ref oErrObj);
        if (oErrObj.Message != "" && oErrObj.Message != null)
        {
            oErrObj.ErrorLocation = oErrObj.ErrorLocation + " :: " + "ExecuteQuery ";
            CloseConnection(oConnect);
            return null;
        }
        try
        {
            oCommand.Connection = oConnect;
            oConnect.Open();
            oCommand.ExecuteNonQuery();
            sMessage = "success";
            oCommand.Dispose();
            oCommand = null;
            CloseConnection(oConnect);
            return sMessage;
        }
        catch (Exception ex)
        {
            oErrObj.Message = "Error while updating data. Please refer this error to Admin for further resolution";
            oErrObj.Source = ex.Source;
            oErrObj.Number = 4;
            oErrObj.ErrorLocation = "ExecuteQuery :: " + ex.Message;
            oErrObj.SystemMessage = ex.Message;
            oCommand = null;
            CloseConnection(oConnect);
            return ex.Message;
        }
    }
}

