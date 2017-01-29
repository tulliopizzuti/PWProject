/* POPOLAZIONE DATABASE */
/* PUNTI VENDITA */
INSERT INTO PuntoVendita VALUES("00112233445","AsfaltiRoma","Via Verdi","125","00060","Roma","0664420476","asfaltiroma@tiscali.it","roma");
INSERT INTO PuntoVendita VALUES("12345678901","AsfaltiMilano","Via Roma","15","45660","Milano","0373476786","asfaltimilano@tiscali.it","milano");
INSERT INTO PuntoVendita VALUES("56489723103","AsfaltiTorino","Piazza Milano","12","62302","Torino","0110760150","asfaltitorino@tiscali.it","torino");
/* MAGAZZINI */
INSERT INTO Magazzino VALUES("RO1001",1200,"00112233445","Via Terni","123","22565");
INSERT INTO Magazzino VALUES("RO1002",1000,"00112233445","Via Terni","125","22565");
INSERT INTO Magazzino VALUES("MI1001",2000,"12345678901","Via Lotto","12","55546");
INSERT INTO Magazzino VALUES("MI1002",410,"12345678901","Via Marmi","5","44457");
INSERT INTO Magazzino VALUES("TO1001",1200,"56489723103","Via Ambo","2","78978");
INSERT INTO Magazzino VALUES("TO1002",100,"56489723103","Via Lupi","25","22255");

/* CLIENTI */
INSERT INTO Cliente(Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES ("F.lli Amadori",NULL,"Bari","Via Roma","565","78003","02589631470","c.amadori@test.it","3223656980","sergio");
INSERT INTO Cliente(Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES ("Luca","Verdu","Salerno","Via Milano","5","88773",NULL,"luca.b@test.it","3400235658","carlo");
INSERT INTO Cliente(Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES ("Pippo S.n.C",NULL,"Palermo","Via Bergamo","12","75412","75369512485","c.pippo@test.it","377895624","pippo");
INSERT INTO Cliente(Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES ("Marco","Antoniou","Ostia","Via Brescia","53","87654",NULL,"marco.a@test.it","3405648795","marco");
INSERT INTO Cliente(Nome,Cognome,Città,Via,N°Civico,CAP,PartitaIva,Email,N°Telefono,Password) VALUES ("Paolo","Rossi","Napoli","Via Rossi","15","87443",NULL,"paolo.r@test.it","3458956423","paolo");

/* PRODOTTI */
	/*Mq*/
INSERT INTO Prodotti  VALUES ("PA33003",2.8,3,3.05,"Mq","Cartongesso normale 120x300","Cartongesso");
INSERT INTO Prodotti  VALUES ("PA3200F",3.7,3,4.10,4,"Cartongesso ignifugo 120x200","Cartongesso");
INSERT INTO Prodotti  VALUES ("PA3300Y",3.1,3,3.5,4,"Cartongesso idrorepellente 120x300","Cartongesso");
INSERT INTO Prodotti  VALUES ("EPS15050",1.5,3,1.8,4,"Polistirolo bianco alta densita da 5cm 100x50","Impermeabilizzanti");
INSERT INTO Prodotti  VALUES ("EPS10030",1.3,3,0.6,4,"Polistirolo bassa densita da 3cm 100x50","Impermeabilizzanti");
INSERT INTO Prodotti  VALUES ("EK400",3.4,3,4,4,"Sughero tostato da 4cm 100x50","Impermeabilizzanti");
INSERT INTO Prodotti  VALUES ("CORKPAN",7.5,3,9,4,"Pannello in fibra di legno","Impermeabilizzanti");
	/*Pz*/
INSERT INTO Prodotti  VALUES ("SCRC90",65,3,80,1,"Scrigno da 90 a scomparsa per cartongesso","Controtelai");
INSERT INTO Prodotti  VALUES ("SCRM70",47,3,60,1,"Scrigno da 70 a scomparsa per muratura","Controtelai");
INSERT INTO Prodotti  VALUES ("MD003",5.4,3,6,1,"Moduli 3cm","Vespai areati");
INSERT INTO Prodotti  VALUES ("0010P",6.5,3,8,1,"Conglomerato a freddo","Asfalti");
INSERT INTO Prodotti  VALUES ("ST25",5.6,3,7,1,"Stucco in polvere da 25Kg","Stucchi e rasanti");
INSERT INTO Prodotti  VALUES ("GUAG20",16.5,3,22,1,"Guaina liquida grigia da 20Kg","Isolanti");
INSERT INTO Prodotti  VALUES ("RUSFEIN25",27.5,3,33,1,"Intonachino bianco/colorato da 25Kg","Pitturazioni");
INSERT INTO Prodotti  VALUES ("NF57002B",4.5,3,6.8,1,"Viti per cartongesso da 2.5cm scatolo da 500pz","Utensileria");
	/*Ml*/
INSERT INTO Prodotti  VALUES ("M49-300",1.3,3,1.8,5,"Mondante da 49cm per cartongesso da 3mt","Profilati");
INSERT INTO Prodotti  VALUES ("SPL2",1.5,3,1.9,5,"Profilo angolare per cartongesso","Profilati");
	/*Rt*/
INSERT INTO Prodotti  VALUES ("SUPERGUM",27,3,35,6,"Guaina bituminosa 1x10 mt","Isolanti");
INSERT INTO Prodotti  VALUES ("SILENT",35,3,42,6,"Guaina bituminosa per isolamento acustico 1x10 mt","Isolanti");
INSERT INTO Prodotti  VALUES ("TNT",18,3,25,6,"Tessuto non tessuto per proteggere pannelli di fibra","Telo");

/* DISPONIBILITA' NEI MAGAZZINI */
	/* MAGAZZINO RO1001 */
INSERT INTO HaDisponibilitaDi VALUES("RO1001","PA33003",50);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","PA3200F",50);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","PA3300Y",50);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","EPS10030",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","SUPERGUM",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","SILENT",70);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","CORKPAN",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","MD003",20);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","NF57002B",200);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","M49-300",30);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","TNT",50);
INSERT INTO HaDisponibilitaDi VALUES("RO1001","SPL2",80);
	/* MAGAZZINO RO1002 */
INSERT INTO HaDisponibilitaDi VALUES("RO1002","SCRC90",20);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","SCRM70",20);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","ST25",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","GUAG20",40);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","0010P",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","EK400",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","RUSFEIN25",100);
INSERT INTO HaDisponibilitaDi VALUES("RO1002","EPS15050",100);

	/* MAGAZZINO MI1001 */
