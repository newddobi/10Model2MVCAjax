<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:set var="way" value="${list}"/>
	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
			�� ����
	</c:if>
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
			<a href="javascript:fncGet${param.what }List('${ resultPage.currentPage-1}')">�� ����</a>
	</c:if>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<a href="javascript:fncGet${param.what }List('${ i }');">${ i }</a>
	</c:forEach>
	
	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
			���� ��
	</c:if>
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
			<a href="javascript:fncGet${param.what }List('${resultPage.endUnitPage+1}')">���� ��</a>
	</c:if>