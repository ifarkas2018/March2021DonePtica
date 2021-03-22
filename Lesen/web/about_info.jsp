<%-- 
    Document   : about_info
    Created on : 12-May-2019, 05:30:48
    Author     : Ingrid Farkas
    Project    : Lesen
--%>

<%@page contentType = "text/html" pageEncoding = "UTF-8"%>
<%@page import = "miscellaneous.LesenMethoden"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            HttpSession hSession = LesenMethoden.returnSession(request);
            hSession.setAttribute("webpg_name", "about_page.jsp");
            // reseting the sess. var to the default: if the user just did do the subscribe, the form on the NEXT web page DOESN'T NEED 
            // to show the previous values 
            hSession.setAttribute("subscribe", "false"); 
        %>
        <!-- adding a new row to the Bootstrap grid; class whitebckgr is for setting the background to white -->
        <div class="whitebckgr">
            <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                <!-- the Bootstrap column takes 6 columns on the large desktops and 6 columns on the medium sized desktops -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                    <br /><br />
                    <div> <!-- horizontally centering the picture using center-image, img-fluid is for responsive image -->
                        <img src="images/books.png" class="img-fluid center-image" alt="Foto mit Büchern" title="Foto mit Büchern"> 
                    </div>
                </div>
                
                <!-- the Bootstrap column takes 5 columns on the large desktops and 5 columns on the medium sized desktops -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- adding the container to the Bootstrap grid -->
                        <div class="row"> <!-- adding a new row to the Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <span class="text-info">
                                    <h3>Über Uns</h3>
                                </span>
                                <br/>
                                <p> Lesen ist ein Erlebnis. Bücher machen die Welt begreifbar. Beflügelt von immer neuen Impulsen aus 
                                    der Welt der Bücher kreieren wir bei Lesen in einer einzigartigen Mischung aus persönlicher 
                                    Beratung, inspirierenden Sortimenten und innovativen digitalen Lösungen, zukunftsweisende Lesewelten 
                                    und ineinandergreifende Einkaufserlebnisse. Damit unsere Kunden die passende Lektüre finden 
                                    – immer und überall.
                                </p>
                                
                                <p>
                                    Das Sortiment unserer Buchhandlung umfasst 8.000 Titel aus den Schwerpunkten Belletristik und 
                                    Jugendbuch. Aber auch Fachbücher, Biographien, Kinderbücher und vieles mehr zählen zu unserem Sortiment, 
                                    das wir seit 2018 pflegen und den Wünschen unserer Kunden immer wieder anpassen. Mit so vielen Artikeln aus Büchern, 
                                    ist für jeden Webseitenbetreiber etwas Passendes dabei.
                                </p>
                                <p>
                                    Das Ziel von Lesen ist immer besser zu werden.  Um immer besser zu werden, ist das Mitdenken und die Kreativität aller Mitarbeiter notwendig.
                                </p>
                                <p>
                                    Unsere Mitarbeiter beteiligen sich aktiv am Erreichen der Unternehmensziele und an deren Weiterentwicklung. 
                                    Teamarbeit ist eine wichtige Voraussetzung für eine erfolgreiche Arbeit. Bei der Kommunikation untereinander setzen 
                                    wir Fairness, Respekt und Offenheit gegenüber jedem voraus. Und: Motivation, Engagement und Freundlichkeit! Unsere  
                                    Mitarbeiter verfügen über ein breites Wissen, und sie möchten immer weiter zu lernen.
                                </p>
                                <p>
                                    Unsere Kunden sollen sich bei uns immer wohl fühlen und gerne zu Lesen kommen. Kunden sind unsere Gäste, 
                                    die wir zuvorkommend behandeln. Freundlichkeit, Kompetenz und Ordnung sind selbstverständlich. Im Umgang 
                                    und im Gespräch mit dem Kunden sowie in einer guten Beratung zeigen wir unsere Kompetenz. Der Kunde und seine 
                                    Anliegen haben immer Priorität. Wir signalisieren dem Kunden beim Betreten des Ladens, dass er wahr genommen wird 
                                    und wir sind für ihn immer da. Wir bieten eine einladende und wohltuende Atmosphäre. Wir setzten auf attraktive 
                                    und übersichtliche Ladeneinrichtungen sowie ein aktuelles und am Kunden orientiertes Angebot.
                                </p>
                            </div> <!-- end of class="col" -->
                        </div> <!-- end of class="row" --> 
                    </div> <!-- end of class="container" -->
                </div> <!-- end of class="col-lg-5 col-md-5" -->
            </div> <!-- end of class="row" -->
        </div> <!-- end of class="whitebckgr" -->
            
        <!-- adding a new row; class whitebckgr is for setting the background to white -->
        <div class = "whitebckgr">
            <div class = "col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>

