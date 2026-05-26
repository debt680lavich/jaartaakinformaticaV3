<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BestelOverzicht.aspx.cs" Inherits="Aanmelden.BestelOverzicht" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Besteloverzicht</title>
    <style type="text/css">
        body {
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .container {
            width: 800px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 8px;
        }

        h2 {
            border-bottom: 2px solid #507CD1;
            padding-bottom: 5px;
            color: #333;
        }

        .section {
            margin-top: 20px;
        }

        .label-title {
            font-weight: bold;
            width: 180px;
            display: inline-block;
        }

        .row {
            margin-bottom: 8px;
        }

        .total {
            font-size: 18px;
            font-weight: bold;
            text-align: left;
            margin-top: 15px;
        }
        
.overzicht-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 15px;
}

    .overzicht-table th {
        background: #f3f4f8;
        padding: 12px;
        text-align: left;
        font-weight: 600;
        border-bottom: 2px solid #e5e5e5;
    }

    .overzicht-table td {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    .overzicht-table tr:hover {
        background: #f9fafc;
    }

    .overzicht-table tr:nth-child(even) {
        background: #fafafa;
    }
        .auto-style1 {
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 15px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">

            <h2>Bedankt voor uw bestelling!</h2>

            <!-- KLANTGEGEVENS -->
            <div class="section">
                <h3>
                    <asp:Label ID="lblVerhuurID" runat="server" Font-Bold="False" Font-Size="10pt" >Verhuurnummer: </asp:Label>
                </h3>
                <h3>Klantgegevens</h3>

                <div class="row">
                    <span class="label-title">Naam:</span>
                    <asp:Label ID="lblNaam" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">Achternaam:</span>
                    <asp:Label ID="lblAchternaam" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">E-mail:</span>
                    <asp:Label ID="lblEmail" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">Telefoonnummer:</span>
                    <asp:Label ID="lblTelefoon" runat="server" />
                    <br />
                </div>
            </div>

            <!-- ADRES -->
            <div class="section">
                <h3>Adres</h3>

                <div class="row">
                    <span class="label-title">Straat:</span>
                    <asp:Label ID="lblStraat" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">Nummer:</span>
                    <asp:Label ID="lblNummer" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">Postcode:</span>
                    <asp:Label ID="lblPostcode" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">Gemeente:</span>
                    <asp:Label ID="lblGemeente" runat="server" />
                    <br />
                </div>
            </div>

            <!-- LEVERING / OPHALING -->
            <div class="section">
                <h3 id="lblLeveren">
                    Verhuurgegevens</h3>

                <div class="row">
                    <span class="label-title">Ophalen/leveren:</span>
                    <asp:Label ID="lblOphalenLeveren" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">
                    <asp:Label ID="lblBegindatumTEKST" runat="server" />
                    </span>&nbsp;<asp:Label ID="lblDatum" runat="server" />
                </div>

                <div class="row">
                    <span class="label-title">
                    <asp:Label ID="lblEinddatumtekst" runat="server" />
                    </span>&nbsp;<asp:Label ID="lbleinddatum" runat="server" />
                </div>
                <span class="label-title">Uur:</span>
                <asp:Label ID="lblUur" runat="server" />
                <br />
                <br />
            </div>

            <!-- BESTELLING -->
            <div class="section">
                <h3>Verhuuroverzicht</h3>

                <asp:GridView ID="grvArtikels" runat="server"
                    CssClass="overzicht-table" Width="578px" Height="207px">
                    <EmptyDataTemplate>
                        z
                    </EmptyDataTemplate>
                </asp:GridView>

                <div class="total">
                    <br />
                    <br />
                    Totaalprijs: € <asp:Label ID="lblTotaalprijs" runat="server" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>
