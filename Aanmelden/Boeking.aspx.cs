using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aanmelden
{
    public partial class Boeking : System.Web.UI.Page
    {
        MySqlConnection cnnConnectie;
        string connectiestring = "server=localhost;user id=root; database=springkastelen";
 
        protected void Page_Load(object sender, EventArgs e)
        {
            cnnConnectie = new MySqlConnection(connectiestring);

            if (!Page.IsPostBack)
            {
                //ddl Artikels vullen
                MySqlCommand cmdArtikels;
                string sqlArtikels;
                sqlArtikels = " SELECT tblartikels.ArtikelNaam FROM tblartikels\r\nORDER BY tblartikels.ArtikelNaam";

               
                cmdArtikels = new MySqlCommand(sqlArtikels, cnnConnectie);

                cnnConnectie.Open();
                MySqlDataReader dtrArtikels = cmdArtikels.ExecuteReader();
                ddlArtikels.Items.Add("Kies Artikel");
                while (dtrArtikels.Read())
                {
                    ddlArtikels.Items.Add(dtrArtikels["ArtikelNaam"].ToString());
                }
                cnnConnectie.Close();

                if (Variables.paginaterug == true)
                {
                    //alles terug leegmaken op pagina
                }
                else
                {
                    Variables.dtblBestelling.Columns.Add("Artikel nr");
                    Variables.dtblBestelling.Columns.Add("Artikel");
                    Variables.dtblBestelling.Columns.Add("Aantal");
                    Variables.dtblBestelling.Columns.Add("Prijs / dag");
                    Variables.dtblBestelling.Columns.Add("Totaalprijs");

                    ddlAantal.Items.Add("kies aantal");
                }

                


                //disable de datums in het verleden en zorg dat de gebruiker minimaal 2 dagen 
                //van te voren moet reserveren
                DateTime minVerhuurDatum = DateTime.Now.AddDays(2);
                DateTime maxVerhuurDatum = DateTime.Now.AddDays(10);

                txtStart.Attributes["min"] = minVerhuurDatum.ToString("yyyy-MM-dd");
                txtEinde.Attributes["min"] = minVerhuurDatum.ToString("yyyy-MM-dd");

                txtStart.Attributes["max"] = maxVerhuurDatum.ToString("yyyy-MM-dd");
                txtEinde.Attributes["max"] = maxVerhuurDatum.ToString("yyyy-MM-dd");

            }


        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {

        }

        protected void ddlArtikels_SelectedIndexChanged(object sender, EventArgs e)
        {
                //ddlAantal vullen met het maximale aantal dat beschikbaar is
                MySqlCommand cmdBeschikbareAantal;
                string sqlBeschikbareAantal;
                sqlBeschikbareAantal = "SELECT tblartikels.Voorraad\r\nWHERE tblartikels.ArtikelNaam = @naam";
                cmdBeschikbareAantal = new MySqlCommand(sqlBeschikbareAantal, cnnConnectie);
                //MySqlParameter parBegindatum = cmdBeschikbareAantal.Parameters.Add("@begindatum", MySqlDbType.Date);
                //MySqlParameter parEinddatum = cmdBeschikbareAantal.Parameters.Add("@einddatum", MySqlDbType.Date);
                MySqlParameter parArtikel = cmdBeschikbareAantal.Parameters.Add("@naam", MySqlDbType.String);

                //parBegindatum.Value = Convert.ToDateTime(txtStart.Text);
                //parEinddatum.Value = Convert.ToDateTime(txtEinde.Text);
                parArtikel.Value = ddlArtikels.SelectedItem.ToString();

                cnnConnectie.Open();
                ddlAantal.Items.Add(cmdBeschikbareAantal.ExecuteScalar().ToString());
                cnnConnectie.Close();
        }

        protected void button1_Click(object sender, EventArgs e)
        {
            //datum selectie voor gebruiker blokkeren
            txtStart.Enabled = false;
            txtEinde.Enabled = false;

            //gridview vullen met gekozen artikels en aantal met de prijs
            //totale prijs berekenen voor de gekozen datums

            Variables.geselecteerdArtikel = ddlArtikels.SelectedItem.ToString() ;
            decimal ppe = 0;
            decimal totaalprijs = 0;
            int aantal;
            string artikelID = null;

            MySqlCommand cmdPrijs;
            string sqlPrijs;
            
            sqlPrijs = " SELECT tblartikels.ArtikelPrijs, tblartikels.ArtikelID FROM tblartikels \r\nWHERE tblartikels.ArtikelNaam = @artikel";
            cmdPrijs = new MySqlCommand(sqlPrijs, cnnConnectie);

            MySqlParameter parArtikel = cmdPrijs.Parameters.Add("artikel", MySqlDbType.String);
            parArtikel.Value = Variables.geselecteerdArtikel;

            cnnConnectie.Open() ;
            MySqlDataReader dtrGegevens = default(MySqlDataReader);
            dtrGegevens = cmdPrijs.ExecuteReader();
            while(dtrGegevens.Read())
            {
                ppe = Convert.ToDecimal(dtrGegevens["ArtikelPrijs"]);
                artikelID = Convert.ToString(dtrGegevens["ArtikelID"]);
            }

            cnnConnectie.Close();

            aantal = Convert.ToInt16(txtAantal.Text); 

            // tellen hoeveel dagen de verhuring duurt
            TimeSpan aantaldagen;
            aantaldagen = Convert.ToDateTime(txtEinde.Text) - Convert.ToDateTime(txtStart.Text);
            int totaaldagen = aantaldagen.Days + 1;
            if (aantaldagen.Days >= 1 )
            {
                totaalprijs = (aantal * ppe) * totaaldagen;
                lblfoutmelding.Text = Convert.ToString(totaaldagen);
            }
            else
            {
                totaalprijs = aantal * ppe;
            }

            //datatable aanmaken
            //    ((((als artikel al in datagrid zit --> aantal verhogen + prijs verhogen))))
            int teller;
            bool controle = false;
            int oudaantal;

            if (Variables.aantalrijen >= 1)
            {
                for (teller = 0; teller < Variables.aantalrijen; teller++)
                {
                    if (grvArtikels.Rows[teller].Cells[1].Text.ToString() == Variables.geselecteerdArtikel)
                    {
                        oudaantal = Convert.ToInt16(grvArtikels.Rows[teller].Cells[2].Text);
                        grvArtikels.Rows[teller].Cells[2].Text = (oudaantal + aantal).ToString();
                        int totaal = oudaantal + aantal;

                        grvArtikels.Rows[teller].Cells[4].Text = Convert.ToString(totaal * ppe);
                        Variables.dtRij[2] = totaal;
                        controle = true;
                    }
                }
            }

                if(controle == false)
                {
                    //datatable inhoud geven
                    Variables.dtRij = Variables.dtblBestelling.NewRow();
                    Variables.dtRij[0] = artikelID;
                    Variables.dtRij[1] = Variables.geselecteerdArtikel;
                    Variables.dtRij[2] = aantal.ToString();
                    Variables.dtRij[3] = ppe.ToString("F2");
                    Variables.dtRij[4] = totaalprijs.ToString("F2");

                    Variables.dtblBestelling.Rows.Add(Variables.dtRij);
                    Variables.aantalrijen++;
                }
            

            grvArtikels.DataSource = Variables.dtblBestelling;
            grvArtikels.DataBind();

            //totaal brutobedrag berekenene
            Variables.totaalbrutobedrag += totaalprijs;
            lbltotaalprijs.Text = "€ " + Variables.totaalbrutobedrag.ToString("F2");

        }

     

        protected void Button2_Click(object sender, EventArgs e)
        {
            if(Variables.aantalrijen >= 1)
            {
                Variables.begindatum = txtStart.Text;
                Variables.einddatum = txtEinde.Text;
                Variables.paginaterug = false;
                Response.Redirect("Checkout.aspx");
            }
            else
            {
                //message box tonen ??
                lblfoutmelding.Text = "Kies eerst een product";
            }
        }

        protected void txtStart_TextChanged(object sender, EventArgs e)
        {

        }
    }
}