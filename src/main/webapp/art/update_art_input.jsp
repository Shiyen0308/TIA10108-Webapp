<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.art.model.*,java.sql.Timestamp,java.util.Date,java.text.SimpleDateFormat"%>

<% //見com.emp.controller.EmpServlet.java第163行存入req的empVO物件 (此為從資料庫取出的empVO, 也可以是輸入格式有錯誤時的empVO物件)
	ArtVO artVO = (ArtVO) request.getAttribute("artVO");
	//獲取當前時間
	Date currentDate = new Date();
	// 將當前時間轉換為 Timestamp 對象
	Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
	 // 定義時間戳格式
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String formattedTimestamp = sdf.format(currentTimestamp);
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - update_art_input.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>員工資料修改 - update_art_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="art.do" name="form1">
<table>
	<tr>
		<td>文章編號:<font color=red><b>*</b></font></td>
		<td><%=artVO.getArtId()%></td>
	</tr>
	<tr>
		<td>文章標題:</td>
		<td><input type="TEXT" name="artTitle" value="<%=artVO.getArtTitle()%>" size="45"/></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td><input type="TEXT" name="artContent"   value="<%=artVO.getArtContent()%>" size="45"/></td>
	</tr>
	<tr>
		<td>發文時間:</td>
		<td><input name="artTimestamp"  type="text" value="<%=formattedTimestamp%>" size="45"/> </td> 
	</tr>
	<tr>
		<td>回覆文章標號:</td>
		<td><input name="artReply"  type="text" value="<%=artVO.getArtReply()%>" size="45"/></td>
	</tr>
	<tr>
		<td>收藏數:</td>
		<td><input name="artFavor"  type="text" value="<%=artVO.getArtFavor()%>" size="45"/></td>
	</tr>
	<tr>
		<td>瀏覽數:</td>
		<td><input name="artView"  type="text" value="<%=artVO.getArtView()%>" size="45"/></td>
	</tr>

	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="artId" value="<%=artVO.getArtId()%>">
<input type="submit" value="送出修改"></FORM>
</body>




</html>