<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registreren.aspx.cs" Inherits="Aanmelden.Registreren" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 219px;
        }
        .auto-style2 {
            width: 297px;
        }
        .auto-style3 {
            width: 297px;
            height: 44px;
        }
        .auto-style4 {
            height: 44px;
        }
        .auto-style5 {
            width: 100%;
        }
        .auto-style6 {
            width: 550px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            <br />
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Naam" runat="server" Text="Naam"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNaam" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="Voornaam"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtVoornaam" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Adres"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAdres" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Telnr"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTelnr" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="Label5" runat="server" Text="e-mail"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtEmail" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="Label6" runat="server" Text="wachtwoord"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtWachtwoord" runat="server" Width="334px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </p>
        <div>
            <table class="auto-style5">
                <tr>
                    <td class="auto-style6">
                        <asp:Button ID="btnRegistreren" runat="server" OnClick="btnRegistreren_Click" Text="Registreren" Width="444px" />
                    </td>
                    <td>
                        <asp:Button ID="btnAanmelden" runat="server" OnClick="btnAanmelden_Click" Text="Terug naar aanmelden" Width="444px" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
