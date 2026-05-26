<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bestelgegevens.aspx.cs" Inherits="Aanmelden.Bestelgegevens" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gegevens</title>

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

        input, select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .cta {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #2e51a3;
            color: white;
            border-radius: 8px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
        }

            .cta:hover {
                background: #1f3c82;
            }

        .choice-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .choice {
            flex: 1;
            padding: 20px;
            border: 2px solid #ccc;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            transition: 0.2s;
        }

            .choice.selected {
                border-color: #2e51a3;
                background: #eef2ff;
            }

        .hidden {
            display: none;
        }
    </style>

    <script>

        function selectPayment(id) {
            var opties = document.getElementsByClassName("choice");

            for (var i = 0; i < opties.length; i++) {
                opties[i].classList.remove("selected");
            }

            document.getElementById(id).classList.add("selected");
            document.getElementById('<%= hiddenBetaling.ClientID %>').value = id;
        }

    </script>

</head>

<body>

    <form id="form1" runat="server">

        <asp:HiddenField ID="hiddenType" runat="server" />
        <asp:HiddenField ID="hiddenBetaling" runat="server" />

        <div class="container">

            <h1>Klantgegevens</h1>

            <!-- PERSOONSGEGEVENS -->

            <h3>&nbsp;</h3>

            <div class="row">
                <div>
                    <label>Voornaam</label>
                    <asp:TextBox ID="txtNaam" runat="server" />
                </div>

                <div>
                    <label>Achternaam</label>
                    <asp:TextBox ID="txtAchternaam" runat="server" />
                </div>
            </div>

            <div class="row">
                <div>
                    <label>E-mail</label>
                    <asp:TextBox ID="txtEmail" TextMode="Email" runat="server" />
                </div>

                <div>
                    <label>Telefoon</label>
                    <asp:TextBox ID="txtTel" TextMode="Phone" runat="server"
                         CssClass="tel-mask" />

                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
                    <script>
                        $(document).ready(function () {
                            $('.tel-mask').mask('0000 00 00 00');
                        });
                    </script>

                </div>

                <%-- <asp:RegularExpressionValidator ID="ControleTelefoon" runat="server"
                ErrorMessage="Geen geldig telefoonnummer" ControlToValidate="txtTel"
                ValidationExpression="^(\+32|0)(4\d{2}[- .]?\d{2}[- .]?\d{2}[- .]?\d{2}|[1-9]\d{1}[- .]?\d{2}[- .]?\d{2}[- .]?\d{2})$">
            </asp:RegularExpressionValidator>--%>
            </div>

            <!-- ADRES (ALLEEN BIJ OPHALEN) -->

            <asp:Panel ID="pnlAdres" runat="server">

                <h3>Adres</h3>

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

            </asp:Panel>


            <!-- BETALING -->

            <h3>Betaalmethode</h3>

            <div class="choice-container">

                <div id="optOverschrijving" class="choice" onclick="selectPayment('optOverschrijving')">
                    Overschrijving
                </div>

                <div id="optCash" class="choice" onclick="selectPayment('optCash')">
                    Cash
    bij ophalen/leveren
                </div>

            </div>


            <br />

            <asp:Label ID="lblFout" runat="server" Visible="False"></asp:Label>

            <br />

            <asp:Button
                ID="btnVerder"
                runat="server"
                Text="Bestelling bevestigen → "
                CssClass="cta"
                OnClick="btnVerder_Click" />

        </div>

    </form>

</body>
</html>
