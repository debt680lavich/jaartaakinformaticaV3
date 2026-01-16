using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls.WebParts;

namespace Aanmelden
{
    public partial class Checkout : System.Web.UI.Page
    {
        MySqlConnection cnnConnectie;
        string connectiestring = "server=localhost;user id=root; database=springkastelen";
        bool controle;

        protected void Page_Load(object sender, EventArgs e)
        {
            //bool om te controleren of alle velden zijn ingevuld
             controle = false;
            
            
            cnnConnectie = new MySqlConnection(connectiestring);
            //gridview vullen met alle gegevens

            grvArtikels.DataSource = Variables.dtblBestelling;
            grvArtikels.DataBind();

            //totaalprijs weergeven
            lbltotaalprijs.Text = "€ " + Variables.totaalbrutobedrag.ToString("F2");

        }

       
        protected void btnBereken_Click(object sender, EventArgs e)
        {
            
        }
        protected void btnBestel_Click(object sender, EventArgs e)
        {
            //controleren of alle velden zijn ingevuld
            if(rbLeveren.Checked == true)
            {
                if(txtStraat.Text != null && txtGemeente.Text != null & txtPostcode.Text != null & txtNummer.Text != null)
                {
                    controle = true;
                }
            }
            else
            {
                if (ddlUur.SelectedValue != "-- Kies uur --")
                {
                    controle = true;
                }
                else
                {
                    controle = false;
                }
            }

            if(controle == false)
            {
                lblfoutmelding.Text = "Nog niet alle velden zijn (correct) ingevuld!";
            }
            else
            {
                //verhuring wegschrijven in sql database
                //eerste laatste verhuurID opvragen en nieuw verhuur id aanmaken
                MySqlCommand cmdLaatseVerhuur;
                MySqlCommand cmdtblVerhuur;
                string sqltblVerhuur;
                string sqlLaatseVerhuur;

                sqlLaatseVerhuur = "SELECT VerhuurID FROM tblverhuringen\r\nORDER BY 1 DESC LIMIT 1 ";
                sqltblVerhuur = "INSERT INTO tblverhuringen(tblverhuringen.VerhuurID, tblverhuringen.KlantID, tblverhuringen.BeginDatum, tblverhuringen.EindDatum, tblverhuringen.Totaalprijs \r\ntblverhuringen.LeveringOphalen) VALUES(@verhuurid, @klantid, @begindatum, @einddatum, @totaalprijs, @leverenophalen)\r\n ";

                cmdLaatseVerhuur = new MySqlCommand(sqlLaatseVerhuur, cnnConnectie);
                cmdtblVerhuur = new MySqlCommand(sqltblVerhuur, cnnConnectie);

                //verhuurID aanmaken
                int OudVerhuurID;
                int nieuwverhuurID;

                cnnConnectie.Open();
                OudVerhuurID = Convert.ToInt32(cmdLaatseVerhuur.ExecuteScalar());
                cnnConnectie.Close();

                nieuwverhuurID = OudVerhuurID++;

                //wegschrijven in variables class
                Variables.verhuurID = OudVerhuurID + 1;

                Variables.tijd = ddlUur.SelectedItem.ToString();
                Variables.straat = txtStraat.Text;
                Variables.huisnummer = txtNummer.Text;
                Variables.postcode = txtPostcode.Text;
                Variables.gemeente = txtGemeente.Text;

                //wegschrijven in tblVerhuringen

                MySqlParameter parVerhuurid = cmdtblVerhuur.Parameters.Add("@verhuurid", MySqlDbType.VarChar);
                MySqlParameter parKlant = cmdtblVerhuur.Parameters.Add("klantid", MySqlDbType.VarChar);
                MySqlParameter parBegindatum = cmdtblVerhuur.Parameters.Add("begindatum", MySqlDbType.Date);
                MySqlParameter parEinddatum = cmdtblVerhuur.Parameters.Add("@einddatum", MySqlDbType.Date);
                MySqlParameter parTotaalprijs = cmdtblVerhuur.Parameters.Add("@totaalprijs", MySqlDbType.Decimal);
                MySqlParameter parLeverenOphalen = cmdtblVerhuur.Parameters.Add("@leverenophalen", MySqlDbType.String);

                parVerhuurid.Value = nieuwverhuurID;
                parKlant.Value = "00030";
                parBegindatum.Value = Variables.begindatum;
                parEinddatum.Value = Variables.einddatum;
                parTotaalprijs.Value = Variables.totaalbrutobedrag;
                parLeverenOphalen.Value = Variables.leverenophalen;

                cnnConnectie.Open();
                //cmdtblVerhuur.ExecuteNonQuery();
                cnnConnectie.Close();

                //wegschrijven in tblartikelsVerhuur
                //uit datagrid artikelID's opvragen en telkens wegschrijven in tabel tblartikelfactuur
                int teller;
                
                for (teller = 0; teller < Variables.aantalrijen; teller++)
                {
                    MySqlCommand cmdWegschrijven;
                    string sqlWegschrijven;
                    sqlWegschrijven = " ";
                    cmdWegschrijven = new MySqlCommand(sqlWegschrijven, cnnConnectie);
                    MySqlParameter ParVerhuurID = cmdWegschrijven.Parameters.Add("@verhuurid", MySqlDbType.Int64);
                    MySqlParameter ParArtikelID = cmdWegschrijven.Parameters.Add("@artikel", MySqlDbType.String);
                    MySqlParameter ParHoeveelheid = cmdWegschrijven.Parameters.Add("@aantal", MySqlDbType.Int64);

                    parVerhuurid.Value = nieuwverhuurID;
                    ParArtikelID.Value = grvArtikels.Rows[teller].Cells[0].Text;
                    ParHoeveelheid.Value = grvArtikels.Rows[teller].Cells[3].Text;

                    cnnConnectie.Open();
                    //cmdWegschrijven.ExecuteNonQuery();
                    cnnConnectie.Close();

                }

                //gebruiker doorsturen naar besteloverzicht
                Response.Redirect("BestelOverzicht.aspx");
            }
            
        }

        
        

        protected void ddlUur_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected void btnTerug_Click(object sender, EventArgs e)
        {
            Variables.paginaterug = true;

            Response.Redirect("Startpagina.aspx");
            
        }

        protected void rbOphalen_CheckedChanged(object sender, EventArgs e)
        {
            if(rbOphalen.Checked == true)
            {
                Variables.leverenophalen = "Ophalen";
            }
        }

        protected void rbLeveren_CheckedChanged(object sender, EventArgs e)
        {
            if(rbLeveren.Checked == true)
            {
                Variables.leverenophalen = "Leveren";
            }
        }
    }
}
