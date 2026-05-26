using MySql.Data.MySqlClient;
using Org.BouncyCastle.Math;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace Aanmelden
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Variables.adminaangemeld == false)
            {
                Response.Redirect("admin.aspx");
                return;
            }

            // Altijd laden, ook bij postback
            LaadVerhuringen();
        }

        private void LaadVerhuringen()
        {
            DataTable dtblVerhuringen = new DataTable();
            dtblVerhuringen.Columns.Add("VerhuurID");
            dtblVerhuringen.Columns.Add("Voornaam");
            dtblVerhuringen.Columns.Add("Achternaam");
            dtblVerhuringen.Columns.Add("Begindatum");
            dtblVerhuringen.Columns.Add("Einddatum");
            

            string connectiestring = "server=localhost;user id=root; database=springkastelen";
            string sql = "SELECT VerhuurID, tblklanten.Voornaam, tblklanten.Achternaam,\r\n       CAST(BeginDatum AS DATE) AS BeginDatum, \r\n       CAST(EindDatum AS DATE) AS EindDatum\r\nFROM tblverhuringen INNER JOIN tblklanten ON tblklanten.KlantID = tblverhuringen.KlantID\r\nORDER BY BeginDatum";

            using (MySqlConnection cnn = new MySqlConnection(connectiestring))
            using (MySqlCommand cmd = new MySqlCommand(sql, cnn))
            {
                cnn.Open();
                MySqlDataReader dtr = cmd.ExecuteReader();

                while (dtr.Read())
                {
                    DataRow rij = dtblVerhuringen.NewRow();
                    rij[0] = dtr["VerhuurID"].ToString();
                    rij[1] = dtr["Voornaam"].ToString();
                    rij[2] = dtr["Achternaam"].ToString();
                    rij[3] = Convert.ToDateTime(dtr["BeginDatum"]).ToString("dd-MM-yyyy");
                    rij[4] = Convert.ToDateTime(dtr["EindDatum"]).ToString("dd-MM-yyyy");

                    dtblVerhuringen.Rows.Add(rij);
                }

            }

            GridView1.DataSource = dtblVerhuringen;
            GridView1.DataBind();
        }

        protected void btnUitloggen_Click(object sender, EventArgs e)
        {
            Variables.adminaangemeld = false;
            Response.Redirect("Startpagina.aspx");
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "GaNaar")
            {
                string verhuurID = e.CommandArgument.ToString();
                Response.Redirect("AdminPanelOverzicht.aspx?ID=" + verhuurID);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    GridViewRow row = (GridViewRow)btn.NamingContainer;

        //    string VerhuurID = (row.Cells[1].Text);

        //    Response.Redirect("AdminPanelOverzicht.aspx?id=" + VerhuurID);
        //}

        //protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Select")
        //    {
        //        string id = e.CommandArgument.ToString();
        //        Response.Redirect("AdminPanelOverzicht.aspx?id=" + id);
        //    }
        //}
    }
}