using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace _8_Elements.Models
{
    public interface IRegiterUser
    {
        void RegisterUser(RegisterUser parameters);
    }
    public class RegisterUser : IRegiterUser
    {
        [Key]
        public Guid trx_id { get; set; }
        [Required]
        public string msisdn { get; set; }
        [Required]
        public string service_id { get; set; }
        public string service_code { get; set; }
        public string Provider { get; set; }
        public string PriceCode { get; set; }
        public DateTime createddate { get; set; }
        public DateTime subscribe { get; set; }
        public bool is_subscribe { get; set; }

        void IRegiterUser.RegisterUser(RegisterUser parameters)
        {
            string url = string.Empty;
            string CallBack = string.Empty;
            parameters.trx_id = Guid.NewGuid();
            string StatusCode = string.Empty;
            string Status = string.Empty;

            if (parameters.Provider == "Telkomsel")
            {
                url = string.Format(@"http://10.0.0.1/register?msisdn={0}service_id={1}&trx_id={2}", parameters.msisdn, parameters.service_id, trx_id);
            }
            else if (parameters.Provider == "XL")
            {
                url = string.Format(@"http://register.example.com?sc={0}&sid={1}&tid={2}", "9800", parameters.service_id, trx_id);
            }

            CallBack = CallApi(url);
            Status = CallApi(CallBack.Replace("phone number", parameters.msisdn).Replace("transaction ID", parameters.trx_id.ToString()).Replace("status code", StatusCode));

            //Save Data
            try
            {
                string sql = string.Format("insert into RegiterUser (" +
                    "trx_id" +
                    ",msisdn" +
                    ",service_id" +
                    ",service_code" +
                    ",Provider" +
                    ",createddate" +
                    ") values ('{0}','{1}','{2}','{3}','{4}','{5}')", new object[6] {
                        parameters.trx_id,
                        parameters.msisdn,
                        parameters.service_id,
                        parameters.service_code,
                        parameters.Provider,
                        DateTime.Now
                });
                ExecuteSql(sql);

            }
            catch (Exception)
            {
                throw;
            }

            if (Status == "0")
            {
                if (parameters.Provider == "Telkomsel")
                {
                    url = string.Format(@"http://10.0.0.1/charge?msisdn={0}&service_id={1}&price_code={2}&trx_id={3}", new object[4] {
                            parameters.msisdn,
                            parameters.service_id,
                            parameters.PriceCode,
                            parameters.trx_id
                        });
                }
                else if (parameters.Provider == "XL")
                {
                    url = string.Format(@"http://20.0.0.1/charge?msisdn={0}&sc={1}&jumlah={2}&tx_id={3}", new object[4] {
                            parameters.msisdn,
                            parameters.service_id,
                            parameters.PriceCode,
                            parameters.trx_id
                        });
                }

                string Aktivasi = CallApi(url);
                //Berhasil
                if (Aktivasi == "0")
                {
                    parameters.is_subscribe = true;
                    if (parameters.service_id == "MUSIC_WEEKLY")
                        parameters.subscribe = DateTime.Now.AddDays(7);
                    else if (parameters.service_id == "MUSIC_MONTHLY")
                        parameters.subscribe = DateTime.Now.AddMonths(1);
                }
                else if (Aktivasi == "1")
                {
                    parameters.is_subscribe = false;
                    parameters.subscribe = DateTime.Now.AddDays(3);
                }

                string sql = string.Format("insert into Transaksi values ('{0}','{1}',{2},{3})", new object[4] { 
                    parameters.trx_id,
                    parameters.PriceCode,
                    parameters.subscribe,
                    parameters.is_subscribe
                });
                ExecuteSql(sql);
            }
        }

        public static string CallApi(string Url)
        { return ""; }
        void ExecuteSql(string sqlCommand) { }

    }
}

