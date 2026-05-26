using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO.Pipelines;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZstdSharp.Unsafe;
using System.Globalization;

namespace Aanmelden
{
    public partial class Reserveren : System.Web.UI.Page
    {
        //declaratie class niveau
        MySqlConnection cnnConnectie;
        string connectiestring = "server=localhost;user id=root; database=springkastelen";

        int totaaldagen;
        TimeSpan aantaldagen;

        protected void Page_Load(object sender, EventArgs e)
        {
            Variables.totaalbrutobedrag = 0;
            cnnConnectie = new MySqlConnection(connectiestring);

            //disable de datums in het verleden en zorg dat de gebruiker minimaal 2 dagen 
            //van te voren moet reserveren en maximaal zoveel in de toekomst
            DateTime minVerhuurDatum = DateTime.Now.AddDays(2);
            DateTime maxVerhuurDatum = DateTime.Now.AddMonths(8);

            txtStartDatum.Attributes["min"] = minVerhuurDatum.ToString("yyyy-MM-dd");
            txtEindDatum.Attributes["min"] = minVerhuurDatum.ToString("yyyy-MM-dd");

            txtStartDatum.Attributes["max"] = maxVerhuurDatum.ToString("yyyy-MM-dd");
            txtEindDatum.Attributes["max"] = maxVerhuurDatum.ToString("yyyy-MM-dd");
        }
        //controle op dat gebruiker wel degelijk datum heeft ingegeven
        bool startdatm = false;
        bool enddatm = false;

        protected void txtStartdatum_Changed(object sender, EventArgs e)
        {
            ControleerDatums();
        }

        protected void txtEinddatum_Changed(object sender, EventArgs e)
        {
            ControleerDatums();
        }

        private void ControleerDatums()
        {
            DateTime startDatum;
            DateTime eindDatum;

            if (DateTime.TryParse(txtStartDatum.Text, out startDatum) &&
                DateTime.TryParse(txtEindDatum.Text, out eindDatum))
            {
                if (eindDatum < startDatum)
                {
                    txtEindDatum.Text = startDatum.ToString("yyyy-MM-dd");
                }
                else
                {
                    lblFoutmelding.Text = "";
                }
            }
        }


        protected void btnZoek_Click(object sender, EventArgs e)
        {
            string startdatm = txtStartDatum.Text;
            string enddatum = txtEindDatum.Text;
            DateTime datum;

            if (!string.IsNullOrWhiteSpace(startdatm) && DateTime.TryParse(startdatm, out datum) && !string.IsNullOrWhiteSpace(enddatum) && DateTime.TryParse(enddatum, out datum))
            {
                // geldige datum
                txtStartDatum.Enabled = false;
                txtEindDatum.Enabled = false;
                btnZoek.Visible = false;
                DateTime startDatum = Convert.ToDateTime(txtStartDatum.Text);
                DateTime eindDatum = Convert.ToDateTime(txtEindDatum.Text);

                // TODO
                // Hier kan jij checken welke artikelen beschikbaar zijn
                MySqlCommand cmdBeschikbareItems; ;
                string sqlBeschikbareItems = "SELECT\r\n    tblartikels.ArtikelID,\r\n    tblartikels.ArtikelNaam,\r\n    tblartikels.ArtikelPrijs,\r\n    tblartikels.Foto,\r\n    tblartikels.Voorraad -\r\n    IFNULL(\r\n        (\r\n            SELECT SUM(tblartikelsverhuur.Hoeveelheid)\r\n            FROM tblartikelsverhuur\r\n            INNER JOIN tblverhuringen\r\n                ON tblartikelsverhuur.VerhuurID = tblverhuringen.VerhuurID\r\n            WHERE tblartikelsverhuur.Artikels = tblartikels.ArtikelNaam\r\n            AND tblverhuringen.BeginDatum <= '2025-10-02'\r\n            AND tblverhuringen.EindDatum >= '2025-10-03'\r\n        ),0\r\n    ) AS BeschikbaarAantal\r\n\r\nFROM tblartikels;";
                cmdBeschikbareItems = new MySqlCommand(sqlBeschikbareItems, cnnConnectie);
                MySqlParameter parBegindatum = cmdBeschikbareItems.Parameters.Add("@begindatum", MySqlDbType.Date);
                MySqlParameter parEinddatum = cmdBeschikbareItems.Parameters.Add("@einddatum", MySqlDbType.Date);

                parBegindatum.Value = startDatum;
                parEinddatum.Value = eindDatum;

                DataTable dtblArtikels = new DataTable();

                dtblArtikels.Columns.Add("Naam");
                dtblArtikels.Columns.Add("Foto");
                dtblArtikels.Columns.Add("Prijs");
                dtblArtikels.Columns.Add("Voorraad");


                cnnConnectie.Open();
                MySqlDataReader dtrGegevens = cmdBeschikbareItems.ExecuteReader();
                while (dtrGegevens.Read())
                {
                    string ArtikelNaam = dtrGegevens["ArtikelNaam"].ToString();
                    string ArtikelFoto = dtrGegevens["Foto"].ToString();

                    decimal prijs = Convert.ToDecimal(dtrGegevens["ArtikelPrijs"]);
                    string ArtikelPrijs = "€ " + prijs.ToString("0.00");

                    string ArtikelVoorraad = dtrGegevens["BeschikbaarAantal"].ToString();

                    // Voeg een nieuwe rij toe aan dtblArtikels
                    dtblArtikels.Rows.Add(ArtikelNaam, ArtikelFoto, ArtikelPrijs, ArtikelVoorraad);
                }

                rptArtikelen.DataSource = dtblArtikels;
                rptArtikelen.DataBind();

                pnlArtikelen.Visible = true;

                /////tellen hoeveel dagen de reservering is
                DateTime start = DateTime.ParseExact(txtStartDatum.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                DateTime eind = DateTime.ParseExact(txtEindDatum.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);


                totaaldagen = (eind - start).Days + 1;
                Session["totaaldagen"] = totaaldagen;
            }
         
        
            else
            {
                Response.Redirect("Reserveren.aspx");
                // foutmelding tonen
            }
            
            
        }

        protected void btnPlus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            TextBox txtAantal = (TextBox)item.FindControl("txtAantal");
            HiddenField hfVoorraad = (HiddenField)item.FindControl("hfVoorraad");

            int aantal = Convert.ToInt32(txtAantal.Text);
            int voorraad = Convert.ToInt32(hfVoorraad.Value);

            if (aantal < voorraad)
                txtAantal.Text = (aantal + 1).ToString();

            UpdateOverzicht();
        }
        protected void btnMin_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            TextBox txtAantal = (TextBox)item.FindControl("txtAantal");

