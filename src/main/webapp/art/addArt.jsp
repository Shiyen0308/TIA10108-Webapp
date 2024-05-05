<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.art.model.*,java.sql.Timestamp,java.util.Date,java.text.SimpleDateFormat"%>

<% //見com.emp.controller.EmpServlet.java第238行存入req的empVO物件 (此為輸入格式有錯誤時的empVO物件)
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
<title>員工資料新增 - addArt.jsp</title>

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
		 <h3>員工資料新增 - addArt.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

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
		<td>文章標題:</td>
		<td><input type="TEXT" name="artTitle" value="<%= (artVO==null)? "文章標題" : artVO.getArtTitle()%>" size="45"/></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td><input type="TEXT" name="artContent"   value="<%= (artVO==null)? "文章內容" : artVO.getArtContent()%>" size="45"/></td>
	</tr>
	<tr>
		<td>發表時間:</td>
		<td><input name="artTimeStamp"  type="text"value="<%= formattedTimestamp %>" size="45"/>  
		</td>
	</tr>
	<tr>
		<td>回覆</td>
		<td><input type="TEXT" name="artReply"   value="<%= (artVO==null)? null : artVO.getArtReply()%>" size="45"/></td>
	</tr>
	<tr>
		<td>收藏數</td>
		<td><input type="TEXT" name="artFavor"  value="<%= (artVO==null)? "1" : artVO.getArtFavor()%>" size="45"/></td>
	</tr>
	<tr>
		<td>瀏覽數</td>
		<td><input type="TEXT" name="artView"  value="<%= (artVO==null)? "1" : artVO.getArtView()%>" size="45"/></td>
	</tr>

	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

</body>





        

</html>