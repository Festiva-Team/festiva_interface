/**
 *  fdhkjlfdfdhjlkdshl
 */

var imagecount =1;
var total = 5;
function slide(x){
	var Image = document.getElementById('img');
	imagecount = imagecount + x;
	Image.src = "/Festiva/Bilder" + imagecount + ".jpg";
}