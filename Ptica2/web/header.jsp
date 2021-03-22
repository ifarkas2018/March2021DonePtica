<%-- 
    Dokument   : header
    Formiran   : 29-Mar-2019, 22:46:27
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<%@ page import="java.util.Enumeration" %>
<%@ page import="razno.PticaMetodi" %>

<!-- header.jsp formira logo, ime kompanije i navigaciju -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%  final String URL_ZAP_ADM = "ptica2/zaposleni"; // URL za zaposlene i administratore
    final String URL_KUP = "ptica2"; // URL za kupce
%>

<!DOCTYPE html>
<html lang="en">
    <head>           
        <!-- meta elementi -->
        <!-- karakter set -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- ključne reči koje se koriste prilikom Internet pretraživanja -->
        <meta name="keywords" content="Ptica, Knjižara u Beogradu i Novom Sadu, Online Knjižara, Onlajn Knjižara">
        <!-- meta tag koji se koristi za opis i svrhu veb sajte --> 
        <meta name="description" content="Razgledajte široki izbor knjiga i uživajte u kupovini sa dostavom do Vaših vrata">
        <meta name="author" content="Ingrid Farkaš"> 
        <!-- koristi se za responsivne veb stranice na uređajima sa razlicitom veličinom displeja -->
        <meta name="viewport" content="width=device-width, initial-scale=1"> 

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        <!-- link za Bootstrap CDN -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> 
        <link rel="stylesheet" href="css/css_pravila.css">
        
        <script>
            // kolacicPopunjeno: formiranje 2 kolačića 
            // 1. kolačić: popunjeno = false 
            // 2. kolačić: ime_vebstr = vebStranica
            function kolacicPopunjeno(vebStranica) {                
                document.cookie = "popunjeno=false;"; // formiranje 1.kolačića 
                document.cookie = "ime_vebstr=" + vebStranica;
            }
        </script>
    </head>

    <body class="sivapoz"> <!-- sivapoz - klasa koja postavlja sivu pozadinu (css_pravila.css) -->
        <div class="container">
            <div class="belapoz"> <!-- novi red - bela pozadina -->
            <div class="belapoz">
                <!-- Bootstrap kolona zauzima 12 kolona na velikim desktopovima, 12 kolona na desktopovima srednje veliċine,
                     12 kolona na displejima male veličine, 12 kolona na displejima ekstra male veličine -->
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <p>&nbsp; &nbsp;</p> 
                </div>
              
                <div class="row"> <!-- novi red u Bootstrap grid-u -->
                    <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima, 5 kolona na desktopovima srednje veliċine -->
                    <div class="col-lg-5 col-md-5"> 
                        &nbsp; &nbsp; 
                    </div>
                    <!-- Bootstrap kolona zauzima 4 kolone na velikim desktopovima, 4 kolone na desktopovima srednje veliċine -->
                    <div class="col-lg-4 col-md-4"> 
                        &nbsp;  
                        <!-- logo Ptice -->
                        <img class="slika-logo" src="images/bookshelf.png" alt="Ptica Logo" title="Ptica Logo">  
                                    
                        <span class="naslov-tekst">Ptica</span> <!-- ime knjižare -->
                    </div>
                    
                    <!-- Bootstrap kolona zauzima 7 kolona na velikim desktopovima, 7 kolona na desktopovima srednje veliċine,
                         12 kolona na displejima male veličine, 12 kolona na displejima ekstra male veličine -->
                    <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 "> 
                        &nbsp; &nbsp; 
                    </div>
                </div> 
            </div>       
            
            <%
                String zap_adm = ""; // da li korisnk koristi veb sajtu za zaposlene i administratore (ne za kupce)  
                String prijavljen = ""; // da li se korisnik prijavio 
                String tipKorisnika = ""; // vrsta korisnika: admin, zaposleni, customer (kupac)
                boolean nadjenAtrib = false; // da li je pronađen atribut tip_koris
                String strGreska = "false"; // da li se prikazuje stranica za grešku
                
                HttpSession hSesija1 = PticaMetodi.vratiSesiju(request);
                
                // varSesijePostoji: vraća da li varijabla sesije tip_koris postoji
                // tip_koris: admin, zaposleni, customer(kupac - postoji posle prijave korisnika) 
                nadjenAtrib = PticaMetodi.varSesijePostoji(hSesija1, "tip_koris"); 
                if (nadjenAtrib) // da li je pronađen atribut tip_koris
                    tipKorisnika = String.valueOf(hSesija1.getAttribute("tip_koris")); // admin, zaposleni, customer (moguće vrednosti)
                
                String URL_String = (request.getRequestURL()).toString(); // URL veb stanice koja je prikazana pre ove 
                
                // da li je stranica za grešku prikazana  
                nadjenAtrib = PticaMetodi.varSesijePostoji(hSesija1, "je_greska"); // varSesijePostoji: vraća da li varijabla sesije je_greska postoji u sesiji
                
                if (nadjenAtrib) { // da li je pronađena varijabla sesije je_greska
                    strGreska = String.valueOf(hSesija1.getAttribute("je_greska"));
                }
                
                // da li korisnik koristi veb sajtu za zaposlene i administratore (a ne za kupce)
                nadjenAtrib = PticaMetodi.varSesijePostoji(hSesija1, "zap_adm"); // varSesijePostoji: vraća da li varijabla sesije zap_adm postoji
                if (nadjenAtrib) // da li je pronađena varijabla sesije zap_adm 
                    zap_adm = String.valueOf(hSesija1.getAttribute("zap_adm")); // čitam vrednost varijable sesije
                
                if (zap_adm.equals("")) { // da li je pronađena varijabla sesije zap_adm
                    if (URL_String.contains(URL_ZAP_ADM)) { // da li korisnik koristi veb sajtu za zaposlene i administratore
                        zap_adm = "true";
                        hSesija1.setAttribute("zap_adm", zap_adm);                         
                    } else if (URL_String.contains(URL_KUP)) { // ako korisnik koristi veb sajtu za kupce 
                        zap_adm = "false";
                        hSesija1.setAttribute("zap_adm", zap_adm); 
                    }
                }
                
                // varSesijePostoji: vraća da li varijabla sesije prijavljen postoji 
                // prijavljen je TRUE ako je korisnik prijavljen (zaposleni ili administrator)
                nadjenAtrib = PticaMetodi.varSesijePostoji(hSesija1, "prijavljen"); 
                if (nadjenAtrib) // ako varijabla sesije prijavljen postoji
                    prijavljen = String.valueOf(hSesija1.getAttribute("prijavljen")); 
            %>
            
            <div class="row">
                <!-- Bootstrap kolona zauzima 12 kolona na velikim desktopovima, 12 kolona na desktopovima srednje veliċine,
                     12 kolona na displejima male veličine, 12 kolona na displejima ekstra male veličine -->
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"> 
                    <!-- navigacija -->
                    <!-- navbar-expand-md: na srednjoj tački preloma navigacija je predstavljena toggler ikonom -->
                    <nav class="navbar navbar-expand-md navbar-light bg-light">
                        <a class="navbar-brand"><img src="images/bookshelf.png"></a> <!-- logo kompanije -->
                        <a class="navbar-brand" href="DodajVarSesije" onclick="kolacicPopunjeno('index.jsp')">Ptica</a> <!-- ime kompanije -->
                        <!-- toggler ikona se koristi da isključi/uključi navigaciju -->
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"     
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <!-- mr-auto: ovaj deo hiperveza u navigaciji je na LEVOJ strani -->
                            <ul class="navbar-nav mr-auto">
                                
                                <%
                                    // link Pretraga se ne prikazuje na stranici za grešku
                                    if ((!(tipKorisnika.equals("admin"))) && (!(tipKorisnika.equals("zaposleni"))) && (strGreska.equals("false"))) {
                                %>
                                        <!-- link Pretraga u navigaciji -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="DodajVarSesije" onclick="kolacicPopunjeno('pretraga_str.jsp')">Pretraga</a>
                                        </li>
                                <%
                                    }
                                %>
                                
                                <%
                                    if (((tipKorisnika.equals("admin")) || (tipKorisnika.equals("zaposleni"))) && (strGreska.equals("false"))) {
                                %>
                                        <!-- link Knjige u navigaciji -->
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Knjige
                                            </a>
                                            <!-- padajućem meni -->
                                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                                <a class="dropdown-item" href="DodajVarSesije" onclick="kolacicPopunjeno('index.jsp')">Najnovija izdanja</a> <!-- Najnovija izdanja link na podmeniju -->
                                                <a class="dropdown-item" href="DodajVarSesije" onclick="kolacicPopunjeno('pretraga_str.jsp')">Pretraga knjiga</a>  
                                                <div class="dropdown-divider"></div> <!-- razdelnik na padajućem meniju -->
                                                <a class="dropdown-item" href="DodajVarSesije" onclick="kolacicPopunjeno('dodaj_stranicu.jsp')">Nova knjiga</a>  
                                                <a class="dropdown-item" href="DodajVarSesije" onclick="kolacicPopunjeno('azur_preth.jsp')">Ažuriranje knjige</a>  
                                                <a class="dropdown-item" href="DodajVarSesije" onclick="kolacicPopunjeno('obr_knjigu.jsp')">Brisanje knjige</a>  
                                            </div>
                                        </li>
                                <%
                                    }
                                %>
                                <!-- O nama link u navigaciji -->
                                <li class="nav-item">
                                    <a class="nav-link" href="DodajVarSesije" onclick="kolacicPopunjeno('onama_str.jsp')">O nama</a>
                                </li>
                                <!-- Kontakt link u navigaciji -->
                                <li class="nav-item">
                                    <a class="nav-link" href="DodajVarSesije" onclick="kolacicPopunjeno('kontakt_str.jsp')">Kontakt</a>
                                </li>
                            </ul>
                                                            
                            <!-- ml-auto: ovaj deo linkova u navbar je na DESNOJ strani -->
                            <ul class="navbar-nav ml-auto">
                                <%
                                    if ((tipKorisnika.equals("admin")) && (strGreska.equals("false"))) {
                                %>    
                                        <!-- Novi nalog link u navigaciji (navbar) -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="DodajVarSesije" onclick="kolacicPopunjeno('NoviNalog')">Novi nalog</a>
                                        </li>
                                <% 
                                    }
                                %>
                                
                                <%
                                    // ako je korisnik prijavljen prikaži link Odjava
                                    if ((prijavljen.equals("true")) && (strGreska.equals("false"))) {
                                %>    
                                        <!-- Odjava link u navigaciji (navbar) -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="OdjavaServlet">Odjava</a>
                                        </li>                               
                                <%
                                    // ako je korisnik prijavljen kao administrator("admin") ili zaposleni ili korisnik koristi veb sajtu
                                    // za zaposlene ili administratore
                                    } else if (((tipKorisnika.equals("admin")) || (tipKorisnika.equals("zaposleni")) || (zap_adm.equals("true"))) && (strGreska.equals("false"))) {
                                %>    
                                        <!-- link u navigaciji -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="DodajVarSesije" onclick="kolacicPopunjeno('prijava_inf_str.jsp')">Prijava</a>
                                        </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </nav>
                </div> <!-- završetak class="col-lg-12 col-md-12 col-sm-12 col-xs-12 -->

            </div> <!-- završetak class="row" --> 
        
            <div class="belapoz"> <!-- novi red - bela pozadina -->
                <div class="col">
                    &nbsp; &nbsp;
                </div>
            </div>
            <div class="belapoz">
                <div class="col-lg-12 col-md-12">
                    &nbsp; &nbsp;
                </div>
            </div>