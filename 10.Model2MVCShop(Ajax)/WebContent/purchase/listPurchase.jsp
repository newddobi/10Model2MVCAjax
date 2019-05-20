<%@page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetPurchaseList(currentPage) {
		
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
	};
	
	$(function(){
		$("td.ct_btn01:contains('�˻�')").on("click", function(){
			fncGetPurchaseList(1);
		});
		
		$("td.deleteOrUpdate:contains('�������')").on("click", function(){
		
			if(confirm("���� ����Ͻðڽ��ϱ�?") == true){
				self.location="/purchase/updateTranCode?prodNo="
						+$(this).parent().find('.prodNo').text().trim()+"&tranCode=0";
			}else{
				return;
			};
		});
		
		$("td.deleteOrUpdate:contains('����ϱ�')").on("click", function(){
			
			if(confirm("����� �����Ͻðڽ��ϱ�?") == true){
				self.location="/purchase/updateTranCode?prodNo="
						+$(this).parent().find('.prodNo').text().trim()+"&tranCode=2";
			}else{
				return;
			}
		});
		
		$("td.deleteOrUpdate:contains('���Ű���')").on("click", function(){
			
			if(confirm("���Ÿ� �Ϸ��Ͻðڽ��ϱ�?") == true){
				self.location="/purchase/updateTranCode?prodNo="
						+$(this).parent().find('.prodNo').text().trim()+"&tranCode=1";
			}else{
				return;
			}
		});
		
		$("td.deleteOrUpdate:contains('�ı���')").on("click", function(){
			
			if(confirm("�ı⸦ ����Ͻðڽ��ϱ�?") == true){
				self.location="/product/addReviewView?prodNo="+$(this).parent().find('.prodNo').text().trim()+
						"&userId="+$(this).parent().find('.userId').text().trim();
			}else{
				return;
			}
		});
		
		
		$(".ct_list_pop td:nth-child(1)").on("click", function(){
			self.location="/purchase/getPurchase?tranNo="+$(this).parent().find('.tranNo').text().trim();
		});
		
		$(".ct_list_pop td:nth-child(9)").on("click", function(){
			self.location="/user/getUser?userId="+$(this).text().trim();
		});
		
		
		$(".ct_list_pop td:nth-child(1)" ).css("color" , "#0064FF");
		$(".ct_list_pop td:nth-child(9)" ).css("color" , "green");
		
		$(".ct_list_pop td:nth-child(19)" ).css("color" , "red");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop").on("mouseover",function(){
			$(this).css("background-color", "lavender");
		});
		$(".ct_list_pop").on("mouseout",function(){
			$(this).css("background-color", "");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});		
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:choose>
						<c:when test="${user.role == 'admin'}">
							<td width="93%" class="ct_ttl01">�� �� �� ��</td>
						</c:when>
						<c:when test="${user.role != 'admin'}">
							<td width="93%" class="ct_ttl01">���� �����ȸ</td>
						</c:when>
					</c:choose>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="19">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="120">
			No<br>
			<h7>(No click:������ȸ)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�ֹ���ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ǰ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			ȸ��ID<br>
			<h7>(ȸ��ID click:ȸ������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�ֹ��Ͻ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="19" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
		<c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${i+1}" />
			<tr class="ct_list_pop">
				<td align="center">
					${ i }
				</td>
				<td></td>
				<td align="center" class="tranNo">
					${purchase.tranNo }
				</td>
				<td></td>
				<td align="center" class="prodNo">
					${purchase.purchaseProd.prodNo}
				</td>
				<td></td>
				<td align="center">
					${purchase.purchaseProd.prodName}
				</td>
				<td></td>
				<td align="center" class="userId">
					${purchase.buyer.userId}
				</td>
				<td></td>
				<td align="center">
					<c:choose>
						<c:when test="${purchase.paymentOption eq '1'}">
							���ݱ���
						</c:when>
						<c:when test="${purchase.paymentOption eq '2'}">
							�ſ뱸��
						</c:when>
						
					</c:choose>
				</td>
				<td></td>
				<td align="center">
					<c:choose>
						<c:when test="${purchase.tranCode eq '3' }">
							���� ���ſϷ� �����Դϴ�.
						</c:when>
						<c:when test="${purchase.tranCode eq '2' }">
							���� ����� �Դϴ�.
						</c:when>
						<c:when test="${purchase.tranCode eq '1' }">
							�ŷ��� �Ϸ�Ǿ����ϴ�.
						</c:when>
						<c:when test="${purchase.tranCode eq '0' }">
							���� ��Ұ� �Ϸ�Ǿ����ϴ�.
						</c:when>
					</c:choose>
				</td>
				<td></td>
				<td align="center">
					${purchase.orderDate}
				</td>
				<td></td>
				<td align="center">
					${purchase.tranAmount}
				</td>
				<td></td>
				<td align="center" class="deleteOrUpdate">
					<input type="hidden" class="tranCode" name="tranCode" value="${purchase.tranCode}"/>
					<c:choose>
						<c:when test="${purchase.tranCode eq '3' }">
							<c:choose>
								<c:when test="${user.role == 'admin'}">
									����ϱ�
								</c:when>
								<c:when test="${user.role != 'admin'}">
									�������
								</c:when>
							</c:choose>				
						</c:when>
						<c:when test="${purchase.tranCode eq '2'}">
							<c:choose>
								<c:when test="${user.role == 'admin'}">
									��۽���
								</c:when>
								<c:when test="${user.role != 'admin'}">
									���Ű���
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${purchase.tranCode eq '1'}">
							<c:choose>
								<c:when test="${user.role == 'admin'}">
									�ŷ��Ϸ�
								</c:when>
								<c:when test="${user.role != 'admin'}">
									�ı���
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${purchase.tranCode eq '0'}">
							<c:choose>
								<c:when test="${user.role == 'admin'}">
									�ŷ����
								</c:when>
								<c:when test="${user.role != 'admin'}">
									�������
								</c:when>
							</c:choose>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="19" bgcolor="D6D7D6" height="1"></td>
			</tr>	
		</c:forEach>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>

			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="what" value="Purchase"/>
			</jsp:include>	
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>