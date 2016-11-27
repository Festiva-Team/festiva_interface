/**
 * Funktionen zur Darstellung der Slideshow auf der Startseite des Kunden
 * 
 * @author Alina Fankhänel
 * 
 */

function zeigeBeschr(x) {
	document.getElementById('beschreibung'+x).style.visibility = "visible";
}

function entferneBeschr(x) {
	document.getElementById('beschreibung'+x).style.visibility = "hidden";
}

function plusSlides(n) {
    slideIndex = slideIndex + n;
    clearTimeout(timer);
    timer = 0;
    slide(slideIndex);
}

function slide(n) {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (n > x.length) {slideIndex = 1}
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    x[slideIndex-1].style.display = "block";
    timer = setTimeout("drehe()", 3000);
}

function drehe() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1}
    x[slideIndex-1].style.display = "block";
    timer = setTimeout("drehe()", 3000); 
}