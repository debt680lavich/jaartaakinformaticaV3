<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Startpagina.aspx.cs" Inherits="Aanmelden.Startpagina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

	    <link rel="stylesheet" href="navbar.css" />
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

<a href="#section1" class="logo">
    <img src="logo.png" alt="Logo">
</a>

<header>
	<nav>
		<ul>
			<li><a href="#section1">Home</a></li>
			<li><a href="#section2">aanbod</a></li>
			<li><a href="Boeking.aspx">Reserveren</a></li>
			<li><a href="#section4">Contact</a></li>
		</ul>
	</nav>
</header>
<section class="container" id="section1">
	<img src="HOME_SEC1.png" alt="" class="auto-style1">
</section>
<section class="container" id="section2">
	<img src="2149551604.jpg" alt="">
</section>
<section class="container" id="section3">
	<img src="2149551604.jpg" alt="">
</section>
<section class="container" id="section4">
	<img src="2149551604.jpg" alt="">
</section>

<svg style="display: none">
	<defs>
		<filter id="wave-distort" x="0%" y="0%" width="100%" height="100%">
			<feTurbulence
										type="fractalNoise"
										baseFrequency="0.0038 0.0038"
										numOctaves="1"
										seed="2"
										result="roughNoise"
										/>
			<feGaussianBlur in="roughNoise" stdDeviation="8.5" result="softNoise" />
			<feComposite
									 operator="arithmetic"
									 k1="0"
									 k2="1"
									 k3="2"
									 k4="0"
									 in="softNoise"
									 result="mergedMap"
									 />
			<feDisplacementMap
												 in="SourceGraphic"
												 in2="mergedMap"
												 scale="-42"
												 xChannelSelector="G"
												 yChannelSelector="G"
												 />
		</filter>
	</defs>
</svg>