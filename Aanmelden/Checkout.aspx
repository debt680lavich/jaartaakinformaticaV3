<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Aanmelden.Checkout" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background: #f7f7f7;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h1, h3 {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .row div {
            flex: 1;
        }

        input, select, button {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            background: #2196f3;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #1976d2;
        }

        .choice-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .choice {
            flex: 1;
            padding: 25px;
            border: 2px solid #ccc;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            font-size: 18px;
        }

        .choice.selected {
            border-color: #2196f3;
            background: #e3f2fd;
        }

        .icon {
            font-size: 40px;
            display: block;
            margin-bottom: 10px;
        }

        .hidden {
            display: none;
        }

        .price {
            font-weight: bold;
            margin-top: 10px;
        }
        .grid { margin-top: 30px; }
    </style>

    <script>
        function selectOption(type) {
            document.getElementById('optOphalen').classList.remove('selected');
            document.getElementById('optLeveren').classList.remove('selected');

            document.getElementById(type).classList.add('selected');

            document.getElementById('pnlUur').style.display = 'block';
            document.getElementById('pnlAdres').style.display = (type === 'optLeveren') ? 'block' : 'none';
        }
    </script>
</head>

<body>
<form id="form1" runat="server">
<div class="container">

    <h1>Checkout&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnTerug" runat="server" Height="48px" OnClick="btnTerug_Click" Text="Ga terug" Width="116px" />
        &nbsp;&nbsp;&nbsp;
    </h1>

    <!-- KEUZE -->
    <div class="choice-container">
        <div id="optOphalen" class="choice selected" onclick="selectOption('optOphalen')">
            <span class="icon">🏬</span>
            <asp:RadioButton ID="rbOphalen" runat="server" GroupName="Type" Checked="true" OnCheckedChanged="rbOphalen_CheckedChanged" />
            Ophalen
        </div>

        <div id="optLeveren" class="choice" onclick="selectOption('optLeveren')">
            <span class="icon">🚚</span>
            <asp:RadioButton ID="rbLeveren" runat="server" GroupName="Type" OnCheckedChanged="rbLeveren_CheckedChanged" />
            Leveren
        </div>
    </div>

    <!-- UUR -->
    <asp:Panel ID="pnlUur" runat="server">
        <h3>Gewenst uur</h3>
        <asp:DropDownList ID="ddlUur" runat="server" OnSelectedIndexChanged="ddlUur_SelectedIndexChanged">
            <asp:ListItem Text="-- Kies uur --" />
            <asp:ListItem Text="08:00" />
            <asp:ListItem Text="10:00" />
            <asp:ListItem Text="12:00" />
            <asp:ListItem Text="14:00" />
            <asp:ListItem Text="16:00" />


        </asp:DropDownList>
    </asp:Panel>

    <!-- ADRES -->
    <asp:Panel ID="pnlAdres" runat="server" CssClass="hidden">
        <h3>Leveradres</h3>

        <div class="row">
            <div>
                <label>Straat</label>
                <asp:TextBox ID="txtStraat" runat="server" />
            </div>
            <div>
                <label>Nummer</label>
                <asp:TextBox ID="txtNummer" runat="server" />
            </div>
        </div>

        <div class="row">
            <div>
                <label>Postcode</label>
                <asp:TextBox ID="txtPostcode" runat="server" />
            </div>
            <div>
                <label>Gemeente</label>
                <asp:TextBox ID="txtGemeente" runat="server" />
            </div>
        </div>

        <asp:Button ID="btnBereken" runat="server" Text="Bereken leveringskost"
            OnClick="btnBereken_Click" />

        <div class="price">
            <asp:Label ID="lblAfstand" runat="server" />
            <br />
            <asp:Label ID="lblLeveringskost" runat="server" />
        </div>
    </asp:Panel>

    <br />

            <h3 style="margin-top: 40px;">Verhuuroverzicht</h3>
            <div class="grid">
                <asp:GridView ID="grvArtikels" runat="server" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None">
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

                </asp:GridView>
                <br />
                <br />
                TOTAAL PRIJS:
                <asp:Label ID="lbltotaalprijs" runat="server" Text="€  0,00"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lblfoutmelding" runat="server"></asp:Label>
                <br />
            </div>
    <br />
    <br />

    <asp:Button ID="btnBestel" runat="server" Text="PLAATS BESTELLING ->"
    OnClick="btnBestel_Click" />

    <br />

</div>
</form>
</body>
</html>
