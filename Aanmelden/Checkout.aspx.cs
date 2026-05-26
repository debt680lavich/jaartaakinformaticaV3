using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MySql.Data.MySqlClient;
using System.Web.UI.WebControls.WebParts;
using System.Data;

namespace Aanmelden
{
    public partial class Checkout : System.Web.UI.Page
    {

       
        bool controle;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable winkelwagen = (DataTable)Session["winkelwagen"];

            //bool om te controleren of alle velden zijn ingevuld
            controle = false;
          

            //gridview vullen met alle gegevens

            GridView1.DataSource = winkelwagen;
            GridView1.DataBind();

            //totaalprijs weergeven + controleren of het totaal niet € 0 is
            if (Variables.totaalbrutobedrag == 0)
            {
                Response.Redirect("Reserveren.aspx");
            }
            else
            {
                lbltotaalprijs.Text = "€ " + Variables.totaalbrutobedrag.ToString("F2");

            }

        }

       
        protected void btnBereken_Click(object sender, EventArgs e)
        {
            
        }

        protected void optLeveren_(object sender, EventArgs e)
        {

        }

        protected void btnBestel_Click(object sender, EventArgs e)
        {
            // controle gewenst uur
            if (ddlUur.SelectedIndex == 0)
            {
                lblfoutmelding.Text = "Kies een gewenst uur.";
            }
            else
            {
                if (hiddenType.Value == "optLeveren")
                {
                    if (string.IsNullOrWhiteSpace(txtStraat.Text) ||
                        string.IsNullOrWhiteSpace(txtNummer.Text) ||
                        string.IsNullOrWhiteSpace(txtPostcode.Text) ||
                        string.IsNullOrWhiteSpace(txtGemeente.Text))
                    {
                        lblfoutmelding.Text = "Vul alle adresgegevens in.";
                    }
                    else
                    {
                        Variables.leverenophalen = "Leveren";
                        Variables.tijd = ddlUur.SelectedItem.ToString();
                        Variables.straat = txtStraat.Text;
                        Variables.huisnummer = txtNummer.Text;
                        Variables.postcode = txtPostcode.Text;
                        Variables.gemeente = txtGemeente.Text;

                        Response.Redirect("Bestelgegevens.aspx");
                    }
                }
                else
                {
                    Variables.leverenophalen = "Ophalen";
                    Variables.tijd = ddlUur.SelectedItem.ToString();

                    Response.Redirect("Bestelgegevens.aspx");

                }
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

        protected void hiddenType_ValueChanged(object sender, EventArgs e)
        {

        }
    }
}
