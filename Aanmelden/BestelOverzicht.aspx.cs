using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aanmelden
{
    public partial class BestelOverzicht : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //gridview vullen met alle gegevens
            DataTable winkelwagen = (DataTable)Session["winkelwagen"];

            grvArtikels.DataSource = winkelwagen;
            grvArtikels.DataBind();

            //alle gegevens weergeven

            lblNaam.Text = Variables.Naam;
            lblAchternaam.Text = Variables.Achternaam;
            lblEmail.Text = Variables.email;
            lblTelefoon.Text = Variables.telefoonnr;

            lblStraat.Text = Variables.straat;
            lblNummer.Text = Variables.huisnummer;
            lblPostcode.Text = Variables.postcode;
            lblGemeente.Text = Variables.gemeente;

            lblOphalenLeveren.Text = Variables.leverenophalen;
            lblDatum.Text = Variables.begindatum;
            lbleinddatum.Text = Variables.einddatum;
            lblUur.Text = Variables.tijd;

            lblVerhuurID.Text = "Verhuurnummer: " + Convert.ToString(Variables.verhuurID);
            lblTotaalprijs.Text = Variables.totaalbrutobedrag.ToString("F2");

            if(Variables.leverenophalen == "Ophalen")
            {
                lblBegindatumTEKST.Text = "Ophalen:";
                lblEinddatumtekst.Text = "Terugbrengen:";
            }
            else
            {
                lblBegindatumTEKST.Text = "Leverdatum:";
                lblEinddatumtekst.Text = "Retourdatum:";
            }

        }

        protected void grvArtikels_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}