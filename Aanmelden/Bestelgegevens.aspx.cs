using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aanmelden
{
    public partial class Bestelgegevens : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //datatable 
            DataTable winkelwagen = (DataTable)Session["winkelwagen"];
            Variables.dtblBestelling = winkelwagen.Copy();

            //kijken of klant ophalen of leveren heeft gekozen
            string type = Session["type"]?.ToString();
            lblFout.Text = "Type = " + type;

            hiddenType.Value = type;

            if (type == "optOphalen")
            {
                pnlAdres.Visible = true;
            }
            else
            {
                pnlAdres.Visible = false;
            }

        }

        protected void btnVerder_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNaam.Text) ||
                string.IsNullOrEmpty(txtAchternaam.Text) ||
                string.IsNullOrEmpty(txtEmail.Text)  ||
                string.IsNullOrEmpty(txtTel.Text))
            {
                lblFout.Text = "Gelieve alle verplichte velden in te vullen.";
                return;
            }

            if (hiddenType.Value == "optOphalen")
            {
                if (string.IsNullOrEmpty(txtStraat.Text))
                {
                    lblFout.Text = "Adres is verplicht bij ophalen.";
                    return;
                }
            }

            if (string.IsNullOrEmpty(hiddenBetaling.Value))
            {
                lblFout.Text = "Kies een betaalmethode.";
                return;
            }

            // Opslaan in session 
            Session["naam"] = txtNaam.Text;
            Session["betaling"] = hiddenBetaling.Value;
            Variables.betaalwijze = hiddenBetaling.Value;

            // Volgende pagina
            Variables.Naam = txtNaam.Text;
            Variables.Achternaam = txtAchternaam.Text;
            Variables.email = txtEmail.Text;
            Variables.telefoonnr = txtTel.Text;

            if (hiddenType.Value == "optOphalen")
            {
                Variables.straat = txtStraat.Text;
                Variables.huisnummer = txtNummer.Text;
                Variables.postcode = txtPostcode.Text;
                Variables.gemeente = txtGemeente.Text;
                Variables.leverenophalen = "Ophalen";
            }

            Bestelbevestiging();
        }

        private void Bestelbevestiging()
        {
            MySqlConnection cnnConnectie;
            string connectiestring = "server=localhost;user id=root; database=springkastelen";
            cnnConnectie = new MySqlConnection(connectiestring);


            //verhuring wegschrijven in sql database
            ////eerste laatste verhuurID opvragen en nieuw verhuur id aanmaken
            //MySqlCommand cmdLaatseVerhuur;
            //MySqlCommand cmdKlantnummer;
            //string sqlKlantnummer;
            //string sqlLaatseVerhuur;

            //sqlLaatseVerhuur = "SELECT tblverhuringen.VerhuurID FROM tblverhuringen\r\nORDER BY 1 DESC LIMIT 1 ";
            //sqlKlantnummer = " SELECT tblklanten.KlantID FROM tblklanten\r\nORDER BY 1 DESC LIMIT 1";

            //cmdLaatseVerhuur = new MySqlCommand(sqlLaatseVerhuur, cnnConnectie);
            //cmdKlantnummer = new MySqlCommand(sqlKlantnummer, cnnConnectie);

            ////verhuurID aanmaken
            //int OudVerhuurID;
            //int nieuwverhuurID;
            //int oudKlantID;
            //int nieuwKlantid;

            //cnnConnectie.Open();
            //OudVerhuurID = Convert.ToInt32(cmdLaatseVerhuur.ExecuteScalar());
            //oudKlantID = Convert.ToInt32(cmdKlantnummer.ExecuteScalar());
            //cnnConnectie.Close();

            //nieuwverhuurID = OudVerhuurID++;
            //nieuwKlantid = oudKlantID + 10;

            //wegschrijven in variables class
            //Variables.verhuurID = OudVerhuurID + 1;

            //adres samenvoegen
            string volledigadres = Variables.straat + " " + Variables.huisnummer + " , " + Variables.postcode + " " + Variables.gemeente;

            /////////////////wegschrijven in TBLKLANTEN
            MySqlCommand cmdKlantWegschrijven;
            string sqlKlantWegschrijven;
            sqlKlantWegschrijven = "INSERT INTO tblklanten(tblklanten.Voornaam, tblklanten.Achternaam, tblklanten.KlantAdres, tblklanten.KlantTelnr, tblklanten.KlantEmail, tblklanten.BTWNummer)\r\nVALUES(@voornaam , @achternaam , @adres , @telnr , @email , @btwnummer)";
            cmdKlantWegschrijven = new MySqlCommand(sqlKlantWegschrijven, cnnConnectie);

            //MySqlParameter parKlantID = cmdKlantWegschrijven.Parameters.Add("@klantid", MySqlDbType.VarChar);
            MySqlParameter parNaam = cmdKlantWegschrijven.Parameters.Add("@voornaam", MySqlDbType.VarChar);
            MySqlParameter parAchternaam = cmdKlantWegschrijven.Parameters.Add("@achternaam", MySqlDbType.VarChar);
            MySqlParameter parAdres = cmdKlantWegschrijven.Parameters.Add("@adres", MySqlDbType.VarChar);
            MySqlParameter parTelnr = cmdKlantWegschrijven.Parameters.Add("@telnr", MySqlDbType.VarChar);
            MySqlParameter parEmail = cmdKlantWegschrijven.Parameters.Add("@email", MySqlDbType.VarChar);
            MySqlParameter parBtwnr = cmdKlantWegschrijven.Parameters.Add("@btwnummer", MySqlDbType.VarChar);

            //parKlantID.Value = nieuwKlantid;
            parNaam.Value = Variables.Naam;
            parAchternaam.Value = Variables.Achternaam;
            parAdres.Value = volledigadres;
            parTelnr.Value = Variables.telefoonnr;
            parEmail.Value = Variables.email ;
            parBtwnr.Value = "/";

            cnnConnectie.Open();
            cmdKlantWegschrijven.ExecuteNonQuery();
            cnnConnectie.Close();

            //klantnummer opvragen uit database
            MySqlCommand cmdKlantid;
            string sqlKlantid = "SELECT tblklanten.KlantID FROM tblklanten ORDER BY 1 DESC LIMIT 1 ";
            cmdKlantid = new MySqlCommand(sqlKlantid, cnnConnectie);
            string klantid;
            cnnConnectie.Open() ;
            klantid = Convert.ToString(cmdKlantid.ExecuteScalar());
            cnnConnectie.Close() ;


            //////////////wegschrijven in TBLVERHURINGEN
            string sqltblVerhuur;
            MySqlCommand cmdtblVerhuur;
            sqltblVerhuur = "INSERT INTO tblverhuringen(tblverhuringen.KlantID, tblverhuringen.BeginDatum, tblverhuringen.EindDatum, tblverhuringen.Betaling, tblverhuringen.LeveringOphalen, tblverhuringen.BeginUur) VALUES(@klantnr, @begindatum, @einddatum, @betaling, @leverenophalen, @uur)"; 
            cmdtblVerhuur = new MySqlCommand(sqltblVerhuur, cnnConnectie);


            
            MySqlParameter parKlant = cmdtblVerhuur.Parameters.Add("@klantnr", MySqlDbType.VarChar);
            MySqlParameter parBegindatum = cmdtblVerhuur.Parameters.Add("@begindatum", MySqlDbType.Datetime);
            MySqlParameter parEinddatum = cmdtblVerhuur.Parameters.Add("@einddatum", MySqlDbType.Datetime);
            MySqlParameter parBetaling = cmdtblVerhuur.Parameters.Add("@betaling", MySqlDbType.VarChar);
            MySqlParameter parLeverenOphalen = cmdtblVerhuur.Parameters.Add("@leverenophalen", MySqlDbType.String);
            MySqlParameter parBeginUur = cmdtblVerhuur.Parameters.Add("@uur", MySqlDbType.VarChar);

            parKlant.Value = klantid;
            parBegindatum.Value = Variables.begindatum;
            parEinddatum.Value = Variables.einddatum;
            parBetaling.Value = Variables.betaalwijze;
            parLeverenOphalen.Value = Variables.leverenophalen;
            parBeginUur.Value = Variables.tijd;

            cnnConnectie.Open();
            cmdtblVerhuur.ExecuteNonQuery();
            cnnConnectie.Close();


            //verhuurid halen uit database
            MySqlCommand cmdVerhuurid;
            string sqlVerhuurid = "SELECT tblverhuringen.VerhuurID FROM tblverhuringen ORDER BY 1 DESC LIMIT 1";
            cmdVerhuurid = new MySqlCommand(sqlVerhuurid, cnnConnectie);

            cnnConnectie.Open();
            string verhuurID = Convert.ToString(cmdVerhuurid.ExecuteScalar());
            cnnConnectie.Close();

            Variables.verhuurID = Convert.ToInt32(verhuurID);

            ////////////////wegschrijven in TBLARTIKELSVERHUUR
            //uit datagrid artikelID's opvragen en telkens wegschrijven in tabel tblartikelfactuur
            int teller;
            
            for (teller = 0; teller < Variables.dtblBestelling.Rows.Count; teller++)
            {
                MySqlCommand cmdWegschrijven;
                string sqlWegschrijven;
                sqlWegschrijven = "INSERT INTO tblartikelsverhuur(tblartikelsverhuur.VerhuurID, tblartikelsverhuur.Artikels, tblartikelsverhuur.Hoeveelheid)\r\nVALUES( @verhuurid, @artikel, @aantal)";
                cmdWegschrijven = new MySqlCommand(sqlWegschrijven, cnnConnectie);
                MySqlParameter ParVerhuurID = cmdWegschrijven.Parameters.Add("@verhuurid", MySqlDbType.Int64);
                MySqlParameter ParArtikelID = cmdWegschrijven.Parameters.Add("@artikel", MySqlDbType.String);
                MySqlParameter ParHoeveelheid = cmdWegschrijven.Parameters.Add("@aantal", MySqlDbType.Int64);


                ParVerhuurID.Value = verhuurID;
                ParArtikelID.Value = Variables.dtblBestelling.Rows[teller][0].ToString();
                ParHoeveelheid.Value = Variables.dtblBestelling.Rows[teller][1].ToString();

                cnnConnectie.Open();
                cmdWegschrijven.ExecuteNonQuery();
                cnnConnectie.Close();

             
            }


            //gebruiker doorsturen naar besteloverzicht
            Session["type"] = hiddenType.Value;
            Response.Redirect("BestelOverzicht.aspx");
        }
    }
}