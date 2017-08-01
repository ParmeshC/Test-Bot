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

        public Dictionary<string, string> GetTableColumnsWithData(TableShemaRequest tableShemaRequest)
        {
            Dictionary<string, string> columnNamesDictionay = new Dictionary<string, string>();
            try
            {
                string selectQuery = null;

                string connectionString = GetConnectionString(tableShemaRequest);
                //string Tablename = "RFRFFID";
                using (OracleConnection connection = new OracleConnection())
                {
                    connection.ConnectionString = connectionString;
                    connection.Open();

                    OracleCommand command = connection.CreateCommand();
                    string sql = "select COLUMN_NAME,NULLABLE from  all_tab_columns where Table_Name='" + tableShemaRequest.TableName + "'";

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

                    selectQuery = selectQuery + " FROM " + tableShemaRequest.TableName + " WHERE ROWNUM = 1";
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
                Console.WriteLine("An error occurred: '{0}'", err);

            }
            return columnNamesDictionay;
        }


        public List<TableSchemaDescription> GetTableDescribe(TableShemaRequest tableShemaRequest)
        {
            List<TableSchemaDescription> tableDescribeList = new List<TableSchemaDescription>();
            try
            {
                string connectionString = GetConnectionString(tableShemaRequest);
                using (OracleConnection connection = new OracleConnection())
                {
                    connection.ConnectionString = connectionString;
                    connection.Open();

                    OracleCommand command = connection.CreateCommand();
                    string sql = "select COLUMN_NAME,NULLABLE from  all_tab_columns where Table_Name='" + tableShemaRequest.TableName + "'";

                    command.CommandText = sql;
                    OracleDataReader reader = command.ExecuteReader();
                    
                    while (reader.Read())
                    {
                            TableSchemaDescription tableDescribe = new TableSchemaDescription();
                            tableDescribe.Name = Convert.ToString(reader["COLUMN_NAME"]);
                            tableDescribe.Null = Convert.ToString(reader["NULLABLE"]);
                            tableDescribeList.Add(tableDescribe);
                    }
                }

            }
            catch (Exception err)
            {
                //log the error
                Console.WriteLine("An error occurred: '{0}'", err);

            }
            return tableDescribeList;
        }        

        public List<string> GetAllTableNames(DataConnection ConnectionParameter)
        {
            List<string> tableNames = new List<string>();
            try
            {
                string connectionString = GetConnectionString(ConnectionParameter);
                using (OracleConnection connection = new OracleConnection())
                {
                    connection.ConnectionString = connectionString;
                    connection.Open();

                    OracleCommand command = connection.CreateCommand();
                    string sql = "select table_name from user_tables";
                    command.CommandText = sql;
                    OracleDataReader reader = command.ExecuteReader();
                    //reader.FetchSize = reader.RowSize * 1000;
                    while (reader.Read())
                    {
                        if (reader.HasRows)
                        {
                            for (int index = 0; index < reader.FieldCount; index++)
                            {
                                string clmnValue = reader.GetValue(index).ToString();                                
                                tableNames.Add(clmnValue);
                            }
                        }
                    }
                }

            }
            catch (Exception err)
            {
                //log the error
                Console.WriteLine("An error occurred: '{0}'", err);
            }
            return tableNames;
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
    public class TableShemaRequest : DataConnection
    {
        public string TableName { get; set; }
    }

    public class TableSchemaDescription
    {
        public string Name { get; set; }
        public string Null { get; set; }

    }
}
