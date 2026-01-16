<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Boeking.aspx.cs" Inherits="Aanmelden.Boeking" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nieuwe verhuring</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background: #f7f7f7; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { margin-bottom: 25px; }
        label { font-weight: bold; }
        .row { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .row div { flex: 1; margin-right: 20px; }
        .row div:last-child { margin-right: 0; }
        input, select, button { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { background: #2196f3; color: white; cursor: pointer; border: none; }
        button:hover { background: #1976d2; }
        .grid { margin-top: 30px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Nieuwe verhuring</h1>

            <div class="row">
                <div>
                    <label>Begindatum</label>
                    <asp:TextBox ID="txtStart" runat="server" TextMode="Date" OnTextChanged="txtStart_TextChanged"></asp:TextBox>
                </div>
                <div>
                    <label>Einddatum</label>
                    <asp:TextBox ID="txtEinde" runat="server" TextMode="Date"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div>
                    <label>Kies artikel</label>
                    <asp:DropDownList ID="ddlArtikels" runat="server" AutoPostBack="True"></asp:DropDownList>
                </div>
                <div>
                    <label>Aantal</label>
                    <asp:DropDownList ID="ddlAantal" runat="server" AutoPostBack="True"></asp:DropDownList>
                    <asp:TextBox ID="txtAantal" runat="server"></asp:TextBox>
                </div>
            </div>

            <button type="submit" runat="server" id="button1" onserverclick="button1_Click">Artikel Toevoegen</button>

            <h3 style="margin-top: 40px;">Overzicht Artikels</h3>
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
                <asp:Label ID="lblfoutmelding" runat="server"></asp:Label>
                <br />
                <br />
            </div>

            <button type="submit" runat="server" id="Button2" onserverclick="Button2_Click">Ga verder</button>
        </div>
    </form>
</body>
</html>