            int aantal = Convert.ToInt32(txtAantal.Text);

            if (aantal > 0)
                txtAantal.Text = (aantal - 1).ToString();

            UpdateOverzicht();
        }
        protected void txtAantal_TextChanged(object sender, EventArgs e)
        {
            UpdateOverzicht();
        }
        private void UpdateOverzicht()
        {
            int totaaldagen = Convert.ToInt32(Session["totaaldagen"]);
            DataTable overzicht = new DataTable();

            overzicht.Columns.Add("Naam");
            overzicht.Columns.Add("Aantal");
            overzicht.Columns.Add("Totaalprijs");

            foreach (RepeaterItem item in rptArtikelen.Items)
            {
                TextBox txtAantal = (TextBox)item.FindControl("txtAantal");
                Literal litNaam = (Literal)item.FindControl("litNaam");
                Literal litPrijs = (Literal)item.FindControl("litPrijs");

                int aantal = Convert.ToInt32(txtAantal.Text);
                decimal totaalprijs = 0;

                decimal prijs = Convert.ToDecimal(litPrijs.Text.Replace("€", "").Trim());
                totaalprijs = aantal * prijs * totaaldagen;

                if (aantal > 0)
                {
                    overzicht.Rows.Add(litNaam.Text, aantal, totaalprijs);
                }
            }

            gvOverzicht.DataSource = overzicht;
            gvOverzicht.DataBind();
        }


        protected void btnVerder_Click(object sender, EventArgs e)
        {
            DataTable winkelwagen = new DataTable();
            int totaaldagen = Convert.ToInt32(Session["totaaldagen"]);

            winkelwagen.Columns.Add("Artikel");
            winkelwagen.Columns.Add("Aantal", typeof(int));
            winkelwagen.Columns.Add("Prijs", typeof(decimal));

            foreach (RepeaterItem item in rptArtikelen.Items)
            {
                TextBox txtAantal = (TextBox)item.FindControl("txtAantal");
                Literal litNaam = (Literal)item.FindControl("litNaam");
                Literal litPrijs = (Literal)item.FindControl("litPrijs");

                int aantal = Convert.ToInt32(txtAantal.Text);

                if (aantal > 0)
                {
                    decimal prijs = Convert.ToDecimal(litPrijs.Text.Replace("€", "").Trim());
                    decimal totaalPrijs = prijs * aantal * totaaldagen;

                    winkelwagen.Rows.Add(litNaam.Text, aantal, totaalPrijs);
                    Variables.totaalbrutobedrag += totaalPrijs;
                }

            }


            // DataTable opslaan in Session (geheugen)
            Session["winkelwagen"] = winkelwagen;

            if(winkelwagen.Rows.Count >= 1)
            {
                Variables.begindatum = txtStartDatum.Text;
                Variables.einddatum = txtEindDatum.Text;
                Response.Redirect("Checkout.aspx");
            }
            else
            {
                lblFoutmelding.Text = "FOUT: Kies eerst een artikel voor u verder gaat";
            }
            
        }

    }
}