<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instellingen.aspx.cs" Inherits="Aanmelden.Instellingen" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Instellingen – Admin Panel</title>
    <link href="AdminPanel.css" rel="stylesheet" />
    <style>
        /* ── INSTELLINGEN PAGE STYLES ── */

        .page-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 28px;
        }

        .page-header-icon {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, #2e51a3, #1f3c82);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .page-header-icon svg {
                width: 20px;
                height: 20px;
                stroke: #fff;
            }

        .page-header-text h1 {
            margin: 0;
            font-size: 36px;
            font-weight: 700;
            color: #1e293b;
        }

        .page-header-text p {
            margin: 2px 0 0;
            font-size: 13px;
            color: #64748b;
        }

        .form-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 28px 32px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            max-width: auto;
        }

        .form-card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 18px;
            border-bottom: 1px solid #f1f5f9;
            margin-bottom: 24px;
        }

            .form-card-header svg {
                width: 18px;
                height: 18px;
                stroke: #2e51a3;
            }

            .form-card-header h2 {
                margin: 0;
                font-size: 15px;
                font-weight: 600;
                color: #1e293b;
            }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 28px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

            .form-group.full-width {
                grid-column: 1 / -1;
            }

            .form-group label {
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.07em;
                color: #64748b;
            }

            .form-group input[type="text"],
            .form-group input[type="number"],
            .form-group input[type="file"],
            .form-group select {
                padding: 10px 13px;
                border: 1.5px solid #e2e8f0;
                border-radius: 8px;
                font-size: 14px;
                color: #1e293b;
                background: #f8fafc;
                transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
                outline: none;
                font-family: Arial, sans-serif;
                width: 100%;
            }

            .form-group input[type="text"]:focus,
            .form-group input[type="number"]:focus,
            .form-group select:focus {
                border-color: #2e51a3;
                background: #fff;
                box-shadow: 0 0 0 3px rgba(46, 81, 163, 0.10);
            }

            .form-group input[type="file"] {
                cursor: pointer;
                padding: 8px 13px;
                font-size: 13px;
                color: #64748b;
            }

                .form-group input[type="file"]::-webkit-file-upload-button {
                    background: #2e51a3;
                    color: white;
                    border: none;
                    padding: 6px 14px;
                    border-radius: 6px;
                    font-size: 12px;
                    font-weight: 600;
                    cursor: pointer;
                    margin-right: 10px;
                    transition: background 0.2s ease;
                }

                .form-group input[type="file"]::-webkit-file-upload-button:hover {
                    background: #1f3c82;
                }

        .toggle-field {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 13px;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            background: #f8fafc;
            cursor: pointer;
            transition: border-color 0.2s, background 0.2s;
        }

            .toggle-field:hover {
                border-color: #2e51a3;
                background: #fff;
            }

        .toggle-switch {
            position: relative;
            width: 40px;
            height: 22px;
            flex-shrink: 0;
        }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
                position: absolute;
            }

        .toggle-slider {
            position: absolute;
            inset: 0;
            background: #cbd5e1;
            border-radius: 99px;
            transition: background 0.25s;
            cursor: pointer;
        }

            .toggle-slider::before {
                content: "";
                position: absolute;
                width: 16px;
                height: 16px;
                left: 3px;
                top: 3px;
                background: white;
                border-radius: 50%;
                transition: transform 0.25s;
                box-shadow: 0 1px 3px rgba(0,0,0,0.2);
            }

        .toggle-switch input:checked + .toggle-slider {
            background: #2e51a3;
        }

        .toggle-switch input:checked + .toggle-slider::before {
            transform: translateX(18px);
        }

        .toggle-label-text {
            font-size: 14px;
            color: #1e293b;
            user-select: none;
        }

        .field-hint {
            font-size: 11px;
            color: #94a3b8;
            margin-top: 2px;
        }

        .form-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }

        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 22px;
            background: #2e51a3;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease, transform 0.15s ease;
            font-family: Arial, sans-serif;
        }

            .btn-primary svg {
                width: 15px;
                height: 15px;
                stroke: white;
            }

            .btn-primary:hover {
                background: #1f3c82;
                transform: translateY(-1px);
            }

            .btn-primary:active {
                transform: translateY(0);
            }

        .btn-secondary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 20px;
            background: transparent;
            color: #64748b;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: border-color 0.2s, color 0.2s, background 0.2s;
            font-family: Arial, sans-serif;
            text-decoration: none;
        }

            .btn-secondary:hover {
                border-color: #2e51a3;
                color: #2e51a3;
                background: #eff6ff;
            }

        .alert {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
        }

            .alert svg {
                width: 16px;
                height: 16px;
                flex-shrink: 0;
            }

            .alert.success {
                background: #f0fdf4;
                border: 1px solid #bbf7d0;
                color: #16a34a;
            }

                .alert.success svg {
                    stroke: #16a34a;
                }

            .alert.error {
                background: #fef2f2;
                border: 1px solid #fecaca;
                color: #dc2626;
            }

                .alert.error svg {
                    stroke: #dc2626;
                }

        .input-prefix-wrap {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-prefix {
            position: absolute;
            left: 13px;
            font-size: 14px;
            color: #64748b;
            pointer-events: none;
            font-weight: 600;
        }

        .input-prefix-wrap input {
            padding-left: 26px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
                        <a href="Instellingen.aspx" class="menu-link active">
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

                <div class="page-header">
                    <div class="page-header-text">
                        <h1>Nieuw artikel toevoegen</h1>
                    </div>
                </div>

                <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                    <div class="alert success">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>
                        <asp:Label ID="lblSuccess" runat="server" Text="Artikel succesvol toegevoegd!"></asp:Label>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="alert error">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="12"></line>
                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                        </svg>
                        <asp:Label ID="lblError" runat="server" Text="Er is een fout opgetreden."></asp:Label>
                    </div>
                </asp:Panel>

                &nbsp;<div class="form-card">
                    <div class="form-card-header">
                        <%--<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="16"></line>
                            <line x1="8" y1="12" x2="16" y2="12"></line>
                        </svg>--%>
                        <h2>Nieuw artikel</h2>
                    </div>

                    <div class="form-grid">

                        <!-- ARTIKELNAAM -->
                        <div class="form-group full-width">
                            <label for="txtArtikelNaam">Artikelnaam</label>
                            <asp:TextBox ID="txtArtikelNaam" runat="server"
                                MaxLength="100"
                                CssClass=""
                                ClientIDMode="Static" OnTextChanged="txtArtikelNaam_TextChanged" />
                            &nbsp;</div>

                        <!-- ARTIKELPRIJS -->
                        <div class="form-group">
                            <label for="txtArtikelPrijs">Prijs (€)</label>
                            <div class="input-prefix-wrap">
                                <span class="input-prefix">€</span>
                                <asp:TextBox ID="txtArtikelPrijs" runat="server"
                                    TextMode="SingleLine"
                                    CssClass=""
                                    ClientIDMode="Static" />
                            </div>
                            &nbsp;</div>

                        <!-- MINIMUMLEEFTIJD -->
                        <div class="form-group">
                            <label for="txtMinimumleeftijd">Minimumleeftijd</label>
                            <asp:TextBox ID="txtMinimumleeftijd" runat="server"
                                MaxLength="5"
                                CssClass=""
                                ClientIDMode="Static" />
                            <span class="field-hint">.</span>
                        </div>

                        <!-- CATEGORIE -->
                        <div class="form-group">
                            <label for="txtCategorieID">Categorie</label>
                            <asp:TextBox ID="txtCategorieID" runat="server"
                                MaxLength="10"
                                CssClass=""
                                ClientIDMode="Static" />
                            <span class="field-hint">.</span>
                        </div>

                        <!-- VOORRAAD -->
                        <div class="form-group">
                            <label for="txtVoorraad">Voorraad</label>
                            <asp:TextBox ID="txtVoorraad" runat="server"
                                TextMode="SingleLine"
                                CssClass=""
                                ClientIDMode="Static" />
                            <span class="field-hint">.</span>
                        </div>

                        <!-- FOTO -->
                        <div class="form-group">
                            <label for="fuFoto">Foto</label>
                        </div>

                        <div class="form-group full-width">
                            <asp:TextBox ID="txtFoto" runat="server"
                                TextMode="SingleLine"
                                CssClass=""
                                ClientIDMode="Static" />
                        </div>

                    </div>

                 
                    <div class="form-actions">
                        <asp:Button ID="btnOpslaan" runat="server"
                            Text="Artikel opslaan"
                            OnClick="btnOpslaan_Click"
                            CssClass="btn-primary" />
                        <asp:Button ID="btnReset" runat="server"
                            Text="Resseten"
                            OnClick="btnReset_Click"
                            CssClass="btn-secondary"
                            CausesValidation="false" />
                    </div>

                </div>
             

            </div>
           

        </div>
    </form>

 <%--   <script>
        // Sync ASP.NET CheckBox (renders as <input type="checkbox">) with toggle slider
        (function () {
            var cb = document.getElementById('cbOphalenMogelijk');
            if (!cb) return;
            // The ASP CheckBox wraps the input; select the actual input
            var input = cb.querySelector ? cb.querySelector('input[type=checkbox]') : cb;
            if (!input) input = cb;

            var label = input.closest('.toggle-field');
            if (label) {
                label.addEventListener('click', function (e) {
                    // prevent double-toggle when clicking the checkbox itself
                    if (e.target === input) return;
                    input.checked = !input.checked;
                });
            }
        })();
    </script>--%>
</body>
</html>
