<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="it.pwproject.javabean.UserBean
    ,it.pwproject.javabean.ProductBean"%>
    <%@ page import="java.util.ArrayList"%>
<%
	ArrayList<String> categories=(ArrayList<String>)request.getAttribute("categories");
	if(categories==null){
		categories=new ArrayList<String>();
		categories.add("Senza categoria");
	}
	ArrayList<ProductBean> prodotti=(ArrayList<ProductBean>)request.getAttribute("allProduct");
%>
<%
UserBean user = (UserBean) session.getAttribute("user");
if (user==null || !user.getTipo().equals("puntovendita"))
{	
    response.sendRedirect("pagecomposer?responsepage=login");
    return;
}
%>
<!DOCTYPE html>
<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Asfalti Tuozzo Snc</title>
        <link href="style\static\responsiveCSS\header_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\responsiveCSS\footer_resp.css" type="text/css">
    <link href="style\static\responsiveCSS\left_bar_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\responsiveCSS\dynamic_content_resp.css" rel="stylesheet" type="text/css">
    <link href="style\static\header.css" rel="stylesheet" type="text/css">
    <link href="style\static\aside.css" rel="stylesheet" type="text/css">
    <link href="style\static\footer.css" rel="stylesheet" type="text/css">
    <link href="style\puntovendita\dynamic_content_puntovendita_modifyproduct.css" rel="stylesheet" type="text/css">
    <link href="style\static\main_page.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="script\ajax.js"></script>
</head>
<body >
	<div class="main_content">
		<header class="main_header"> <img alt="header_logo"
			id="header_logo" src="img\static\header\header_logo.jpg">
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
				<h1 id="title">Modifica prodotto</h1>
				<div id="select_product">
					<form id="mod"  action="javascript:modProduct()"  method="get">
						<label>Prodotto: </label>
						<select name="prodotto" onchange="showProprieties(this)" id="c_prod">
							<option value="" ></option>
							<%for(ProductBean p:prodotti){ %>	
							<option value="<%=p.getCodiceProdotto()%>"><%=p.getCodiceProdotto()%></option>
							<%} %>
						</select>
						<p class="form_element" id="proprietà">
							<label>Proprietà: </label>
							<select onchange="showInput(this)" id="p_select">
								<option></option>
								<option value="CodiceProdotto">Codice</option>
								<option value="Descrizione">Descrizione</option>
								<option value="Aliquota">Aliquota</option>
								<option value="PrezzoDiVendita">Prezzo</option>
								<option value="Categoria">Categoria</option>
								<option value="UnitaDiMisura">Unità di misura</option>
							</select>
						</p>	
						<p class="form_element" id="CodiceProdotto">
							<label>Codice Prodotto: </label>
							<input type="text" maxlength="10" name="CodiceProdotto" placeholder="Codice prodotto">
						</p>		
						<p class="form_element" id="PrezzoDiVendita">
							<label>Prezzo di acquisto: </label>
							<input type="number" min="0" name="PrezzoDiVendita" placeholder="Prezzo di vendita">
						</p>
						<p class="form_element" id="Aliquota">
							<label>Aliquota: </label>
							<select name="Aliquota" >
								<option value="4.00">4%</option>
								<option value="10.00">10%</option>
								<option value="22.00">22%</option>
							</select>
						</p>
						<p class="form_element" id="UnitaDiMisura">
							<label>Unità di misura: </label>
							<select name="UnitaDiMisura" required="required">
								<option value="Pz">Pezzo</option>
								<option value="Kg">Chilo</option>
								<option value="Lt">Litro</option>
								<option value="Mq">Metro quadro</option>
								<option value="Ml">Millilitro</option>
								<option value="Rt">Rotoli</option>
							</select>
						</p>
						<div class="form_element" id="Descrizione" >	
							<p>Descrizione: </p>
							<textarea  rows="5" cols="35" name="Descrizione" 
							placeholder="Inserisci una descrizione" maxlength="100"></textarea>
						</div>				
						<p class="form_element" id="Categoria">
							<label>Categoria: </label>					
							<input type="text" name="Categoria" maxlength="20" value="Senza Categoria">
						</p>
						<p class="form_element" id="submit">
							<input type="submit" value="Aggiorna" >
						</p>
					</form>
				</div>	
			</div>
			<aside class="left_bar" >
			<h3>Prodotti</h3>
			<hr>
			<ul id="left_bar_list">
				<%for(Object cat: categories){ %>
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
	<script type="text/javascript">
		function showProprieties(select){
			var prod=select.options[select.selectedIndex].value;
			var prop=document.getElementById("proprietà")
			if(prod!=""){
				prop.style.display="block";
			}
			else{
				prop.style.display="none";
				document.getElementById("submit").style.display="none";
				var visibleElements=document.getElementsByClassName("visible");
				var len=visibleElements.length;
				for(var i=0;i<len;i++)
					visibleElements[i].setAttribute("class","form_element")
					var finish=document.getElementById("finish");
					if(finish!=null) (document.getElementsByClassName("dynamic_content")[0]).removeChild(finish);
			}
		}
		function showInput(select){
			var prop=select.options[select.selectedIndex].value;
			var visibleElements=document.getElementsByClassName("visible");
			var len=visibleElements.length;
			for(var i=0;i<len;i++)
				visibleElements[i].setAttribute("class","form_element");
			document.getElementById("submit").style.display="block";
			var newActive=document.getElementById(prop);
			if(newActive!=null)
				newActive.setAttribute("class","visible");
			if(prop==""){
				document.getElementById("submit").style.display="none";
				var finish=document.getElementById("finish");
				if(finish!=null) (document.getElementsByClassName("dynamic_content")[0]).removeChild(finish);	
			}
		}
		function modProduct(form){
			var finish=document.getElementById("finish");
			if(finish!=null) (document.getElementsByClassName("dynamic_content")[0]).removeChild(finish);
			var selCP=document.getElementById("c_prod");
			var codP=selCP.options[selCP.selectedIndex].value;
			var selPr=document.getElementById("p_select");
			var prop=selPr.options[selPr.selectedIndex].value;
			var f=document.getElementById(prop);
			var form=document.getElementById("mod");
			var input=form.getElementsByTagName("input");
			var select=form.getElementsByTagName("select");
			var textarea=form.getElementsByTagName("textarea");
			var number=form.getElementsByTagName("number");
			var value=null;
			if(number[prop]!=null)
				value=(number[prop].value);
			if(input[prop]!=null)
				value=(input[prop].value);
			if(select[prop]!=null)
				value=((select[prop]).options[(select[prop]).selectedIndex].value);
			if(textarea[prop]!=null)
				value=(textarea[prop].value);
			if(value!=null){
				var mod='{"id":"'+codP+'","prop":"'+prop+'","value":"'+value+'"}';
				var obj=JSON.parse(mod);
				var jsonS=JSON.stringify(obj)
				encodeURIComponent(mod);
				var xhttp=getXmlHttpRequest();
				xhttp.onreadystatechange=function(){
					if(xhttp.readyState==4 && xhttp.status==200){
						var text=xhttp.responseText;
						var newP=document.createElement("p");
						newP.setAttribute("id","finish");
						newP.appendChild(document.createTextNode(text));
						var parent=document.getElementsByClassName("dynamic_content")[0];
						parent.insertBefore(newP, document.getElementById("select_product"));
					}			
				};
				xhttp.open("GET","updateProductProp?obj="+jsonS,true);
				xhttp.send();
			}
		}
	</script>
</body>
</html>