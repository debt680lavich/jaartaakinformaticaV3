using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI;

namespace Aanmelden
{
    public partial class AdminPanelOverzicht : System.Web.UI.Page
    {
        MySqlConnection cnnConnectie;
        string connectiestring;

        protected void Page_Load(object sender, EventArgs e)
        {
            connectiestring = "server=localhost;user id=root; database=springkastelen";
            cnnConnectie = new MySqlConnection(connectiestring);

            if (!IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                {
                    pnlZoeken.Visible = false;
                    LaadVerhuurDetails(Request.QueryString["ID"].ToString());
                }
                else
                {
                    pnlZoeken.Visible = true;
                }
            }
        }

        protected void btnZoeken_Click(object sender, EventArgs e)
        {
            string verhuurID = txtVerhuurID.Text.Trim();
            if (!string.IsNullOrEmpty(verhuurID))
            {
                pnlZoeken.Visible = false;
                LaadVerhuurDetails(verhuurID);
            }
        }

        protected void LaadVerhuurDetails(string verhuurID)
        {
            lblVerhuurID.Text = "" + verhuurID;

            // Gegevens uit tblVerhuringen 
            string klantID = "";

            string sqlVerhuringen = @"SELECT KlantID, BeginDatum, EindDatum, LeveringOphalen, 
Betaling, BeginUur FROM tblverhuringen 
WHERE VerhuurID = @verhuurid";

            MySqlCommand cmdVerhuringen = new MySqlCommand(sqlVerhuringen, cnnConnectie);
            cmdVerhuringen.Parameters.AddWithValue("@verhuurid", verhuurID);
            


            cnnConnectie.Open();
            MySqlDataReader dtr = cmdVerhuringen.ExecuteReader();
            int aantalDagen = 1;

            if (dtr.Read())
            {
                klantID = dtr["KlantID"].ToString();
                string beginuur = dtr["BeginUur"].ToString();

                // Datum en uur splitsen
                if (DateTime.TryParse(dtr["BeginDatum"].ToString(), out DateTime beginDatum))
                {
                    lblBeginDatum.Text = beginDatum.ToString("dd MMMM yyyy");
                    lblBeginUur.Text = beginuur.ToString();
                }

                if (DateTime.TryParse(dtr["EindDatum"].ToString(), out DateTime eindDatum))
                {
                    lblEindDatum.Text = eindDatum.ToString("dd MMMM yyyy");
                    aantalDagen = (int)(eindDatum - beginDatum).TotalDays + 1;
                }



                // Levering of Ophalen actief zetten
                string leveringOphalen = dtr["LeveringOphalen"].ToString().ToLower();
                if (leveringOphalen == "leveren")
                {
                    spanLevering.Attributes["class"] = "toggle-option active";
                    spanOphalen.Attributes["class"] = "toggle-option";
                }
                else
                {
                    spanLevering.Attributes["class"] = "toggle-option";
                    spanOphalen.Attributes["class"] = "toggle-option active";
                }

                lblOpmerkingen.Text = "betaalwijze: " + dtr["betaling"].ToString();
            }

            dtr.Close();
            cnnConnectie.Close();

            // tblKlanten
            string sqlKlanten = @"SELECT Voornaam, Achternaam, KlantAdres, KlantTelnr, KlantEmail
                                  FROM tblklanten
                                  WHERE KlantID = @klantid";

            MySqlCommand cmdKlanten = new MySqlCommand(sqlKlanten, cnnConnectie);
            cmdKlanten.Parameters.AddWithValue("@klantid", klantID);

            cnnConnectie.Open();
            MySqlDataReader dtr2 = cmdKlanten.ExecuteReader();

            if (dtr2.Read())
            {
                lblVoornaam.Text = dtr2["Voornaam"].ToString();
                lblAchternaam.Text = dtr2["Achternaam"].ToString();
                lblEmail.Text = dtr2["KlantEmail"].ToString();
                lblTelefoon.Text = dtr2["KlantTelnr"].ToString();
                lblAdres.Text = dtr2["KlantAdres"].ToString();
            }

            dtr2.Close();
            cnnConnectie.Close();

            //ARtikels tabel vullen
            string sqlArtikels = "SELECT tblartikelsverhuur.Artikels, tblartikelsverhuur.Hoeveelheid FROM tblartikelsverhuur WHERE tblartikelsverhuur.VerhuurID = @verhuurid";

            MySqlCommand cmdArtikels = new MySqlCommand(sqlArtikels, cnnConnectie);
            cmdArtikels.Parameters.AddWithValue("@verhuurid", verhuurID);

            DataTable dtArtikels = new DataTable();
            dtArtikels.Columns.Add("Artikel");
            dtArtikels.Columns.Add("Aantal");
            dtArtikels.Columns.Add("Eenheidsprijs");
            dtArtikels.Columns.Add("Subtotaal");

            cnnConnectie.Open();
            MySqlDataReader dtr3 = cmdArtikels.ExecuteReader();

            // Sla artikels tijdelijk op, want we kunnen geen nieuwe query uitvoeren
            // terwijl de DataReader nog open is
            DataTable dtTijdelijk = new DataTable();
            dtTijdelijk.Columns.Add("Artikels");
            dtTijdelijk.Columns.Add("Hoeveelheid");

            while (dtr3.Read())
            {
                dtTijdelijk.Rows.Add(
                    dtr3["Artikels"].ToString(),
                    dtr3["Hoeveelheid"].ToString()
                );
            }

            dtr3.Close();
            cnnConnectie.Close();

            //prijs per artikel ophalen
            decimal totaal = 0;

            foreach (DataRow rij in dtTijdelijk.Rows)
            {
                string artikelNaam = rij["Artikels"].ToString();
                int aantal = Convert.ToInt32(rij["Hoeveelheid"]);
                decimal eenheidsprijs = 0;

                // Prijs ophalen uit tblartikels
                string sqlPrijs = "SELECT tblartikels.ArtikelPrijs FROM tblartikels WHERE tblartikels.ArtikelNaam = @naam";
                MySqlCommand cmdPrijs = new MySqlCommand(sqlPrijs, cnnConnectie);
                cmdPrijs.Parameters.AddWithValue("@naam", artikelNaam);

                cnnConnectie.Open();
                object prijsResult = cmdPrijs.ExecuteScalar();
                cnnConnectie.Close();

                if (prijsResult != null && prijsResult != DBNull.Value)
                {
                    eenheidsprijs = Convert.ToDecimal(prijsResult);
                }

                decimal subtotaal = aantal * eenheidsprijs;
                totaal += subtotaal * aantalDagen;

                dtArtikels.Rows.Add(
                    artikelNaam,
                    aantal,
                    "€ " + eenheidsprijs.ToString("F2"),
                    "€ " + subtotaal.ToString("F2")
                );
            }

            tblArtikels.DataSource = dtArtikels;
            tblArtikels.DataBind();

            lblTotaal.Text = "€ " + totaal.ToString("F2");
        }
    }
}