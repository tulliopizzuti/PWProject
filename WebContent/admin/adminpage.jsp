<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,it.pwproject.javabean.OrderBean"%>
<%
	ArrayList<OrderBean> orders=(ArrayList<OrderBean>)request.getAttribute("orders");
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modifica stato ordini</title>
<link href="./css/adminpage.css" rel="stylesheet">
<script type="text/javascript" src="../script/ajax.js"></script>
</head>
<body>
	<h1>Modifica stato ordini</h1>
	<table id="main_table">
		<caption>Tabella ordini</caption>
		<tr>
			<th>Codice vendita</th>
			<th>Id cliente </th>
			<th>Data Ordine </th>
			<th>Sconto </th>
			<th>Totale </th>
			<th>Status </th>
		</tr>
		<%for(OrderBean order:orders){ %>
			<tr >
				<td><%=order.getCodice()%></td>
				<td><%=order.getIdCliente()%></td>
				<td><%=order.getData()%></td>
				<td><%=order.getSconto()%>%</td>
				<td><%=order.getTotale()%></td>
				<td><%=order.getStatus()%></td>
				<td>
					<select id="<%=order.getCodice() %>" onchange="changestat(this)">
							<option value=""></option>
							<option value="1">In elaborazione</option>
							<option value="2">Spedito</option>
							<option value="3">Consegnato</option>
					</select>
				</td>
			</tr>	
		<%} %>
	</table>
</body>
<script type="text/javascript">
	function changestat(select){
		var value=select.options[select.selectedIndex].value;
		if(value!=""){
			var codP=select.getAttribute("id");
			var xhttp=getXmlHttpRequest();
			xhttp.onreadystatechange=function(){
				if(xhttp.readyState==4 && xhttp.status==200){
					location.href="index";
				}
			};
			xhttp.open("GET","../adminServlet/updatestatus?id="+codP+"&value="+value,true);
			xhttp.send();
		}
	}



</script>
</html>