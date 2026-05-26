<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Aanbod.aspx.cs" Inherits="Aanmelden.Aanbod" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
  <title></title>

  <link rel="stylesheet" href="index.css" />
  <style type="text/css">
    .auto-style1 {
      width: 1351px;
    }
  </style>
</head>

<body>
  <form id="form1" runat="server">
    <div>
    </div>
  </form>
</body>

</html>

<a href="Startpagina.aspx" class="logo">
  <img src="Thijs.png" alt="Logo">
</a>

<header>
  <nav>
    <ul>
      <li><a href="Startpagina.aspx">Home</a></li>
      <li><a href="Aanbod.aspx">Aanbod</a></li>
      <li><a href="Reserveren.aspx">Reserveren</a></li>
      <li><a href="Startpagina.aspx#section4">Contact</a></li>
    </ul>
  </nav>
</header>

<section class="section1" id="section1"></section>

<section class="section2" id="section2"></section>

<section class="content-section" id="section2">

  <div class="filter-dropdown">
    <label class="dropdown">

      <input type="checkbox" class="dropdown-toggle"/>

      <span class="dropdown-label">Filter op categorie ▾</span>

      <div class="dropdown-menu">
        <label>
          <input type="checkbox" class="filter-checkbox" value="Springkastelen"/>
          Springkastelen
        </label>

        <label>
          <input type="checkbox" class="filter-checkbox" value="Stormbanen"/>
          Stormbanen
        </label>

        <label>
          <input type="checkbox" class="filter-checkbox" value="Games"/>
          Games
        </label>

        <label>
          <input type="checkbox" class="filter-checkbox" value="Tenten"/>
          Tenten
        </label>
      </div>

    </label>
  </div>

  <div class="featured-categories">
    <div class="header">
      <h2></h2>
    </div>

    <div class="categories">
        <div class="card" data-categorie="Springkastelen">
            <div class="card-image">
                <img src="krokodil-springkasteel-2.jpg" alt="krokodil">
            </div>

            <div class="card-header">
                <span class="badgeAanbod">Springkasteel Krokodil</span>
                <h4>€ 120 /dag</h4>
            </div>

            <p>vanaf 8 jaar</p>

            <a href="Reserveren.aspx?product=Scretchtent Groot" class="cta">Reserveer →</a>
        </div>
      

      <div class="card" data-categorie="Tenten">
        <div class="card-image">
          <img src="partytent.jpg" alt="partytent">
        </div>

        <div class="card-header">
          <span class="badgeAanbod">PartyTent 4x4</span>
          <h4>€ 50 /dag</h4>
        </div>

        <p>4x4 m | hoogte: 2,30m</p>

        <a href="Reserveren.aspx?product=PartyTent 4x4" class="cta">Reserveer →</a>
      </div>

      <div class="card" data-categorie="Games">
        <div class="card-image">
          <img src="opblaasballen.jpg" alt="opblaasballen">
        </div>

        <div class="card-header">
          <span class="badgeAanbod">Oplaasballen</span>
          <h4>€ 25 /dag</h4>
        </div>

        <p> prijs per 2 | 10-16 jaar</p>

        <a href="Reserveren.aspx?product=Oplaasballen" class="cta">Reserveer →</a>
      </div>

      <div class="card" data-categorie="Springkastelen">
        <div class="card-image">
          <img src="Crayon.jpg" alt="Crayon"/>
        </div>

        <div class="card-header">
          <span class="badgeAanbod">Springkasteel Crayon</span>
          <h4>€ 90 /dag</h4>
        </div>

        <p>vanaf 8 jaar</p>

        <a href="Reserveren.aspx?product=Springkasteel Crayon" class="cta">Reserveer →</a>
      </div>

      <div class="card" data-categorie="Games">
        <div class="card-image">
          <img src="stier.jpg" alt="RodeoStier"/>
        </div>

        <div class="card-header">
          <span class="badgeAanbod">Rodeo Stier</span>
          <h4>€ 140 / dag</h4>
        </div>

        <p>vanaf 12 jaar</p>

        <a href="Reserveren.aspx?product=Rodeo Stier" class="cta">Reserveer →</a>
      </div>

      <div class="card" data-categorie="Stormbanen">
        <div class="card-image">
          <img src="StormbaanJungle.jpg" alt="stormbaanJunlge"/>
        </div>

        <div class="card-header">
          <span class="badgeAanbod">Stormbaan Junlge</span>
          <h4>€ 160 /dag</h4>
        </div>

        <p> 15m | vanaf 10 jaar</p>

        <a href="Reserveren.aspx?product=Stormbaan Jungle" class="cta">Reserveer →</a>
      </div>


</section>

<script>

    document.addEventListener("DOMContentLoaded", function () {

        const checkboxes = document.querySelectorAll('.filter-checkbox');
        const producten = document.querySelectorAll('.card');

        checkboxes.forEach(checkbox => {

            checkbox.addEventListener('change', function () {

                const geselecteerd = Array.from(checkboxes)
                    .filter(cb => cb.checked)
                    .map(cb => cb.value);

                producten.forEach(product => {

                    const categorie = product.getAttribute("data-categorie");

                    if (geselecteerd.length === 0 || geselecteerd.includes(categorie)) {
                        product.classList.remove("hidden");
                    }
                    else {
                        product.classList.add("hidden");
                    }

                });

            });

        });

    });

</script>