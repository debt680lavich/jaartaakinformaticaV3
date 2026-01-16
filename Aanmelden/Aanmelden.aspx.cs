using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aanmelden
{
    public partial class Aanmelden : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {

        }

        protected void btnAanmelden_Click(object sender, EventArgs e)
        {
            //declareren
            MySqlConnection cnnConnectie;
            MySqlCommand cmdAanmelden;

            string sqlAanmelden;
            string connectiestring;

            //inhoud geven
            connectiestring = "server=localhost;user id=root; database=springkastelen";
            sqlAanmelden = "select tblklanten.Wachtwoord FROM tblklanten\r\nWHERE tblklanten.KlantEmail = @email  ";

            //object + parameter
            cnnConnectie = new MySqlConnection(connectiestring);
            cmdAanmelden = new MySqlCommand(sqlAanmelden, cnnConnectie);

            MySqlParameter paremail = cmdAanmelden.Parameters.Add("@email", MySqlDbType.String);
            paremail.Value = txtEmail.Text;

            //uitvoeren
            cnnConnectie.Open();
            //MySqlDataReader dtremail = default(MySqlDataReader);
            //dtremail = cmdAanmelden.ExecuteReader();
            //string email;
            //while(dtremail.Read())
            //{
            //    email = dtremail.ToString();
            //    if(email == txtEmail.Text )
            //    {
                    if (cmdAanmelden.ExecuteScalar().ToString() == txtWachtwoord.Text)
                    {
                        Response.Redirect("Startpagina.aspx");
                        Variables.aangemeld = true;
                    }
                    else
                    {
                        lblFout.Text = "E-mail of wachtwoord is fout of niet gevonden";
                       
                    }
            //    }
            //    else
            //    {
            //        lblFout.Text = "Email niet gevonden, registreer jezelf";
            //    }
            //}
            cnnConnectie.Close();
        }

        protected void btnRegistreren_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registreren.aspx");
        }
    }
}