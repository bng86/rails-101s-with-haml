var fullHeight = $(window).outerHeight();
var headerHeight = $("nav").outerHeight();
var footerHeight = $("footer").outerHeight();
var originContenHeight = $(".content").outerHeight();
var outer = 40;
var bodyHeight = fullHeight - headerHeight - footerHeight - outer;
if(bodyHeight > originContenHeight){
	$(".content").outerHeight(bodyHeight);
}else{

}
