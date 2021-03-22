<%-- 
    Dokument   : novinal_obr.jsp (ukljuċen u novinal_str.jsp)
    Formiran   : 06-Apr-2019, 00:14:14
    Autor      : Ingrid Farkaš
    Projekat   : Ptica
--%>

<!-- novinal_obr.jsp - prikazuje obrazac za unos korisničkog imena, lozinke, imena, prezimena, da li je korisnik administrator  -->
<!--                 - ukljuċen u novinal_str.jsp -->

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="razno.PticaMetodi" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script src="javascript/validacija.js"></script> 
        
        <script>
            BR_POLJA = 5; // broj polja na obrazacu 
            INPUT_POLJA = 12; // max broj polja na svim obrazcima
            JEDN_LOZ = 'true'; // da li se unesene lozinke poklapaju
           
            // isteLozinke: upoređuje dve unesene lozinke i postavlja vrednost varijable JEDN_LOZ (da li se lozinke poklapaju)
            function isteLozinke() {  
                var lozinka1 = document.novi_nalog.loz1.value;  
                var lozinka2 = document.novi_nalog.loz2.value;  
               
                if (lozinka1 == lozinka2) {  
                    JEDN_LOZ = 'true';
                    // obtiši poruke ispod input kontrola za lozinke
                    loz1_poruka.innerHTML = " ";
                    loz2_poruka.innerHTML = " ";
                }  else {  
                    JEDN_LOZ = 'false'; 
                    // prikaži poruku ispod input polja za lozinke
                    loz1_poruka.innerHTML = "Lozinke se ne poklapaju.";
                    loz2_poruka.innerHTML = "Lozinke se ne poklapaju.";
                }  
            }  
           
            // napraviKolacic: kreira kolaċić inputI = vrednost u input polju ; (I - broj 0..5)
            function napraviKolacic() {           
                var i;
                // niz sadrži imena input polja
                var inp_imena = new Array('kor_ime', 'ime', 'prezime', 'adm_da', 'adm_ne'); 
                
                // za radio dugmad postavi kolaċić na inicijalnu vrednost
                document.cookie = "input3" + "=;";
                document.cookie = "input4" + "=;";
                for (i = 0; i < BR_POLJA; i++) {
                    if ((i==0) || (i==1) || (i==2)) {
                        // encodeURIComponent: enkodiranje - koristi se zbog šŠčČćĆđĐžŽ
                        document.cookie = "input" + i + "=" + encodeURIComponent(document.getElementById(inp_imena[i]).value) + ";"; // kreiranje kolaċića
                    } else if ((i==3) || (i==4)) { // radio dugmad
                        if (document.getElementById(inp_imena[i]).checked){
                            document.cookie = "input" + i + "=" + document.getElementById(inp_imena[i]).value + ";"; // kreiranje kolaċića
                        }
                    }
                }
            }
            
            // nadjiKolacic: vraća vrednost kolaċića sa imenom ime_kol
            function nadjiKolacic(ime_kol) {
                var ime = ime_kol + "=";
                var dekodiraniKol = decodeURIComponent(document.cookie);
                var nizKolacic = dekodiraniKol.split(';'); // podela kolaċića na "kolacic_ime = kolacic_value;"
                for ( var i = 0; i < nizKolacic.length; i++ ) {
                  var kolacic = nizKolacic[i];
                  while (kolacic.charAt(0) == ' ') {
                    kolacic = kolacic.substring(1);
                  }
                  if (kolacic.indexOf(ime) == 0) { // ako kolaċić poċinje sa ime_kol + "="  
                    return kolacic.substring(ime.length, kolacic.length); // vraća vrednost kolaċića
                  }
                }
                return "";
            }
           
            // postaviVr: postavlja vrednosti kolaċića (sa imenima input0, input1,.., input12) na inicijalnu vrednost i
            // piše sadržaj svakog input polja u kolaċić
            function postaviVr() {   
                var i;
                for (i = 0; i < INPUT_POLJA; i++) {
                    vrKolacica = nadjiKolacic("popunjeno");
                    // ako se obrazac ne puni sa prethodnim vrednostima tada se radio dugmad postavlja na inicijalnu vrednost
                    if ((i === 0) && (vrKolacica === "false" )) { 
                        document.getElementById("adm_da").checked = true; // inicijalno je postavljeno radio dugme na Da 
                    }
                    document.cookie = "input" + i + "= "; // postavljanje VREDNOSTI kolaċića na PRAZNO
                }
                document.cookie = "popunjeno=false;"; // postavljanje popunjeno na inicijalnu vrednost
                napraviKolacic(); // za svako input polje zapisuje vrednost sadržaja tog polja u kolaċić
            } 
          
        </script>
    </head>
    
    <title>Ptica - Novi nalog</title>
    <body onload="postaviVr()">
        <%
            final String IME_STRANICE = "novinal_str.jsp"; // stranica koja se sada prikazuje 
            HttpSession hSesija = PticaMetodi.vratiSesiju(request);
            hSesija.setAttribute("ime_vebstr", "novinal_str.jsp");
            // postavljanje vrednosti varijabli sesije na inicijalnu vrednost: ako je korisnik sada završio prijavu na Newsletter,
            // obrazac na SLEDEĆOJ veb stranici ne treba da prikaže prethdne vrednosti
            hSesija.setAttribute("newsletter", "false");
        %>
        
        <!-- dodavanje novog reda u Bootstrap grid: klasa belapoz postavlja pozadinu u belu boju -->
        <div class="whitebckgr">
            <div class="row"> <!-- dodavanje nove vrste u Bootstrap grid -->
                <!-- Bootstrap kolona zauzima 6 kolona na velikim desktopovima i 6 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-6 col-md-6"> 
                    <br /><br />
                    <div> 
                        <!-- slika-centar postavlja sliku u sredinu (horizontalno), img-fluid je za responsivan image -->
                        <img src="images/books.png" class="img-fluid slika-centar" alt="slika sa knjigama" title="slika sa knjigama"> 
                    </div>
                </div>
                
                <!-- Bootstrap kolona zauzima 5 kolona na velikim desktopovima i 5 kolona na desktopovima srednje veliċine -->
                <div class="col-lg-5 col-md-5"> 
                    <div class="container"> <!-- dodavanje kontejnera u Bootstrap grid -->
                        <div class="row"> <!-- dodavanje novog reda u Bootstrap grid -->
                            <div class="col">
                                &nbsp; &nbsp;
                                <br/>
                                <h3 class="text-info">Novi nalog</h3> 
                                <br/> 
                                <%  
                                    HttpSession hSesija2 = PticaMetodi.vratiSesiju(request);
                                    
                                    String input0 = ""; // ċita se vrednost koja je bila pre u prvom input polju i ponovo je prikazuje
                                    String input1 = ""; 
                                    String input2 = "";                 
                                    String input3 = ""; // da li je Da radio dugme izabrano 
                                    String input4 = ""; // da li je Ne radio dugme izabrano
                                    
                                    // IDEJA: popunjeno je postavljeno u NewsletterServl.java - true ako su neke od varijabli sesije (input) bile postavljene,
                                    // i one treba da se dodaju ovde obrazcu - ovo je taċno ako je korisnik PRE PRIKAZAO OVU STRANICU i posle toga je uneo
                                    // email u prijavi za Newsletter (u footer-u) i na sledećoj stranici je kliknuo na Zatvori
                                    if (PticaMetodi.varSesijePostoji(hSesija2, "popunjeno")) { 
                                        String popunjeno = String.valueOf(hSesija2.getAttribute("popunjeno")); 
                                        // Postavljanje vrednosti varijable sesije ime_stranice. Ako je korisnik kliknuo dugme Prijavite se i posle toga ako je
                                        // na veb stranici newsletter_info.jsp kliknuo na Zatvori dugme, onda se ova veb stranica ponovo prikazuje
                                        if (PticaMetodi.varSesijePostoji(hSesija2, "ime_stranice")) { 
                                            String ime_stranice = String.valueOf(hSesija2.getAttribute("ime_stranice"));
                                            // Ako je korisnik kliknuo na Zatvori dugme na veb stranici newsletter_info.jsp i ako je 
                                            // ova stranica bila prikazana pre (ime_stranice) i ako su neke vrednosti saċuvane u varijablama 
                                            // sesije input tada proċitaj varijablu sesije input0 (da bi se prikazala u prvom polju) 
                                            if ((ime_stranice.equalsIgnoreCase(IME_STRANICE)) && (popunjeno.equalsIgnoreCase("true"))) {
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input0")) {
                                                    input0 = String.valueOf(hSesija2.getAttribute("input0")); // vrednost koja je bila u prvom polju
                                                    input0 = URLDecoder.decode(new String(input0.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input1")) {
                                                    input1 = String.valueOf(hSesija2.getAttribute("input1")); // vrednost koja je bila u drugom polju
                                                    input1 = URLDecoder.decode(new String(input1.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                } 
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input2")) {
                                                    input2 = String.valueOf(hSesija2.getAttribute("input2")); 
                                                    input2 = URLDecoder.decode(new String(input2.getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"); // dekodiranje zbog srpskih slova
                                                }   
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input3")) {
                                                    input3 = String.valueOf(hSesija2.getAttribute("input3")); // da li je Da radio dugme izabrano
                                                }   
                                                if (PticaMetodi.varSesijePostoji(hSesija2, "input4")) {
                                                    input4 = String.valueOf(hSesija2.getAttribute("input4")); // da li je Ne radio dugme izabrano
                                                }   
                                            } 
                                        }
                                        hSesija2.setAttribute("popunjeno", "false"); // input polja ne treba da budu ispunjena
                                    }                                    
                                    hSesija2.setAttribute("ime_stranice", IME_STRANICE);
                                    PticaMetodi.postaviNaPrazno(hSesija2); // postaviNaPrazno: postavlja vrednosti varijabli sesije na "" za varijable input0, input1, ...
                                %>

                                <form name="novi_nalog" id="novi_nalog" action="NoviNalogServl" onsubmit="return proveriF();" method="post">                                   
                                    <!-- input kontrola za ime -->
                                    <div class="form-group">
                                        <label for="ime">Ime</label> 
                                        <input type="text" class="form-control form-control-sm" name="ime" id="ime" onchange="napraviKolacic()" onfocusout="slova(document.novi_nalog.ime, ime_poruka, 'ime', false, 'false');" value="<%= input1 %>"> 
                                        <span id="ime_poruka" class="vel_teksta text-danger"></span>
                                    </div>

                                    <!-- input kontrola za prezime -->
                                    <div class="form-group">
                                        <label for="prezime">Prezime</label> 
                                        <input type="text" class="form-control form-control-sm" name="prezime" id="prezime" onchange="napraviKolacic()" onfocusout="slova(document.novi_nalog.prezime, prezime_poruka, 'prezime', false, 'false');" value="<%= input2 %>"> 
                                        <span id="prezime_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                        
                                    <!-- input kontrola za korisničko ime -->
                                    <div class="form-group">
                                        <label for="kor_ime">Korisničko ime </label> 
                                        <!-- ispunjavanje kontrole za korisničko ime je obavezno -->
                                        <input type="text" class="form-control form-control-sm" name="kor_ime" id="kor_ime" onchange="napraviKolacic()" required value="<%= input0 %>"> 
                                    </div>
                                        
                                    <!-- input kontrola za lozinku -->
                                    <div class="form-group">
                                        <label for="loz1">Lozinka </label> <!-- password name label -->
                                        <!-- ispunjavanje kontrole za lozinku je obavezno -->
                                        <input type="password" class="form-control form-control-sm" name="loz1" id="loz1" 
                                               pattern="(?=.*\d)(?=.*[a-zćčšžđ\u0400-\u04FF])(?=.*[A-ZĆČŠŽĐ\u0400-\u04FF]).{8,}" title="Lozinka mora da sadrži najmanje 8 karaktera. Najmanje jedan broj, jedno veliko i jedno malo slovo." 
                                               onfocusout='isteLozinke()' required> 
                                        <span id="loz1_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                    
                                    <!-- input kontrola za ponovo unošenje lozinke -->
                                    <div class="form-group">
                                        <label for="loz2">Ponovite lozinku </label> 
                                        <input type="password" class="form-control form-control-sm" name="loz2" id="loz2"  
                                               pattern="(?=.*\d)(?=.*[a-zćčšžđ\u0400-\u04FF])(?=.*[A-ZĆČŠŽĐ\u0400-\u04FF]).{8,}" title="Lozinka mora da sadrži najmanje 8 karaktera. Najmanje jedan broj, jedno veliko i jedno malo slovo." 
                                               onfocusout='isteLozinke()' required> 
                                        <span id="loz2_poruka" class="vel_teksta text-danger"></span>
                                    </div>
                                    
                                    <!-- radio dugmad - administrator -->
                                    <div class="form-group">
                                        <label for="admin">Administrator</label> 
                                        <div class="form-check">
                                            <!-- radio dugme Da -->
                                            <% if (input3.equalsIgnoreCase("adm_da")) { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_da" value="adm_da" onchange="napraviKolacic()" checked>
                                            <% } else { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_da" value="adm_da" onchange="napraviKolacic()">
                                            <% } %> 
                                            <label class="form-check-label" for="admin_da">
                                                Da
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <!-- radio dugme Ne -->
                                            <% if (input4.equalsIgnoreCase("adm_ne")) { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_ne" value="adm_ne" onclick="napraviKolacic()" checked>
                                            <% } else { %>
                                                <input class="form-check-input" type="radio" name="admin" id="adm_ne" value="adm_ne" onclick="napraviKolacic()" >
                                            <% } %> 
                                            <label class="form-check-label" for="admin_ne">
                                                Ne
                                            </label>
                                        </div>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                        
                                    <!-- btn-sm se koristi za manju (užu) veličinu kontrole -->
                                    <button type="submit" id="btnSubmit" class="btn btn-info btn-sm">Pošaljite</button>
                                    
                                    <!-- dodavanje novog kontejnera -->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col">
                                                &nbsp; &nbsp; <!-- dodavanje praznog prostora -->
                                            </div>
                                        </div>    
                                    </div>
                                </form>  
                            </div> <!-- završetak class="col" -->
                        </div> <!-- završetak class="row" -->  
                    </div> <!-- završetak class="container" -->
                </div> <!-- završetak class="col-lg-5 col-md-5" -->
            </div> <!-- završetak class="row" -->
        </div> <!-- završetak class="belapoz" -->
            
        <!-- dodavanje novog reda u Bootstrap grid; klasa belapoz: postavljanje pozadine u belu boju -->
        <div class="whitebckgr">
            <div class="col">
                &nbsp; &nbsp;
            </div>
        </div> 
    </body>
</html>

