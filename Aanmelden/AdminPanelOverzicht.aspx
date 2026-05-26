<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanelOverzicht.aspx.cs" Inherits="Aanmelden.AdminPanelOverzicht" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel</title>
    <link href="AdminPanel.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            display: inline-block;
            margin-top: 8px;
            padding: 12px 20px;
            background: #2e51a3;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s ease;
            font-size: 10px;
        }
    </style>
</head>
<body>
<form id="form2" runat="server">
<div class="layout">

    <div class="card sidebar">
        <ul class="list">
            <li>
                <a href="AdminPanel.aspx" class="menu-link">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 9l9-7 9 7"></path>
                        <path d="M9 22V12h6v10"></path>
                    </svg>
                    <p>Overzicht</p>
                </a>
            </li>
            <li>
                <a href="AdminPanelOverzicht.aspx" class="menu-link">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="4" width="18" height="18" rx="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    <p>Verhuringen</p>
                </a>
            </li>
        </ul>
        <div class="separator"></div>
        <ul class="list">
            <li>
                <a href="Instellingen.aspx" class="menu-link">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z"></path>
                        <circle cx="12" cy="12" r="3"></circle>
                    </svg>
                    <p>Instellingen</p>
                </a>
            </li>
            <li class="delete">
                <a href="Startpagina.aspx" class="menu-link">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                        <polyline points="16 17 21 12 16 7"></polyline>
                        <line x1="21" y1="12" x2="9" y2="12"></line>
                    </svg>
                    <p>Uitloggen</p>
                </a>
            </li>
        </ul>
    </div>

  
    <div class="content">
        <asp:Panel ID="pnlZoeken" runat="server" Visible="false" CssClass="zoek-panel">
    <h2>Verhuring opzoeken</h2>
    <asp:TextBox ID="txtVerhuurID" runat="server" placeholder="Zoek op verhuurnummer" CssClass="verhuurid-opzoeken" Height="16px" Width="263px"></asp:TextBox>
    <asp:Button ID="btnZoeken" runat="server" Text="Zoeken" OnClick="btnZoeken_Click" CssClass="auto-style1" Height="40px" Width="91px" />
</asp:Panel>
        <div class="rental-overview">

           
            <div class="rental-id-bar">
                <span class="rental-id-label">Verhuur ID</span>
                <asp:Label ID="lblVerhuurID" runat="server" CssClass="rental-id-value"></asp:Label>
            </div>

            
            <div class="section-card">
                <div class="section-header">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="section-icon">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    <h2>Klantgegevens</h2>
                </div>

                <div class="customer-grid">
                    <div class="info-block">
                        <label>Voornaam</label>
                        <asp:Label ID="lblVoornaam" runat="server"></asp:Label>
                    </div>
                    <div class="info-block">
                        <label>Achternaam</label>
                        <asp:Label ID="lblAchternaam" runat="server"></asp:Label>
                    </div>
                    <div class="info-block">
                        <label>E-mailadres</label>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </div>
                    <div class="info-block">
                        <label>Telefoon</label>
                        <asp:Label ID="lblTelefoon" runat="server"></asp:Label>
                    </div>
                    <div class="info-block full-width">
                        <label>Adres</label>
                        <asp:Label ID="lblAdres" runat="server"></asp:Label>
                    </div>
                </div>

                <div class="separator-line"></div>

                <div class="rental-meta-grid">
                    <div class="meta-block">
                        <label>Begindatum &amp; uur</label>
                        <div class="date-badge start">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="4" width="18" height="18" rx="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                            <div class="date-text">
                                <asp:Label ID="lblBeginDatum" runat="server" CssClass="date-main"></asp:Label>
                                <asp:Label ID="lblBeginUur" runat="server" CssClass="date-time"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="meta-block">
                        <label>Einddatum</label>
                        <div class="date-badge end">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="4" width="18" height="18" rx="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                            <div class="date-text">
                                <asp:Label ID="lblEindDatum" runat="server" CssClass="date-main"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="meta-block">
                        <label>Levering / Ophaling</label>
                        <div class="delivery-toggle">
                            <span id="spanLevering" runat="server" class="toggle-option">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="1" y="3" width="15" height="13" rx="1"></rect>
                                    <path d="M16 8h4l3 5v3h-7V8z"></path>
                                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                                </svg>
                                Levering
                            </span>
                            <span class="toggle-divider">/</span>
                            <span id="spanOphalen" runat="server" class="toggle-option">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 10V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l2-1.14"></path>
                                    <polyline points="3.29 7 12 12 20.71 7"></polyline>
                                    <line x1="12" y1="22" x2="12" y2="12"></line>
                                    <circle cx="18.5" cy="15.5" r="2.5"></circle>
                                    <path d="M20.27 17.27 22 19"></path>
                                </svg>
                                Ophalen
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            
            <div class="section-card">
                <div class="section-header">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="section-icon">
                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                        <line x1="3" y1="6" x2="21" y2="6"></line>
                        <path d="M16 10a4 4 0 0 1-8 0"></path>
                    </svg>
                    <h2>Gehuurde artikelen</h2>
                </div>
                <asp:GridView ID="tblArtikels" runat="server" CssClass="articles-table"
                    AutoGenerateColumns="false"
                    ShowFooter="true"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Artikel" HeaderText="Artikel" />
                        <asp:BoundField DataField="Aantal" HeaderText="Aantal" ItemStyle-CssClass="center" HeaderStyle-CssClass="center" />
                        <asp:BoundField DataField="Eenheidsprijs" HeaderText="Eenheidsprijs" ItemStyle-CssClass="right" HeaderStyle-CssClass="right" />
                        <asp:BoundField DataField="Subtotaal" HeaderText="Subtotaal" ItemStyle-CssClass="right" HeaderStyle-CssClass="right" />
                    </Columns>
                </asp:GridView>
                <div class="totaal-rij">
                    <span>Totaal</span>
                    <asp:Label ID="lblTotaal" runat="server" CssClass="total-price"></asp:Label>
                </div>
            </div>

            <div class="section-card">
                <div class="section-header">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="section-icon">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                    </svg>
                    <h2>Opmerkingen</h2>
                </div>
                <div class="remarks-box">
                    <asp:label ID="lblOpmerkingen" runat="server" CssClass="articles-table"></asp:label>
                </div>
            </div>

        </div>
    </div>
</div>
</form>
</body>
</html>