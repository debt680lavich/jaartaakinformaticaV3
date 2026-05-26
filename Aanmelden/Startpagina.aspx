<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Startpagina.aspx.cs" Inherits="Aanmelden.Startpagina" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Startpagina</title>
    <link rel="stylesheet" href="index.css" />
</head>

<body>
    <form id="form1" runat="server">


        <a href="#section1" class="logo">
            <img src="Thijs.png" alt="Logo" />
        </a>


        <header>
            <nav>
                <ul>
                    <li><a href="#section1">Home</a></li>
                    <li><a href="Aanbod.aspx">Aanbod</a></li>
                    <li><a href="Reserveren.aspx">Reserveren</a></li>
                    <li><a href="#section4">Contact</a></li>
                </ul>
            </nav>
        </header>


        <section class="springkastelen-section" id="section1">
            <div class="springkastelen-wrapper">

                <div class="springkastelen-content">
                    <h2>Springplezier voor elk feest!</h2>
                    <p>
                        Maak van elk verjaardagsfeest, communie of evenement
            een onvergetelijke ervaring met onze kleurrijke en veilige springkastelen.
                    </p>
                    <a class="cta" href="Aanbod.aspx">Bekijk springkastelen →</a>
                </div>

                <div class="springkastelen-image-wrapper">
                    <img src="krokodil-springkasteel-2.jpg" alt="Springkasteel" />
                </div>

            </div>
        </section>


        <section class="content-section" id="section2">
            <div class="featured-categories">
                <div class="header">
                    <h2>Ons aanbod</h2>
                    <a href="Aanbod.aspx">Bekijk het hele aanbod →</a>
                </div>

                <div class="categories">
                    <div class="card">
                        <div class="card-image">
                            <img src="krokodil-springkasteel-2.jpg" alt="Springkasteel" />
                        </div>
                        <span class="badge">Springkastelen</span>
                        <p>Voor jong en oud</p>
                        <a class="cta" href="Aanbod.aspx">Bekijk springkastelen →</a>
                    </div>

                    <div class="card">
                        <div class="card-image">
                            <img src="stier.jpg" alt="Games" />
                        </div>
                        <span class="badge">Games</span>
                        <p>Lasergame, pop balloons, sumo worstelen</p>
                        <a class="cta" href="Aanbod.aspx">Bekijk games →</a>
                    </div>

                    <div class="card">
                        <div class="card-image">
                            <img src="unnamed.jpg" alt="Tenten" />
                        </div>
                        <span class="badge">Tenten</span>
                        <p>Partytenten, stretchtenten, ...</p>
                        <a class="cta" href="Aanbod.aspx">Bekijk tenten →</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="springkastelen-section" id="section3">
            <div class="springkastelen-wrapper">

                <div class="springkastelen-content">
                    <h2>Wees voorbereid op slecht weer!</h2>
                    <p>
                        Laat uw feest niet niet verdrinken, huur snel één/meerder partytenten! Zo blijft u zeker droog.
                    </p>
                    <a class="cta" href="Aanbod.aspx">Bekijk Tenten →</a>
                </div>

                <div class="springkastelen-image-wrapper">
                    <img src="unnamed.jpg" alt="Partytent" />
                </div>

            </div>

        </section>

        <section class="sectionFAQ" id="sectionFAQ">
            <div class="faq-container">
                <h1>Veel gestelde vragen</h1>

                <details>
                    <summary>Leveren jullie alle spullen aan huis?</summary>
                    <p>Je kunt zelf kiezen tussen leveren of ophalen</p>
                </details>

                <details>
                    <summary>Kan ik mijn boeking nog annuleren?</summary>
                    <p>Ja, je kunt annuleren tot 2 dagen vooraf door ons te bellen</p>
                </details>

                <details>
                    <summary>Hoeveel bedragen de leveringskosten?</summary>
                    <p>Alle leveringskosten zijn gratis!</p>
                </details>


            </div>
        </section>

        <section id="section4">
            <footer class="minimal-footer">
                <div class="footer-container">

                   <%-- <div class="footer-section brand">
                        <h3></h3>
                        <img src="ThijsWit.png" alt="logo" />
                    </div>--%>

                    <div class="footer-section links">
                        <h3>Menu</h3>
                        <ul>
                            <li><a href="#section1">Home</a></li>
                            <li><a href="#section2">Aanbod</a></li>
                            <li><a href="Reserveren.aspx">Reserveren</a></li>
                            <li><a href="#section4">Contact</a></li>
                        </ul>
                    </div>

                    <div class="footer-section contact">
                        <h3>Contact</h3>
                        <p><a href="tel:0470688423">0470 68 84 23</a></p>
                        <p><a href="mailto:info@funline.be">info@springkastelen.be</a></p>
                    </div>

                </div>
            </footer>
        </section>

    </form>
</body>
</html>
