$(function(){
  init();
});

$(window).load(function () {
	show_content();
});


function init(){
	//アンカーリンク
	init_anc($('a[href^=#]'));
	
	//ToTop
	$(window).scroll(function () {
		update_totop();
	}).scroll;
	
	//Page Now
	if(typeof(pageID) != "undefined") {
		var menu_now = $("#"+pageID);
		menu_now.addClass("now");
	}
}

//アンカーリンク
function init_anc(obj){
	obj.click(function() {
		var speed = 800;
		var href= $(this).attr("href");
		var target = $(href == "#" || href == "" ? 'html' : href);
		var position = target.offset().top-50;
		if(position < 0) { position = 0; }
		$('body,html').animate({scrollTop:position}, speed, 'easeOutQuint');
		return false;
	});
}

//ページロード完了
function show_content(){
	var obj = $("#wrap");
	obj.addClass("show");
}

//ToTop
function update_totop(){
	var obj = $("#totop");
	var scrTop = $(window).scrollTop();
	var show_h_e = Math.round($(window).height()*0.5);
	if(scrTop > show_h_e) {
		obj.addClass("show");
	} else {
		obj.removeClass("show");
	}
}

//debug
function trace(msg) {
	if (('console' in window)) {
		console.log(msg);
	}
}

//GA
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-92407908-3', 'auto');
ga('send', 'pageview');








