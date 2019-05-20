<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>상품 목록조회</title>
	
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

	function fncGetReviewList(currentPage){
		
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listReview").submit();
		
	};

	window.$(function(){
		
		$("td.ct_btn01:contains('검색')").on("click", function(){
			fncGetReviewList(1);
		});
		
		
		$(".ct_list_pop td:nth-child(3)" ).css("color" , "royalblue");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop").on("mouseover",function(){
			$(this).css("background-color", "lavender");
		});
		
		$(".ct_list_pop").on("mouseout",function(){
			$(this).css("background-color", "");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});		
		
		$(".ct_list_pop td:nth-child(3)").on("click",function(){
			var reviewNo = $(this).find("#reviewNo").val();
			console.log(reviewNo);
			$.ajax({
				url:"/product/json/getReview/"+reviewNo,
				method:"GET",
				dataType:"json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData,status){
					var displayValue = "<div id='title'>"+JSONData.content+"</div>";
					$("#title").remove();
					$("#"+reviewNo+"").html(displayValue);
				}
			});
		});
	});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">
			
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품후기</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td>
			<select name="pageCondition" class="ct_input_g" style="width:80px">
				<option value="" ${ ! empty search.pageSize && search.pageSize.equals("") ? "selected" : "" }>게시물개수</option>
				<option value="4" ${ ! empty search.pageSize && search.pageSize==4 ? "selected" : "" }>4</option>
				<option value="5" ${ ! empty search.pageSize && search.pageSize==5 ? "selected" : "" }>5</option>
				<option value="6" ${ ! empty search.pageSize && search.pageSize==6 ? "selected" : "" }>6</option>
				<option value="7" ${ ! empty search.pageSize && search.pageSize==7 ? "selected" : "" }>7</option>
				<option value="8" ${ ! empty search.pageSize && search.pageSize==8 ? "selected" : "" }>8</option>
				<option value="9" ${ ! empty search.pageSize && search.pageSize==9 ? "selected" : "" }>9</option>
				<option value="10" ${ ! empty search.pageSize && search.pageSize==10 ? "selected" : "" }>10</option>
			</select>
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount } 건수, 현재  ${resultPage.currentPage } 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="80">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">제목<br>
			<h7>(제목 click:후기보기)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">아이디</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
	<c:forEach var="review" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>			
			<td align="center">${review.title}
				<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo}"/>
			</td>
			<td></td>
			<td align="center">${review.userId}</td>
			<td></td>
			<td align="center">${review.reviewDate}</td>	
		</tr>
		<tr>
			<td id="${review.reviewNo}" colspan="11" bgcolor="#E8F5FF" height="1"></td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="what" value="Review"/>
			</jsp:include>	
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>

