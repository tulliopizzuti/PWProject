<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,it.pwproject.javabean.UserBean"%>
<%
	ArrayList<String> categories=(ArrayList<String>)request.getAttribute("categories");
	if(categories==null){
		categories=new ArrayList<String>();
		categories.add("Senza categoria");
	}
	String error=(String)session.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Asfalti Tuozzo Snc</title>
        <link href="style\static\responsiveCSS\header_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\responsiveCSS\footer_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\responsiveCSS\left_bar_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\responsiveCSS\dynamic_content_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\header.css" rel="stylesheet" type="text/css">
    <link href="style\static\aside.css" rel="stylesheet" type="text/css">
    <link href="style\static\footer.css" rel="stylesheet" type="text/css">
    <link href="style\login\dynamic_content_login.css" rel="stylesheet" type="text/css">
    <link href="style\static\main_page.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="main_content">
		<header class="main_header"> 
		<img alt="header_logo" id="header_logo" src="img\static\header\header_logo.jpg">
		<div class="header_nav">
			<nav id="nav_bar">
			<div>
				<a href="./pagecomposer?responsepage=index">HOME</a>
			</div>
			<div>
				<a href="./pagecomposer?responsepage=azienda">AZIENDA</a>
			</div>
			<div>
				<a href="./pagecomposer?responsepage=services">SERVIZI</a>
			</div>
			<div>
				<a href="./pagecomposer?responsepage=gallery">GALLERY</a>
			</div>
			 <div>
			 	<a href="./pagecomposer?responsepage=prodotti&searchcat=all">PRODOTTI</a>
			 </div>
              <div class="button_list">
                 <ul>
                 	<li>
                 		<% String userPage;
                 			if(session.getAttribute("user")!=null)
                 				userPage="PROFILO";
                 			else
                 				userPage="LOGIN";
                 		%>
                        <a href="./pagecomposer?responsepage=login"><%=userPage%></a>  
                      	<% /* Se non si � loggato mostra, altrimenti non mostrare */ %>
                        <%if(session.getAttribute("user")==null) {%>
                        <ul>
                           	<li><a href="./pagecomposer?responsepage=login">ACCEDI</a></li>
                            <li><a href="./pagecomposer?responsepage=registrazione">REGISTRATI</a></li>
                        </ul>
                        <%} %>
                        </li>
                 </ul>
			</div>
			<%if( session.getAttribute("user")!=null){%>
			<%if(((UserBean)session.getAttribute("user")).getTipo().equals("user")){ %>
			<div>
				<a href="./pagecomposer?responsepage=carrello">CARRELLO</a>
			</div>
			<%}} %>
			</nav>
		</div>
		</header>
		<div class="main_page">
			<div class="dynamic_content"> 
				<form id="login_form" action="login" method="post">
					<div id="username">
						<label>Username: </label><input type="text" name="username" placeholder="E-mail" required="required">
					</div>    
					<div id="password">
						<label>Password: </label><input type="password" autocomplete="off" name="password" placeholder="Password" value="" required="required">
					</div>
					<div id="form_button">
						<input type="submit" value="Accedi">
						<input type="reset" value="Azzera">
					</div>
					<%if(error!=null){ %>
					<div>
						<p><%=error	%></p>
					</div>
					<%} %>
				</form>
			</div>
			<aside class="left_bar" >
			<h3>Prodotti</h3>
			<hr>
			<ul id="left_bar_list">
				<%for(String cat: categories){ %>
				<li><a href="pagecomposer?responsepage=prodotti&searchcat=<%=cat%>"><%=cat %></a></li>
				<%}%>
			</ul>
			</aside>
		</div>
		<footer class="main_footer">
		<h3 id="footer_title">I nostri marchi</h3>
		<hr>
		<div id="footer_brand">
			<img alt="logo" src="img\static\footer\images.jpg"> <img
				alt="logo" src="img\static\footer\caparol.jpg"> <img alt="logo"
				src="img\static\footer\siniat.png"> <img alt="logo"
				src="img\static\footer\naturalia bau.jpg"> <img alt="logo"
				src="img\static\footer\faelux.png"> <img alt="logo"
				src="img\static\footer\alutherm.jpg"> <img alt="logo"
				src="img\static\footer\naici.jpg"> <img alt="logo"
				src="img\static\footer\rockwool.jpg">
		</div>
		</footer>
	</div>
</body>
</html>