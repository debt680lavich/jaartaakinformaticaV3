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
            if(txtWachtwoord.Text == "admin")
            {
                Response.Redirect("AdminPanel.aspx");
            }
        }

        protected void btnRegistreren_Click(object sender, EventArgs e)
        {

        }
    }
}