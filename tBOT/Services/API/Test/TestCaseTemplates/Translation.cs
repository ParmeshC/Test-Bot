using System;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public static class Translate
    {
        public enum Status
        {
            Matching,
            NotMatching,
            NoAPIMessage,
            NoTargetValue
        }

        public static Status GetMessageStatus(string MessageKey, string TargetFolderPath, string ApiErrorMessage)
        {
            Status status = Status.NoAPIMessage;
            if (string.IsNullOrEmpty(ApiErrorMessage)) { return status; }
            try
            {
                string messageValueConverted = null;
                string msgeValue = null;
                bool flag = false;

                string[] files = Directory.GetFiles(TargetFolderPath, "*.*", SearchOption.AllDirectories);
                foreach (string file in files)
                {
                    foreach (var rowItem in File.ReadAllLines(file))
                    {
                        msgeValue = rowItem.Split('=').Length > 1 ? rowItem.Split('=')[0] == MessageKey ? rowItem.Split('=')[1] : null : null;
                        if (msgeValue != null)
                        {
                            //Converting unicode to string
                            Regex rx = new Regex(@"\\[uU]([0-9A-F]{4})");
                            messageValueConverted = rx.Replace(msgeValue, match => ((char)Int32.Parse(match.Value.Substring(2), NumberStyles.HexNumber)).ToString());
                            status = messageValueConverted.TrimEnd('.') == ApiErrorMessage.TrimEnd('.') ? Status.Matching : Status.NotMatching;
                            flag = true;
                            break;
                        }
                    }
                    if (flag) break;
                }
                if (msgeValue == null) status = Status.NoTargetValue;

            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: '{0}'", ex);
            }
            return status;
        }

        public static string GetMessageKey(string messageValue, string messagesFolderPath)
        {
            string key = null;
            try
            {
                bool flag = false;

                string[] files = Directory.GetFiles(messagesFolderPath, "*.*", SearchOption.AllDirectories);
                foreach (string file in files)
                {
                    foreach (var rowItem in File.ReadAllLines(file))
                    {
                        key = rowItem.Split('=').Length > 1 ? rowItem.Split('=')[1] == messageValue ? rowItem.Split('=')[0] : null : null;
                        if (key != null)
                        {
                            flag = true;
                            break;
                        }
                    }
                    if (flag) break;
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: '{0}'", ex);
            }
            return key;
        }
    }

    public class TranlsationRequestData 
    {
        public string MessageKey { get; set; }
        public string ExpectedErrorMessage { get; set; }
    }

    public class LanguageSelection : INotifyPropertyChanged
    {
        private bool _IsSelected = false;
        public bool Check { get { return _IsSelected; } set { _IsSelected = value; OnChanged("Check"); } }
        public string Region { get; set; }
        public string Code { get; set; }
        public string TargetFolder { get; set; }
        public int Matching { get; set; }
        public int NotMatching { get; set; }
        public int NoAPIMessage { get; set; }
        public int NoTargetValue { get; set; }


        public event PropertyChangedEventHandler PropertyChanged;
        private void OnChanged(string prop)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
    }
}
