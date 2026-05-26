<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="Aanmelden.AdminPanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel</title>
    <link href="AdminPanel.css" rel="stylesheet" />
</head>
<body>

    <form id="form1" runat="server">

        <div class="layout">

           
            <div class="card sidebar">

                <ul class="list">
                    <li>
                        §<a href="AdminPanel.aspx" class="menu-link">
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

            <!-- CONTENT -->
            <div class="content">
                <h1>Komende verhuringen</h1>

                <div class="table-card">
                    <p>Bekijk hier alle komende verhuringen:</p>

                    <asp:GridView ID="GridView1" runat="server"
                        Width="900px" CssClass="articles-table"
                        AutoGenerateColumns="False"
                        OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1">
                        <Columns>

                            <%-- Knop kolom met TemplateField --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBekijk" runat="server"
                                        CommandName="GaNaar"
                                        CommandArgument='<%# Eval("VerhuurID") %>'
                                        Text="Bekijk verhuring" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="VerhuurID" HeaderText="Verhuur ID" />
                            <asp:BoundField DataField="Voornaam" HeaderText="Voornaam" />
                            <asp:BoundField DataField="Achternaam" HeaderText="Achternaam" />
                            <asp:BoundField DataField="BeginDatum" HeaderText="BeginDatum" />
                            <asp:BoundField DataField="Einddatum" HeaderText="EindDatum" />

                        </Columns>
                        <EmptyDataTemplate>
                            <p>Geen verhuringen gevonden.</p>
                        </EmptyDataTemplate>
                    </asp:GridView>

                </div>
            </div>

        </div>

    </form>
</body>
</html>
