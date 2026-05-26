<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reserveren.aspx.cs" Inherits="Aanmelden.Reserveren" %>

<!DOCTYPE html>

<html>
<head runat="server">
<title>Reservatie</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="index.css" />

    <style type="text/css">
        .auto-style1 {
            display: inline-block;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s ease;
            cursor: pointer;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            margin-top: 25px;
            padding: 12px 24px;
            background: #2e51a3;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<section class="reservation-page">

<div class="reservation-card">

<h1 class="reservation-title">Maak een reservatie</h1>


<!-- DATUM SELECTIE -->

<asp:Panel ID="pnlDatum" runat="server">

<div class="date-box">

<asp:TextBox 
    ID="txtStartDatum" 
    runat="server" 
    TextMode="Date"
    OnTextChanged="txtStartdatum_Changed" />

<span class="tot">tot</span>

<asp:TextBox 
    ID="txtEindDatum" 
    runat="server" 
    TextMode="Date"
    AutoPostBack="true"
    OnTextChanged="txtEinddatum_Changed" />

<asp:Button 
ID="btnZoek" 
runat="server" 
Text="Verder"
CssClass="auto-style1"
OnClick="btnZoek_Click" Height="46px" />

    <br />
</div>

</asp:Panel>


<!-- ARTIKELEN -->

<asp:Panel ID="pnlArtikelen" runat="server" Visible="false">

<h1 class="section-title">Kies artikelen</h1>

    <h1 class="section-title">
        <asp:Label ID="lblFoutmelding" runat="server" CssClass="foutmelding"></asp:Label>
    </h1>

<div class="articles-grid">

<asp:Repeater ID="rptArtikelen" runat="server">

<ItemTemplate>

<div class="article-card">

<img src='<%# Eval("Foto") %>' />

<h3 class="artikelNaam">
<asp:Literal ID="litNaam" runat="server" Text='<%# Eval("Naam") %>' />
</h3>

<p class="prijs">
<asp:Literal ID="litPrijs" runat="server" Text='<%# Eval("Prijs") %>' />
</p>

<div class="quantity-selector">

<button type="button" class="qty-btn" onclick="decrease(this)">-</button>

<asp:TextBox
ID="txtAantal"
runat="server"
Text="0"
TextMode="Number"
CssClass="qty"
min="0"
max='<%# Eval("Voorraad") %>'
OnTextChanged="txtAantal_TextChanged"
AutoPostBack="true" />

<button type="button" class="qty-btn" onclick="increase(this)">+</button>

</div>

</div>

</ItemTemplate>

</asp:Repeater>

</div>


<!-- OVERZICHT -->

<div class="reservation-summary">

<h3>Overzicht</h3>

<asp:GridView 
ID="gvOverzicht"
runat="server"
AutoGenerateColumns="false"
CssClass="summary-table">

<Columns>

<asp:BoundField DataField="Naam" HeaderText="Artikel" />

<asp:BoundField DataField="Aantal" HeaderText="Aantal" />

<asp:BoundField DataField="Totaalprijs" HeaderText="Totaalprijs" />

</Columns>

</asp:GridView>

<asp:Button 
ID="btnVerder"
runat="server"
Text="Verder"
CssClass="cta" 
OnClick="btnVerder_Click" />


</div>

</asp:Panel>

</div>

</section>

</form>


<script>

    function increase(btn) {
        let input = btn.parentElement.querySelector(".qty");
        let max = parseInt(input.max);
        let value = parseInt(input.value);

        if (value < max)
            input.value = value + 1;

        updateOverzicht();
    }

    function decrease(btn) {
        let input = btn.parentElement.querySelector(".qty");
        let value = parseInt(input.value);

        if (value > 0)
            input.value = value - 1;

        updateOverzicht();
    }


    function updateOverzicht() {
        let table = document.querySelector(".summary-table tbody");

        if (!table) return;

        table.innerHTML = "";

        let cards = document.querySelectorAll(".article-card");

        cards.forEach(card => {

            let naam = card.querySelector(".artikelNaam").innerText;
            let prijs = card.querySelector(".prijs").innerText;
            let aantal = parseInt(card.querySelector(".qty").value);

            if (aantal > 0) {
                let row = "<tr>" +
                    "<td>" + naam + "</td>" +
                    "<td>" + aantal + "</td>" +
                    "<td>" + prijs + "</td>" +
                    "</tr>";

                table.innerHTML += row;
            }

        });
    }

</script>

</body>
</html>