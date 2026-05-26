<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Aanmelden.Checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Checkout</title>

<script>

    function selectOption(type) {
        var ophalen = document.getElementById('optOphalen');
        var leveren = document.getElementById('optLeveren');

        ophalen.classList.remove('selected');
        leveren.classList.remove('selected');

        document.getElementById(type).classList.add('selected');

        document.getElementById('<%= hiddenType.ClientID %>').value = type;

        document.getElementById('pnlUur').style.display = 'block';

        if (type === 'optLeveren')
            document.getElementById('pnlAdres').style.display = 'block';
        else
            document.getElementById('pnlAdres').style.display = 'none';
    }

</script>

<style>

body{
font-family: Arial, sans-serif;
margin:30px;
background:#f7f7f7;
}

.container{
max-width:900px;
margin:auto;
background:white;
padding:25px;
border-radius:8px;
box-shadow:0 0 10px rgba(0,0,0,0.1);
}

h1,h3{
margin-bottom:20px;
}

label{
font-weight:bold;
display:block;
margin-bottom:5px;
}

.row{
display:flex;
gap:20px;
margin-bottom:20px;
}

.row div{
flex:1;
}

input,select{
width:100%;
padding:10px;
border-radius:5px;
border:1px solid #ccc;
}


/* BUTTON STIJL (uit je css idee) */

.cta{
display:inline-block;
margin-top:20px;
padding:12px 20px;
background:#2e51a3;
color:white;
border-radius:8px;
border:none;
font-weight:600;
cursor:pointer;
transition:0.3s ease;
}

.cta:hover{
background:#1f3c82;
}


/* KEUZE KNOPPEN */

.choice-container{
display:flex;
gap:20px;
margin-bottom:30px;
}

.choice{
flex:1;
padding:25px;
border:2px solid #ccc;
border-radius:8px;
text-align:center;
cursor:pointer;
font-size:18px;
transition:0.2s;
background:white;
}

.choice:hover{
border-color:#2e51a3;
}

.choice.selected{
border-color:#2e51a3;
background:#eef2ff;
}

.icon{
font-size:40px;
display:block;
margin-bottom:10px;
}

.hidden{
display:none;
}

.price{
font-weight:bold;
margin-top:10px;
}

.grid{
margin-top:30px;
}

/* OVERZICHT TABEL */

.overzicht-table{
width:100%;
border-collapse:collapse;
margin-top:20px;
font-size:15px;
}

.overzicht-table th{
background:#f3f4f8;
padding:12px;
text-align:left;
font-weight:600;
border-bottom:2px solid #e5e5e5;
}

.overzicht-table td{
padding:10px;
border-bottom:1px solid #eee;
}

.overzicht-table tr:hover{
background:#f9fafc;
}

.overzicht-table tr:nth-child(even){
background:#fafafa;
}

.foutmelding {
    color: red;
    align-items: center;
    font-size: 18px;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<asp:HiddenField ID="hiddenType" runat="server" OnValueChanged="hiddenType_ValueChanged" />

<div class="container">

<h1>
    Bestelgegevens
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button
ID="btnTerug"
runat="server"
Height="47px"
Text="Stop aanvraag ↩"
CssClass="cta"
OnClick="btnTerug_Click" Width="181px" />

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</h1>



<div class="choice-container">

<div id="optOphalen" class="choice selected" onclick="selectOption('optOphalen')">
<span class="icon">📍</span>
Ophalen
</div>

<div id="optLeveren" class="choice" onclick="selectOption('optLeveren')">
<span class="icon">⛟</span>
Leveren
</div>

</div>




<asp:Panel ID="pnlUur" runat="server">

<h3>Gewenst uur</h3>

<asp:DropDownList
ID="ddlUur"
runat="server"
OnSelectedIndexChanged="ddlUur_SelectedIndexChanged">

<asp:ListItem Text="-- Kies uur --" />
<asp:ListItem Text="08:00" />
<asp:ListItem Text="10:00" />
<asp:ListItem Text="12:00" />
<asp:ListItem Text="14:00" />
<asp:ListItem Text="16:00" />

</asp:DropDownList>

</asp:Panel>




<asp:Panel ID="pnlAdres" runat="server" CssClass="hidden">

<h3>Leveradres</h3>

<div class="row">

<div>
<label>Straat</label>
<asp:TextBox ID="txtStraat" TextMode="SingleLine" runat="server" />
</div>

<div>
<label>Nummer</label>
<asp:TextBox ID="txtNummer" TextMode="Number" runat="server" />
</div>

</div>


<div class="row">

<div>
<label>Postcode</label>
<asp:TextBox ID="txtPostcode" TextMode="Number" runat="server" />
</div>

<div>
<label>Gemeente</label>
<asp:TextBox ID="txtGemeente" TextMode="Search" runat="server" />
</div>

</div>


<div class="price">

<asp:Label ID="lblAfstand" runat="server" />

<br />

<asp:Label ID="lblLeveringskost" runat="server" />

</div>

</asp:Panel>


<br />

<h3 style="margin-top:40px;">Verhuuroverzicht</h3>

<div class="grid">




<AlternatingRowStyle BackColor="White" />
<EditRowStyle BackColor="#2461BF" />
<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
<RowStyle BackColor="#EFF3FB" />
<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
<SortedAscendingCellStyle BackColor="#F5F7FB" />
<SortedAscendingHeaderStyle BackColor="#6D95E1" />
<SortedDescendingCellStyle BackColor="#E9EBEF" />
<SortedDescendingHeaderStyle BackColor="#4870BE" />

<asp:GridView
ID="GridView1"
runat="server"
CssClass="overzicht-table"
AutoGenerateColumns="true"
GridLines="None">
</asp:GridView>

<br /><br />

TOTAAL PRIJS:

<asp:Label ID="lbltotaalprijs" runat="server" Text="€ 0,00"></asp:Label>

<br /><br />

<asp:Label ID="lblfoutmelding" runat="server" CssClass="foutmelding"></asp:Label>

<br />

</div>


<br /><br />

<asp:Button
ID="btnBestel"
CssClass="cta"
runat="server"
Text="Verder →"
OnClick="btnBestel_Click" />

<br />

</div>

</form>

</body>
</html>