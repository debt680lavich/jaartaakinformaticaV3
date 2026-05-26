using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aanmelden
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAanmelden_Click(object sender, EventArgs e)
        {
            MySqlConnection cnnConnectie;
            MySqlCommand cmdAanmelden;

            string sqlAanmelden;
            string connectiestring;

            //inhoud geven
            connectiestring = "server=localhost;user id=root; database=springkastelen";
            sqlAanmelden = "SELECT tblpersoneel.wachtwoord FROM tblpersoneel\r\nWHERE tblpersoneel.email = @email  ";

            //object + parameter
            cnnConnectie = new MySqlConnection(connectiestring);
            cmdAanmelden = new MySqlCommand(sqlAanmelden, cnnConnectie);

            MySqlParameter paremail = cmdAanmelden.Parameters.Add("@email", MySqlDbType.String);
            paremail.Value = txtEmail.Text;

            //uitvoeren
            cnnConnectie.Open();
           
            if (cmdAanmelden.ExecuteScalar().ToString() == txtWachtwoord.Text)
            {
                Variables.adminaangemeld = true;
                Response.Redirect("AdminPanel.aspx");
            }
            else
            {
                lblFout.Text = "E-mail of wachtwoord is fout of niet gevonden";

            }

            cnnConnectie.Close();
           
        }

        protected void btnRegistreren_Click(object sender, EventArgs e)
        {

        }
    }
}