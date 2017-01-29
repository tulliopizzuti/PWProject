package it.pwproject.DBAccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import it.pwproject.javabean.CartBean;
import it.pwproject.javabean.ComposizioneVenditaBean;
import it.pwproject.javabean.OrderBean;
import it.pwproject.javabean.ProductBean;
import it.pwproject.javabean.PuntoVenditaBean;
import it.pwproject.javabean.UserBean;

public class DBInformation implements GetInformation{
	@Override
	public synchronized ArrayList<PuntoVenditaBean> getPuntiVendita() {
		Connection connection = null;
		ArrayList<PuntoVenditaBean>puntiVendita=new ArrayList<PuntoVenditaBean>();
		String selectPV="select * from PuntoVendita;";
		Statement cat=null;
		try {
			connection = DriverMangerConnectionPool.getConnection();
			connection.commit();
			cat=connection.createStatement();
			ResultSet rs=cat.executeQuery(selectPV);
			while(rs.next()){
				puntiVendita.add(new PuntoVenditaBean(
						rs.getString("PartitaIva"),
						rs.getString("Nome"),
						rs.getString("Via"),
						rs.getString("N°Civico"),
						rs.getString("CAP"),
						rs.getString("Città"),	
						rs.getString("N°Telefono"),
						rs.getString("Email")	
						));
			}
			rs.close();
			cat.close();
		} 
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally {
			try {				
				DriverMangerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return puntiVendita;
	}

	@Override
	public synchronized ArrayList<String> getCategories() {
		ArrayList<String> categories=new ArrayList<String>();
		Connection connection=null;
		String selectCat="select distinct categoria from prodotti;";
		try {
			connection = DriverMangerConnectionPool.getConnection();
			connection.commit();
			Statement cat=connection.createStatement();
			ResultSet rs=cat.executeQuery(selectCat);
			while(rs.next()){
				categories.add(rs.getString("Categoria"));
			}
			rs.close();
			cat.close();
		}
		catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
		}
		finally {
				try {
					DriverMangerConnectionPool.releaseConnection(connection);
				} catch (SQLException e) {
					System.out.println("SQLError: "+e.getMessage());
				}
		}
		return categories;
	}
	
	public synchronized ArrayList<ProductBean> getAllProduct(){
		ArrayList<ProductBean> allProducts=new ArrayList<ProductBean>();
		Connection connection = null;
		String getAll="SELECT  Prodotti.CodiceProdotto,Prodotti.PrezzoDiVendita,"
				+ "Prodotti.Aliquota, prodotti.UnitaDiMisura,prodotti.PrezzoDiAcquisto,"
				+ "prodotti.Categoria,prodotti.Descrizione,"
				+ "SUM(hadisponibilitadi.Quantita) AS Quantita  "
				+ "FROM (prodotti,hadisponibilitadi) "
				+ " where (prodotti.CodiceProdotto=hadisponibilitadi.CodiceProdotto) "
				+ "group by prodotti.CodiceProdotto;";
		try{
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			Statement st=connection.createStatement();
			ResultSet rs=st.executeQuery(getAll);
			while(rs.next()){
				allProducts.add(new ProductBean(
						rs.getString("CodiceProdotto"),
						rs.getFloat("PrezzoDiAcquisto"),
						rs.getFloat("PrezzoDiVendita"),
						rs.getString("Aliquota"),
						rs.getString("UnitaDiMisura"),
						rs.getString("Categoria"),
						rs.getString("Descrizione"),
						rs.getFloat("Quantita")
						));
			}
			rs.close();
			st.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return allProducts;
	}
	
	public synchronized ProductBean getProductById(String id){
		String sql="SELECT *,SUM(QUANTITA) as totale FROM Prodotti,HaDisponibilitaDi "
				+ "WHERE Prodotti.CodiceProdotto=? AND HaDisponibilitaDi.CodiceProdotto=?;";
		ProductBean product=null;
		Connection connection=null;
		try{
			connection= DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				product=new ProductBean(rs.getString("CodiceProdotto"),
						rs.getFloat("PrezzoDiAcquisto"),
						rs.getFloat("PrezzoDiVendita"),
						rs.getString("Aliquota"),
						rs.getString("UnitaDiMisura"),
						rs.getString("Categoria"),
						rs.getString("Descrizione"),
						rs.getFloat("totale"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return null;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return product;
	}
	public synchronized ArrayList<ProductBean> getProductByCategory(String category){
		ArrayList<ProductBean> products=new ArrayList<ProductBean>();
		Connection connection = null;
		String getByCat="SELECT  Prodotti.CodiceProdotto,Prodotti.PrezzoDiVendita,"
				+ "Prodotti.Aliquota, prodotti.UnitaDiMisura,"
				+ "prodotti.Categoria,prodotti.Descrizione,prodotti.PrezzoDiAcquisto,"
				+ "SUM(hadisponibilitadi.Quantita) AS Quantita  "
				+ "FROM (prodotti,hadisponibilitadi) "
				+ " where (prodotti.CodiceProdotto=hadisponibilitadi.CodiceProdotto) "
				+ "and (prodotti.descrizione like \"%"+category+"%\" or "
				+ "prodotti.categoria like  \"%"+category+"%\")"
				+"group by prodotti.CodiceProdotto;";
		try{
			connection=DriverMangerConnectionPool.getConnection();
			
			connection.commit();
			Statement st=connection.createStatement();
			ResultSet rs=st.executeQuery(getByCat);
			while(rs.next()){
				products.add(new ProductBean(
						rs.getString("CodiceProdotto"),
						rs.getFloat("PrezzoDiAcquisto"),
						rs.getFloat("PrezzoDiVendita"),
						rs.getString("Aliquota"),
						rs.getString("UnitaDiMisura"),
						rs.getString("Categoria"),
						rs.getString("Descrizione"),
						rs.getFloat("Quantita")
						));
			}
			rs.close();
			st.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return products;
	}

	@Override
	public synchronized UserBean checkUser(String username, String password) {
		UserBean user=null;
		Connection connection=null;
		String check="SELECT * FROM Cliente WHERE"
				+" email=? and password=?;";
		try{
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement ps=connection.prepareStatement(check);
			ps.setString(1, username);
			ps.setString(2,password);
			ResultSet rs=ps.executeQuery();
			if(rs!=null && rs.next()){
				user=new UserBean(rs.getString("CodiceCliente"),
						rs.getString("Nome"),
						rs.getString("Cognome"),
						rs.getString("Città"),
						rs.getString("Via"),
						rs.getString("CAP"),
						rs.getString("PartitaIva"),
						rs.getString("Email"),
						rs.getInt("N°Civico"),
						rs.getString("N°Telefono"),
						"user");
			}
			else{
				check="SELECT * FROM PuntoVendita WHERE"
						+" email=? and password=?;";
				ps=connection.prepareStatement(check);
				ps.setString(1, username);
				ps.setString(2,password);
				rs=ps.executeQuery();
				if(rs!=null && rs.next()){
					user=new UserBean(rs.getString("PartitaIva"),
							rs.getString("Nome"),
							null,
							rs.getString("Città"),
							rs.getString("Via"),
							rs.getString("CAP"),
							null,
							rs.getString("Email"),
							rs.getInt("N°Civico"),
							rs.getString("N°Telefono"),
							"puntovendita");
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally{
			try{
			
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		
		return user;
	}

	@Override
	public synchronized ArrayList<OrderBean> getOrderByUserId(int userId) {
		Connection connection=null;
		ArrayList<OrderBean> orders=new ArrayList<OrderBean>();
		ArrayList<ComposizioneVenditaBean> composition=new ArrayList<ComposizioneVenditaBean>();
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			String getVendite="SELECT * FROM VENDITA WHERE IdCliente=?;";
			String getItem="SELECT * FROM ComposizioneVendita WHERE CodiceVendita=?;";
			PreparedStatement psgetVendite=connection.prepareStatement(getVendite);
			psgetVendite.setInt(1, userId);
			ResultSet rsVendite=psgetVendite.executeQuery();
			while(rsVendite.next()){
				int codiceVendita=rsVendite.getInt("CodiceVendita");
				PreparedStatement psgetItem=connection.prepareStatement(getItem);
				psgetItem.setInt(1,codiceVendita);
				ResultSet rsGetItem=psgetItem.executeQuery();
				while(rsGetItem.next()){
					composition.add(new ComposizioneVenditaBean(
							getProductById(rsGetItem.getString("CodiceProdotto")), 
							rsGetItem.getFloat("Quantita"), 
							rsGetItem.getFloat("PrezzoEffettivo")));
				}
				orders.add(new OrderBean(codiceVendita,
						rsVendite.getDate("DataVendita"), 
						rsVendite.getFloat("Totale"), 
						rsVendite.getInt("IdCliente"), 
						rsVendite.getFloat("Sconto"), 
						composition, 
						rsVendite.getString("Status")));
				composition=new ArrayList<ComposizioneVenditaBean>();
				rsGetItem.close();
				psgetItem.close();
				
			}
			rsVendite.close();
			psgetVendite.close();	
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally{
			try{
			
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		
		
		
		
		return orders;
	}

	@Override
	public synchronized boolean createNewUser(UserBean user,String password) {
		String insert="INSERT INTO Cliente (Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES(?,?,?,?,?,?,?,?,?,?);";
		Connection connection=null;
		try{
			connection=DriverMangerConnectionPool.getConnection();
			
			PreparedStatement ps=connection.prepareStatement(insert);
			ps.setString(1, user.getNome());
			ps.setString(2, user.getCognome());
			ps.setString(3, user.getCitta());
			ps.setString(4, user.getVia());
			ps.setString(5, String.valueOf(user.getnCivico()));
			ps.setString(6, user.getCap());
			ps.setString(7, user.getPartitaIva());
			ps.setString(8, user.getEmail());
			ps.setString(9, user.getTelefono());
			ps.setString(10, password);
			ps.executeUpdate();
			connection.commit();
			ps.close();	
			return true;
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
			
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
	}

	@Override
	public synchronized boolean createNewProduct(ProductBean product) {
		ProductBean p=getProductById(product.getCodiceProdotto());
		if(p.getCodiceProdotto()!=null)	return false;
		
		Connection connection=null;
		String sql="INSERT INTO PRODOTTI VALUES(?,?,?,?,?,?,?);";
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1, product.getCodiceProdotto());
			ps.setFloat(2, product.getPrezzoA());
			ps.setString(3, product.getAliquota());
			ps.setFloat(4, product.getPrezzoV());
			ps.setString(5, product.getUnitaDiMisura());
			ps.setString(6,product.getDescrione());
			ps.setString(7, product.getCategoria());
			ps.executeUpdate();
			connection.commit();
			ps.close();
			
		}
		catch(Exception e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return true;
	}

	

	@Override
	public synchronized ArrayList<ProductBean> getAllProductInList() {
		ArrayList<ProductBean> allProducts=new ArrayList<ProductBean>();
		Connection connection = null;
		String getAll="SELECT * FROM Prodotti;";
		try{
			connection=DriverMangerConnectionPool.getConnection();
			
			connection.commit();
			Statement st=connection.createStatement();
			ResultSet rs=st.executeQuery(getAll);
			while(rs.next()){
				allProducts.add(new ProductBean(
						rs.getString("CodiceProdotto"),
						rs.getFloat("PrezzoDiAcquisto"),
						rs.getFloat("PrezzoDiVendita"),
						rs.getString("Aliquota"),
						rs.getString("UnitaDiMisura"),
						rs.getString("Categoria"),
						rs.getString("Descrizione"),
						0
						));
			}
			rs.close();
			st.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return allProducts;
	}

	public synchronized boolean updateProduct(String idProduct, String idMag, float quant, String op) {
		Connection connection = null;
		String sql=null;
		if(op.equals("update")){
			sql="UPDATE HaDisponibilitaDi SET Quantita=?"+
				 " WHERE CodiceMagazzino=? AND CodiceProdotto=?;";
		}else if(op.equals("insert")){
			sql="INSERT INTO HaDisponibilitaDi(Quantita,CodiceMagazzino,CodiceProdotto) VALUES(?,?,?);";
		}
		else{
			sql=null;
		}
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			PreparedStatement st=connection.prepareStatement(sql);
			st.setFloat(1, quant);
			st.setString(2, idMag);
			st.setString(3, idProduct);
			st.executeUpdate();
			connection.commit();
			st.close();
			
			return true;
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
	}

	@Override
	public synchronized float getDisponibilità(String pIva, String codP) {
		String sql="SELECT quantita FROM hadisponibilitadi,magazzino where "+
				"PIvaPuntoVendita=? and"+
				" magazzino.CodiceMagazzino=hadisponibilitadi.CodiceMagazzino " +
				"and CodiceProdotto=?;";
		Connection connection=null;
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement st=connection.prepareStatement(sql);
			st.setString(1, pIva);
			st.setString(2, codP);
			ResultSet rs=st.executeQuery();
			if(rs.next()){
				float r=rs.getFloat(1);
				return r;
			}
			rs.close();
			st.close();
			return 0;
			
		}
		catch(SQLException e){
			System.out.println("SQLErrorgetd: "+e.getMessage());
			return 0;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLErrorgetd: "+e.getMessage());
			}
		}
	}

	@Override
	public synchronized ArrayList<String> getMagazzini(String pIva,String codP) {
		String sql="SELECT magazzino.codiceMagazzino FROM magazzino,hadisponibilitadi where pivapuntovendita=? "+
				"and hadisponibilitadi.CodiceProdotto=? and hadisponibilitadi.CodiceMagazzino=magazzino.CodiceMagazzino;";
		Connection connection=null;
		ArrayList<String> magazzini=new ArrayList<String>();
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement st=connection.prepareStatement(sql);
			st.setString(1, pIva);
			st.setString(2, codP);
			ResultSet rs=st.executeQuery();
			while(rs.next()){
				magazzini.add(rs.getString(1));
			}
			rs.close();
			st.close();
			
		}
		catch(SQLException e){
			System.out.println("SQLErrorgetmagazzini: "+e.getMessage());
			return null;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLErrorgetmagazzini: "+e.getMessage());
			}
		}
		return magazzini;
	}

	@Override
	public synchronized ArrayList<String> getMagazzini(String pIva) {
		String sql="SELECT codiceMagazzino FROM societa.magazzino where PIvaPuntoVendita=?;";
		Connection connection=null;
		ArrayList<String> magazzini=new ArrayList<String>();
		try{
			
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement st=connection.prepareStatement(sql);
			st.setString(1, pIva);
			ResultSet rs=st.executeQuery();
			while(rs.next()){
				magazzini.add(rs.getString(1));
			}
			rs.close();
			st.close();
			
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return null;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return magazzini;
	}

	@Override
	public synchronized boolean updateProProprieties(String id, String prop, String value) {
		String part1="UPDATE Prodotti SET "+prop;
		String part2="=? WHERE CodiceProdotto=?;";
		String sql=part1+part2;		 
		Connection connection = null;
		try{
			connection=DriverMangerConnectionPool.getConnection();
			PreparedStatement st=connection.prepareStatement(sql);
			st.setString(1, value);
			st.setString(2, id);
			st.executeUpdate();
			connection.commit();
			st.close();
			return true;
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		
	}

	@Override
	public synchronized boolean buy(String userId, CartBean cart) {
		String insertVen="INSERT INTO Vendita(Ora, DataVendita, Totale, IdCliente, Sconto,Status) VALUES(?,?,?,?,0,'IN_ELABORAZIONE');";
		String selectUltimaVendita="select max(codicevendita) as max from vendita where idcliente=?;";
		String insertComp="INSERT INTO ComposizioneVendita VALUES(?,?,?,?);";
		String selMaxMag="SELECT CodiceMagazzino,quantita FROM hadisponibilitadi WHERE CodiceProdotto=?";
		String updateMag="UPDATE HaDisponibilitaDi SET Quantita=Quantita-? WHERE CodiceProdotto=? AND CodiceMagazzino=?;";
		//Attenzione aggiornamento magazzino AGGIUSTARE CON WHILE!
		Connection connection=null;
		Calendar cal=Calendar.getInstance();
		cal.setTimeInMillis(System.currentTimeMillis());
		DateFormat getData = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat getOra = new SimpleDateFormat("hh:mm:ss");
		String data=getData.format(cal.getTime());
		String ora=getOra.format(cal.getTime());
		try{
			connection=DriverMangerConnectionPool.getConnection();
			PreparedStatement psInsertVen=connection.prepareStatement(insertVen);
			psInsertVen.setString(1,ora);
			psInsertVen.setString(2,data);
			float totale=0;
			ArrayList<ProductBean>products=cart.getList();
			for(ProductBean p:products){
				totale+=(p.getPrezzoV()*cart.getQuantityOf(p));
			}
			psInsertVen.setFloat(3, totale);
			psInsertVen.setString(4,userId);
			psInsertVen.executeUpdate();
			psInsertVen.close();
			PreparedStatement ultimaVendita=connection.prepareStatement(selectUltimaVendita);
			ultimaVendita.setString(1, userId);
			ResultSet rs=ultimaVendita.executeQuery();
			rs.next();
			int codV=rs.getInt(1);
			rs.close();
			ultimaVendita.close();
			PreparedStatement psInsertComp=connection.prepareStatement(insertComp);
			psInsertComp.setInt(1, codV);
			for(ProductBean p:products){
				psInsertComp.setString(2, p.getCodiceProdotto());
				psInsertComp.setFloat(3, cart.getQuantityOf(p));
				psInsertComp.setFloat(4, p.getPrezzoV());
				psInsertComp.executeUpdate();
				connection.commit();
				PreparedStatement psGetMag=connection.prepareStatement(selMaxMag);
				psGetMag.setString(1, p.getCodiceProdotto());
				ResultSet rsGetMag=psGetMag.executeQuery();
				float realQ= cart.getQuantityOf(p);
				while(rsGetMag.next()){
					String codM=rsGetMag.getString(1);
					float quant=rsGetMag.getFloat(2);
					boolean exit=false;
					if(quant<realQ){
						realQ=realQ-quant;
					}
					else{
						quant=realQ;
						exit=true;
					}
					PreparedStatement psUpdateMag=connection.prepareStatement(updateMag);
					psUpdateMag.setFloat(1,quant);
					psUpdateMag.setString(2,p.getCodiceProdotto());
					psUpdateMag.setString(3,codM);
					psUpdateMag.executeUpdate();
					connection.commit();
					psUpdateMag.close();	
					if(exit){
						rsGetMag.close();
						psGetMag.close();
						break;
					}
				}
			}
			
			connection.commit();
			psInsertComp.close();
			
			
			return true;
			
			
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
	}

	@Override
	public synchronized ArrayList<OrderBean> getOrderForAdmin() {
		ArrayList<OrderBean> orders=new ArrayList<OrderBean>();
		String sql="SELECT * FROM societa.vendita where status!=3;";
		Connection connection=null;
		try{
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			ResultSet rs=(connection.createStatement()).executeQuery(sql);
			while(rs.next()){
				orders.add(new OrderBean(rs.getInt("CodiceVendita"),
						rs.getDate("DataVendita"),
						rs.getFloat("Totale"),
						rs.getInt("IdCliente"),
						rs.getFloat("Sconto"),
						null,
						rs.getString("Status")
						));
			}
			rs.close();
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return null;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}
		return orders;
	}

	@Override
	public synchronized boolean updateState(String id, int value) {
		Connection connection=null;
		String sql = "UPDATE Vendita SET Status=? WHERE CodiceVendita=?;";
		try{
			connection=DriverMangerConnectionPool.getConnection();
			connection.commit();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setInt(1, value);
			ps.setString(2, id);
			int v=ps.executeUpdate();
			connection.commit();
			ps.close();
			if(v==1)
				return true;
			else
				return false;
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return false;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}		
	}

	@Override
	public synchronized boolean checkEmail(String parameter) {
		String sql="SELECT Email FROM Cliente;";
		Connection connection=null;
		try{
			connection=DriverMangerConnectionPool.getConnection();
			Statement st=connection.createStatement();
			ResultSet rs=st.executeQuery(sql);
			while(rs.next()){
				if(rs.getString(1).equals(parameter))
					return true;
			}
		}
		catch(SQLException e){
			System.out.println("SQLError: "+e.getMessage());
			return true;
		}
		finally{
			try{
				DriverMangerConnectionPool.releaseConnection(connection);
			}
			catch(SQLException e){
				System.out.println("SQLError: "+e.getMessage());
			}
		}		
		return false;
	}

	

}
