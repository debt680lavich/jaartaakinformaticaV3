using MySql.Data.MySqlClient;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Aanmelden
{
    public partial class Instellingen : Page
    {
        // ── Pas de connection string aan in Web.config ──
        string connectiestring = "server=localhost;user id=root; database=springkastelen";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlSuccess.Visible = false;
                pnlError.Visible = false;
            }
        }

        protected void btnOpslaan_Click(object sender, EventArgs e)
        {
            pnlSuccess.Visible = false;
            pnlError.Visible = false;

            // ── Validatie ──
            string naam = txtArtikelNaam.Text.Trim();
            string prijsTekst = txtArtikelPrijs.Text.Trim().Replace(",", ".");
            string leeftijdTekst = txtMinimumleeftijd.Text.Trim();
            string categorie = txtCategorieID.Text.Trim();
            string voorraadTekst = txtVoorraad.Text.Trim();
            string fotoTekst = txtFoto.Text.Trim();

            if (string.IsNullOrEmpty(naam))
            {
                lblError.Text = "Vul een artikelnaam in.";
                pnlError.Visible = true;
                return;
            }

            if (!decimal.TryParse(prijsTekst,
                    System.Globalization.NumberStyles.Number,
                    System.Globalization.CultureInfo.InvariantCulture,
                    out decimal prijs))
            {
                lblError.Text = "Ongeldige prijs. Gebruik een decimaal getal (bv. 125.50).";
                pnlError.Visible = true;
                return;
            }

            if (!int.TryParse(voorraadTekst, out int voorraad))
            {
                lblError.Text = "Ongeldige voorraad. Vul een geheel getal in.";
                pnlError.Visible = true;
                return;
            }

            // Minimumleeftijd is optioneel
            string minimumleeftijd = string.IsNullOrEmpty(leeftijdTekst) ? null : leeftijdTekst;

           

            // ── Database INSERT ──
            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectiestring))
                {
                    conn.Open();
                    string stringsql = @"
                        INSERT INTO tblartikels
                            (ArtikelNaam, ArtikelPrijs, Minimumleeftijd,
                             CategorieID, Voorraad, OphalenMogelijk, Foto)
                        VALUES
                            (@Naam, @Prijs, @Leeftijd,
                             @Categorie, @Voorraad, @Ophalen, @Foto)";

                    using (MySqlCommand cmd = new MySqlCommand(stringsql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Naam", naam);
                        cmd.Parameters.AddWithValue("@Prijs", prijs);
                        cmd.Parameters.AddWithValue("@Leeftijd",
                            (object)minimumleeftijd ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@Categorie",
                            string.IsNullOrEmpty(categorie) ? (object)DBNull.Value : categorie);
                        cmd.Parameters.AddWithValue("@Voorraad", voorraad);
                        cmd.Parameters.AddWithValue("@Ophalen", "0");
                        cmd.Parameters.AddWithValue("@Foto", fotoTekst);

                        cmd.ExecuteNonQuery();
                    }
                }

                lblSuccess.Text = $"Artikel is succesvol toegevoegd!";
                pnlSuccess.Visible = true;
                ResetForm();
            }
            catch (Exception ex)
            {
                lblError.Text = "Databasefout: " + ex.Message;
                pnlError.Visible = true;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ResetForm();
            pnlSuccess.Visible = false;
            pnlError.Visible = false;
        }

        private void ResetForm()
        {
            txtArtikelNaam.Text = string.Empty;
            txtArtikelPrijs.Text = string.Empty;
            txtMinimumleeftijd.Text = string.Empty;
            txtCategorieID.Text = string.Empty;
            txtVoorraad.Text = string.Empty;
        }

        protected void txtArtikelNaam_TextChanged(object sender, EventArgs e)
        {

        }
    }
}