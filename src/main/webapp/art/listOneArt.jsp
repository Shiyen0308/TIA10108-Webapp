<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.art.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ArtVO artVO = (ArtVO) request.getAttribute("artVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>員工資料 - listOneArt.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOneArt.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>文章編號</th>
		<th>文章標題</th>
		<th>文章內容</th>
		<th>發文時間</th>
		<th>回覆文章編號</th>
		<th>收藏數</th>
		<th>瀏覽數</th>
	</tr>
	<tr>
		<td><%=artVO.getArtId()%></td>
		<td><%=artVO.getArtTitle()%></td>
		<td><%=artVO.getArtContent()%></td>
		<td><%=artVO.getArtTimestamp()%></td>
		<td><%=artVO.getArtReply()%></td>
		<td><%=artVO.getArtFavor()%></td>
		<td><%=artVO.getArtView()%></td>
	</tr>
</table>

</body>
</html>