INSERT INTO HaDisponibilitaDi VALUES("MI1001","PA33003",50);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","PA3200F",50);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","PA3300Y",50);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","EPS10030",100);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","SUPERGUM",100);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","SILENT",70);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","CORKPAN",100);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","MD003",20);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","NF57002B",200);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","M49-300",30);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","TNT",500);
INSERT INTO HaDisponibilitaDi VALUES("MI1001","SPL2",80);
	/* MAGAZZINO MI1002 */
INSERT INTO HaDisponibilitaDi VALUES("MI1002","SCRC90",20);
INSERT INTO HaDisponibilitaDi VALUES("MI1002","SCRM70",20);
INSERT INTO HaDisponibilitaDi VALUES("MI1002","ST25",100);
INSERT INTO HaDisponibilitaDi VALUES("MI1002","GUAG20",40);
INSERT INTO HaDisponibilitaDi VALUES("MI1002","0010P",100);
INSERT INTO HaDisponibilitaDi VALUES("MI1002","EK400",100);

	/* MAGAZZINO TO1001 */
INSERT INTO HaDisponibilitaDi VALUES("TO1001","PA33003",50);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","PA3200F",50);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","PA3300Y",50);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","EPS10030",100);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","SUPERGUM",100);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","SILENT",70);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","CORKPAN",100);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","MD003",20);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","NF57002B",200);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","M49-300",30);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","TNT",500);
INSERT INTO HaDisponibilitaDi VALUES("TO1001","SPL2",80);
	/* MAGAZZINO TO1002 */
INSERT INTO HaDisponibilitaDi VALUES("TO1002","SCRC90",20);
INSERT INTO HaDisponibilitaDi VALUES("TO1002","SCRM70",20);
INSERT INTO HaDisponibilitaDi VALUES("TO1002","ST25",100);
INSERT INTO HaDisponibilitaDi VALUES("TO1002","GUAG20",40);
INSERT INTO HaDisponibilitaDi VALUES("TO1002","0010P",100);
INSERT INTO HaDisponibilitaDi VALUES("TO1002","EK400",100);

/* VENDITE */
INSERT INTO Vendita(Ora, DataVendita, Totale, IdCliente, Sconto) VALUES('10:20', '2015-12-29', 22,"1",0.0);
INSERT INTO Vendita(Ora, DataVendita, Totale, IdCliente, Sconto) VALUES('11:50', '2015-12-29', 18,"2",0.0);
INSERT INTO Vendita(Ora, DataVendita, Totale, IdCliente, Sconto) VALUES('9:00', '2015-12-29', 4,"3",0.0);
INSERT INTO Vendita(Ora, DataVendita, Totale, IdCliente, Sconto) VALUES('19:00', '2015-12-30', 4,"4",0.0);

/* COMPOSIZIONE  DELLE VENDITE */
	/* SCONTRINO NEGOZIO ROMA */	
INSERT INTO ComposizioneVendita VALUES(1,"CORKPAN",2,9);
UPDATE HaDisponibilitaDi SET Quantita=Quantita-2.0 WHERE CodiceMagazzino="RO1001" AND CodiceProdotto="CORKPAN";

INSERT INTO ComposizioneVendita VALUES(1,"EK400",1,4);
UPDATE HaDisponibilitaDi SET Quantita=Quantita-1.0 WHERE CodiceMagazzino="RO1002" AND CodiceProdotto="EK400";

	/*SCONTRINO NEGOZIO MILANO */
INSERT INTO ComposizioneVendita VALUES(2,"CORKPAN",2,9);
UPDATE HaDisponibilitaDi SET Quantita=Quantita-2.0 WHERE CodiceMagazzino="MI1001" AND CodiceProdotto="CORKPAN";
    /* SCONTRINO NEGOZIO TORINO */
INSERT INTO ComposizioneVendita VALUES(3,"EK400",1,4);
UPDATE HaDisponibilitaDi SET Quantita=Quantita-1.0 WHERE CodiceMagazzino="TO1002" AND CodiceProdotto="EK400";
INSERT INTO ComposizioneVendita VALUES(4,"EK400",1,4);
UPDATE HaDisponibilitaDi SET Quantita=Quantita-1.0 WHERE CodiceMagazzino="TO1002" AND CodiceProdotto="EK400";

