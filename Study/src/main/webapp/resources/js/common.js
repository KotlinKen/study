//테이블 hover용
$(function() {
	$(".rm_table tr").on("mouseover", function() {
		$(".rm_table tr").not(this).css({
			"background-color" : "#fff"
		})
		$(this).css({
			"background-color" : "#f6f8fa"
		});
		
		console.log("test");
	});
});