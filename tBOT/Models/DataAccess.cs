using System;
using System.Linq;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Collections.Generic;

namespace tBOT.API
{
    class DataAccess
    {

        private static string GetConnectionString(DataConnection ConnParam)
        {

            //string hostName = "149.24.38.229";
            //string portNumber = "1521";
            //string serviceName = "BAN83";
            //string userId = "baninst1";
            //string password = "u_pick_it";


            String connString = "Data Source = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = " + ConnParam.HostName + ")(PORT = " + ConnParam.PortNumber +
                "))(CONNECT_DATA = (SERVICE_NAME = " + ConnParam.ServiceName + "))); user id = " + ConnParam.UserId + "; Password = " + ConnParam.Password + ";";

            return connString;
        }

        private Dictionary<string, string> GetTableColumnsWithData(string TableName, DataConnection ConnectionParameter )
        {
            Dictionary<string, string> columnNamesDictionay = new Dictionary<string, string>();
            try
            {
                string selectQuery = null;


                string connectionString = GetConnectionString(ConnectionParameter);
                string tablename = "RFRFFID";
                using (OracleConnection connection = new OracleConnection())
                {
                    connection.ConnectionString = connectionString;
                    connection.Open();
                    Console.WriteLine("State: {0}", connection.State);
                    Console.WriteLine("ConnectionString: {0}",
                                      connection.ConnectionString);

                    OracleCommand command = connection.CreateCommand();
                    string sql = "select COLUMN_NAME,NULLABLE from  all_tab_columns where Table_Name='" + tablename + "'";

                    command.CommandText = sql;

                    OracleDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        string nullable = (string)reader["NULLABLE"];
                        string columnName = (string)reader["COLUMN_NAME"];
                        if (nullable == "N")
                        {
                            columnNamesDictionay.Add(columnName, "");
                            selectQuery = selectQuery != null ? selectQuery + ", " + columnName : "SELECT " + columnName;

                        }
                    }

                    selectQuery = selectQuery + " FROM " + tablename + " WHERE ROWNUM = 1";
                    command.CommandText = selectQuery;
                    reader = command.ExecuteReader();
                    while (reader.Read())
                    {

                        if (reader.HasRows)
                        {
                            for (int index = 0; index < reader.FieldCount; index++)
                            {
                                string clmnName = reader.GetName(index).ToString();
                                string clmnValue = reader.GetValue(index).ToString();
                                columnNamesDictionay[clmnName] = clmnValue;
                            }
                        }
                    }

                }


            }
            catch (Exception err)
            {
                //log the error
                //MessageBox.Show(err.Message.ToString());

            }
            return columnNamesDictionay;
        }
    }

    public class DataConnection
    {
        public string HostName { get; set; }
        public string PortNumber { get; set; }
        public string ServiceName { get; set; }
        public string UserId { get; set; }
        public string Password { get; set; }

    }

}
