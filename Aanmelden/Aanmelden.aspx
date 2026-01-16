<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Aanmelden.aspx.cs" Inherits="Aanmelden.Aanmelden" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Aanmelden</title>

    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap');

        :root {
            --accent-color: #8672FF;
            --base-color: #ffffff;
            --text-color: #2E2B41;
            --input-color: #F3F0FF;
            --error-color: #f06272;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            width: 100%;
            height: 100%;
            font-family: Poppins, Segoe UI, sans-serif;
        }

        body {
            background-image: url('background.jpg');
            background-size: cover;
            background-position: center;
        }

        /* ⭐ CENTRERING ⭐ */
        .page-center {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* LOGIN CARD */
        .wrapper {
            width: 100%;
            max-width: 450px;
            padding: 50px 40px;
            background-color: var(--base-color);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            text-align: center;
        }

        /* TITEL */
        h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 30px;
            text-transform: uppercase;
        }

        /* FORM */
        form {
            width: 100%;
        }

        table {
            width: 100%;
            border-spacing: 0 15px;
        }

        /* LABEL LINKS */
        td:first-child label {
            width: 50px;
            height: 50px;
            background-color: var(--accent-color);
            color: white;
            border-radius: 10px 0 0 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* INPUT */
        input[type="text"],
        input[type="password"] {
            width: 100%;
            height: 50px;
            padding: 0 15px;
            background-color: var(--input-color);
            border: 2px solid var(--input-color);
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        input:focus {
            outline: none;
            border-color: var(--text-color);
        }

        /* BUTTONS */
        input[type="submit"] {
            width: 100%;
            margin-top: 15px;
            padding: 14px;
            border-radius: 1000px;
            border: none;
            background-color: var(--accent-color);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: var(--text-color);
        }

        /* FOUT */
        #lblFout {
            display: block;
            margin-top: 10px;
            color: var(--error-color);
        }
        .auto-style1 {
            margin-left: 0;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-center">
            <div class="wrapper">

                <h1>Aanmelden</h1>

                <table>
                    <tr>
                        <td>
                            email</td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="auto-style1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            wachtwoord</td>
                        <td>
                            <asp:TextBox ID="txtWachtwoord" runat="server" TextMode="Password" />
                        </td>
                    </tr>
                </table>

                <asp:Button ID="btnAanmelden" runat="server"
                    Text="Aanmelden"
                    OnClick="btnAanmelden_Click" />

                <asp:Label ID="lblFout" runat="server" />

                <asp:Button ID="btnRegistreren" runat="server"
                    Text="Registreren"
                    OnClick="btnRegistreren_Click" />

            </div>
        </div>
    </form>
</body>
</html>
