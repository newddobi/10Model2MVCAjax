<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>��ǰ �����ȸ</title>
	
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

	function fncGetProductList(currentPage){
		
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu eq 'manage' ? 'manage':'search'}").submit();
		
	};

	window.$(function(){
		$("input[name='searchKeyword']").on("keyup",function(){
			var searchCondition = $("#searchCondition").val();
			console.log(searchCondition);
			$.ajax({
				url:"/product/json/listProduct2/"+searchCondition,
				method:"POST",
				dataType:"json",
				headers:{
					"Accept" : "application/json",
					"Content-Type" : "application/json"					
				},
				success : function(JSONData, status){
// 					alert(typeof(JSONData));
// 					alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
					var jsonArray = $.parseJSON(JSON.stringify(JSONData));
					$("#searchKeyword").autocomplete({
						source:jsonArray
					});
				}
			});
		});
		
		$("td.ct_btn01:contains('�˻�')").on("click", function(){
			fncGetProductList(1);
		});
		
		$("td.addZzim:contains('���ϱ�')").on("click", function(){
			if(confirm("�� ��Ͽ� �����ðڽ��ϱ�?") == true){
				
				$("#prodNo").val($(this).parent().find('.prodNo').text().trim());
				$("form").attr("method","POST").attr("action", "/product/addZzim?userId=${user.userId}").submit();
	
			}else{
				return;
			};
		});
	
		$(".ct_list_pop td:nth-child(5)").on("click", function(){
			if(${param.menu eq 'manage'}){
				self.location="/product/updateProductView?prodNo="+$(this).parent().find('.prodNo').text().trim()+"&menu=manage";	
			}else{
				self.location="/product/getProduct?prodNo="+$(this).parent().find('.prodNo').text().trim()+"&menu=search";
			};
		});
		
		$(".ct_list_pop td:nth-child(5)" ).css("color" , "royalblue");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop").on("mouseover",function(){
			$(this).css("background-color", "lavender");
		});
		
		$(".ct_list_pop").on("mouseout",function(){
			$(this).css("background-color", "");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});		
		
		$(".ct_list_pop td:nth-child(5)").on("mouseover",function(){
			var prodNo = $(this).parent().find(".prodNo").text().trim();
			$.ajax({
				url:"/product/json/getProduct/"+prodNo,
				method:"GET",
				dataType:"json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData,status){
					var displayValue = "<img src ='/images/uploadFiles/"+JSONData.fileName+"'/>";
					$("img").remove();
					$("#"+prodNo+"").html(displayValue);
				}
			});
		});
		
		
	});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">
			
<form name="detailForm">
<input type="hidden" id="prodNo" name="prodNo" value="">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<c:choose>
						<c:when test="${param.menu eq 'manage'}">
							��ǰ ����
						</c:when>
						<c:when test="${param.menu eq 'search'}">
							��ǰ��� ��ȸ
						</c:when>
					</c:choose>
					</td>
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
				<option value="" ${ ! empty search.pageSize && search.pageSize.equals("") ? "selected" : "" }>�Խù�����</option>
				<option value="4" ${ ! empty search.pageSize && search.pageSize==4 ? "selected" : "" }>4</option>
				<option value="5" ${ ! empty search.pageSize && search.pageSize==5 ? "selected" : "" }>5</option>
				<option value="6" ${ ! empty search.pageSize && search.pageSize==6 ? "selected" : "" }>6</option>
				<option value="7" ${ ! empty search.pageSize && search.pageSize==7 ? "selected" : "" }>7</option>
				<option value="8" ${ ! empty search.pageSize && search.pageSize==8 ? "selected" : "" }>8</option>
				<option value="9" ${ ! empty search.pageSize && search.pageSize==9 ? "selected" : "" }>9</option>
				<option value="10" ${ ! empty search.pageSize && search.pageSize==10 ? "selected" : "" }>10</option>
			</select>
		</td>
		<td align="right">
			<select name="orderCondition" class="ct_input_g" style="width:80px">
				<option value="" ${ ! empty search.orderCondition && search.orderCondition.equals("") ? "selected" : "" }>���þ���</option>
				<option value="1" ${ ! empty search.orderCondition && search.orderCondition==1 ? "selected" : "" }>�ֱٻ�ǰ</option>
				<option value="2" ${ ! empty search.orderCondition && search.orderCondition==2 ? "selected" : "" }>���ݳ�����</option>
				<option value="3" ${ ! empty search.orderCondition && search.orderCondition==3 ? "selected" : "" }>���ݳ�����</option>
				<option value="4" ${ ! empty search.orderCondition && search.orderCondition==4 ? "selected" : "" }>��ȸ����</option>
			</select>
			<select name="searchCondition" id="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword" value="${! empty search.searchCondition ? search.searchKeyword : "" }" class="ct_input_g" style="width:200px; height:19px" />
		</td>	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
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
		<td align="right">
			���ݴ�� ã��
			<input type="text" name="searchMin" value="${! empty search.searchMin ? search.searchMin : "" }" class="ct_input_g" style="width:70px; height:19px" />
			-
			<input type="text" name="searchMax" value="${! empty search.searchMax ? search.searchMax : "" }" class="ct_input_g" style="width:70px; height:19px" />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount } �Ǽ�, ����  ${resultPage.currentPage } ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="80">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="80">��ǰ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">
			��ǰ��<br>
			<c:if test="${user.userId != 'admin'}">
				<h7>(��ǰ�� click:������)</h7>
			</c:if>
			<c:if test="${user.userId == 'admin'}">
				<h7>(��ǰ�� click:��ǰ����)</h7>
			</c:if>
			
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">���</td>		
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>			
			<td align="center" class="prodNo">${product.prodNo}</td>
			<td></td>
			<td align="center">${product.prodName}</td>
			<td></td>
			<td align="center">${product.price}</td>
			<td></td>
			<td align="center">${product.amount}</td>
			<td></td>
			<td align="center" class="addZzim">
				<c:choose>
					<c:when test="${product.amount != 0}">
						�Ǹ���&nbsp;
							<c:if test="${user.userId != 'admin' }">
								���ϱ�
							</c:if>
						</c:when>
					<c:otherwise>
						������
					</c:otherwise>	
				</c:choose>
			</td>	
		</tr>
		<tr>
			<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="what" value="Product"/>
			</jsp:include>	
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>

