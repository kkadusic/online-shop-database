CREATE TABLE Kontinent (
  KontinentID NUMBER(10) NOT NULL,
  Naziv VARCHAR(100) NOT NULL,
  CONSTRAINT kontinent_pk PRIMARY KEY (KontinentID)
);

CREATE TABLE Drzava (
  DrzavaID CHAR(10) NOT NULL,
  KontinentID NUMBER(10) NOT NULL,
  Naziv VARCHAR (100) NOT NULL,
  CONSTRAINT DrzavaID_pk PRIMARY KEY (DrzavaID),
  CONSTRAINT KontinentID_fk FOREIGN KEY (KontinentID) REFERENCES Kontinent (KontinentID)
);

CREATE TABLE Grad (
  GradID NUMBER(10) NOT NULL,
  DrzavaID CHAR(10) NOT NULL,
  Naziv VARCHAR(100) NOT NULL,
  CONSTRAINT GradID_pk PRIMARY KEY (GradID),
  CONSTRAINT DrzavaID_fk FOREIGN KEY (DrzavaID) REFERENCES Drzava (DrzavaID)
);

CREATE TABLE FizickoLice (
  FizickoLiceID NUMBER(10) NOT NULL,
  GradID NUMBER(10) NOT NULL,
  Ime VARCHAR(100) NOT NULL,
  Prezime VARCHAR(100) NOT NULL,
  DatumRodjenja DATE NOT NULL,
  Adresa VARCHAR(100) NOT NULL,
  CONSTRAINT FizickoLiceID_pk PRIMARY KEY (FizickoLiceID),
  CONSTRAINT GradID_fk FOREIGN KEY (GradID) REFERENCES Grad (GradID)
);

CREATE TABLE Kupac (
  KupacID NUMBER(10) NOT NULL,
  FizickoLiceID NUMBER(10) NOT NULL,
  CONSTRAINT KupacID_pk PRIMARY KEY (KupacID),
  CONSTRAINT FizickoLiceID_fk FOREIGN KEY (FizickoLiceID) REFERENCES FizickoLice (FizickoLiceID)
);

CREATE TABLE Racun (
  RacunID NUMBER(10) NOT NULL,
  KupacID NUMBER(10) NOT NULL,
  DatumZakljucenja DATE NULL,
  CONSTRAINT RacunID_pk PRIMARY KEY (RacunID),
  CONSTRAINT KupacID_fk FOREIGN KEY (KupacID) REFERENCES Kupac (KupacID)
);

CREATE TABLE PravnoLice (
  PravnoLiceID NUMBER(10) NOT NULL,
  GradID NUMBER(10) NOT NULL,
  Ime VARCHAR(100) NOT NULL,
  Adresa VARCHAR(100) NOT NULL,
  CONSTRAINT PravnoLiceID_pk PRIMARY KEY (PravnoLiceID),
  CONSTRAINT GradID_fk1 FOREIGN KEY (GradID) REFERENCES Grad (GradID)
);

CREATE TABLE Odjel (
  OdjelID NUMBER(10) NOT NULL,
  SefID NUMBER(10),
  Naziv VARCHAR(100),
  CONSTRAINT OdjelID_pk PRIMARY KEY (OdjelID)
);

CREATE TABLE Uposlenik (
  UposlenikID NUMBER(10) NOT NULL,
  FizickoLiceID NUMBER(10) NOT NULL,
  OdjelID NUMBER(10) NOT NULL,
  DatumZaposlenja DATE NOT NULL,
  Plata NUMBER(10) NOT NULL,
  BrojRacuna CHAR(13) NOT NULL,
  BrojUgovora CHAR(10) NOT NULL,
  CONSTRAINT UposlenikID_pk PRIMARY KEY (UposlenikID),
  CONSTRAINT FizickoLiceID_fk1 FOREIGN KEY (FizickoLiceID) REFERENCES FizickoLice (FizickoLiceID),
  CONSTRAINT OdjelID_fk FOREIGN KEY (OdjelID) REFERENCES Odjel (OdjelID)
);

ALTER TABLE Odjel ADD CONSTRAINT SefID_fk FOREIGN KEY (SefID) REFERENCES Uposlenik (UposlenikID);

CREATE TABLE Ugovor (
  UgovorID NUMBER(10) NOT NULL,
  PravnoLiceID NUMBER(10) NOT NULL,
  UposlenikID NUMBER(10) NOT NULL,
  BrojUgovora CHAR(10) NOT NULL,
  DatumPotpisivanja DATE NOT NULL,
  DatumRaskidanja DATE NOT NULL,
  CONSTRAINT UgovorID_pk PRIMARY KEY (UgovorID),
  CONSTRAINT PravnoLiceID_fk FOREIGN KEY (PravnoLiceID) REFERENCES PravnoLice (PravnoLiceID),
  CONSTRAINT UposlenikID_fk4 FOREIGN KEY (UposlenikID) REFERENCES Uposlenik (UposlenikID)
);

CREATE TABLE KurirskaSluzba (
  KurirskaSluzbaID NUMBER(10) NOT NULL,
  PravnoLiceID NUMBER(10) NOT NULL,
  CONSTRAINT KurirskaSluzbaID_pk PRIMARY KEY (KurirskaSluzbaID),
  CONSTRAINT PravnoLiceID_fk1 FOREIGN KEY (PravnoLiceID) REFERENCES PravnoLice (PravnoLiceID)
);

CREATE TABLE Isporuka (
  IsporukaID NUMBER(10) NOT NULL,
  KurirskaSluzbaID NUMBER(10) NOT NULL,
  DatumIsporuke DATE NOT NULL,
  CONSTRAINT IsporukaID_pk PRIMARY KEY (IsporukaID),
  CONSTRAINT KurirskaSluzbaID_fk FOREIGN KEY (KurirskaSluzbaID) REFERENCES KurirskaSluzba (KurirskaSluzbaID)
);

CREATE TABLE StavkaIsporuke (
  StavkaIsporukeID NUMBER(10) NOT NULL ,
  IsporukaID NUMBER(10) NOT NULL,
  RacunID NUMBER(10) NOT NULL,
  CONSTRAINT StavkaIsporukeID_pk PRIMARY KEY (StavkaIsporukeID),
  CONSTRAINT IsporukaID_fk FOREIGN KEY (IsporukaID) REFERENCES Isporuka (IsporukaID),
  CONSTRAINT RacunID_fk FOREIGN KEY (RacunID) REFERENCES Racun (RacunID)
);

CREATE TABLE Proizvodjac (
  ProizvodjacID NUMBER(10) NOT NULL,
  PravnoLiceID NUMBER(10) NOT NULL,
  CONSTRAINT ProizvodjacID_pk PRIMARY KEY (ProizvodjacID),
  CONSTRAINT PravnoLiceID_fk2 FOREIGN KEY (PravnoLiceID) REFERENCES PravnoLice (PravnoLiceID)
);

CREATE TABLE Kategorija (
  KategorijaID NUMBER(10) PRIMARY KEY NOT NULL,
  NadkategorijaID NUMBER(10),
  Naziv VARCHAR(10) NOT NULL
);

ALTER TABLE Kategorija ADD FOREIGN KEY(NadkategorijaID) REFERENCES Kategorija (KategorijaID);

CREATE TABLE Skladiste (
  SkladisteID NUMBER(10) NOT NULL,
  GradID NUMBER(10) NOT NULL,
  OdgovornaOsobaID NUMBER(10) NOT NULL,
  Naziv VARCHAR(100) NULL,
  Adresa VARCHAR (100) NOT NULL,
  CONSTRAINT SkladisteID_pk PRIMARY KEY (SkladisteID),
  CONSTRAINT GradID_fk2 FOREIGN KEY (GradID) REFERENCES Grad (GradID),
  CONSTRAINT OdgovornaOsobID_fk FOREIGN KEY (OdgovornaOsobaID) REFERENCES Uposlenik (UposlenikID)
);

CREATE TABLE Proizvod (
  ProizvodID NUMBER(10) NOT NULL,
  ProizvodjacID NUMBER(10) NOT NULL,
  KategorijaID NUMBER(10) NOT NULL,
  Naziv VARCHAR(100) NOT NULL,
  Cijena NUMBER(10) NOT NULL,
  MjeseciGarancije NUMBER(10) NULL,
  CONSTRAINT ProizvodID_pk PRIMARY KEY (ProizvodID),
  CONSTRAINT ProizvodjacID_fk FOREIGN KEY (ProizvodjacID) REFERENCES Proizvodjac (ProizvodjacID),
  CONSTRAINT KategorijaID_fk FOREIGN KEY (KategorijaID) REFERENCES Kategorija (KategorijaID)
);

CREATE TABLE Popust (
  PopustID NUMBER(10) NOT NULL,
  ProizvodID NUMBER(10) NOT NULL,
  ProcentualniPopust NUMBER(10) NOT NULL,
  Aktuelan NUMBER(5) NOT NULL,
  CONSTRAINT PopustID_pk PRIMARY KEY (PopustID),
  CONSTRAINT ProizvodID_fk FOREIGN KEY (ProizvodID) REFERENCES Proizvod (ProizvodID)
);

CREATE TABLE Kolicina (
  KolicinaID NUMBER(10) NOT NULL,
  SkladisteID NUMBER(10) NOT NULL,
  ProizvodID NUMBER(10) NOT NULL,
  KolicinaRobe NUMBER(10) NOT NULL,
  CONSTRAINT KolicinaID_pk PRIMARY KEY (KolicinaID),
  CONSTRAINT SkladisteID_fk FOREIGN KEY (SkladisteID) REFERENCES Skladiste (SkladisteID),
  CONSTRAINT ProizvodID_fk1 FOREIGN KEY (ProizvodID) REFERENCES Proizvod (ProizvodID)
);

CREATE TABLE StavkaRacuna (
  StavkaRacunaID NUMBER(10) NOT NULL,
  RacunID NUMBER(10) NOT NULL,
  ProizvodID NUMBER(10) NOT NULL,
  PopustID NUMBER(10) NOT NULL,
  KolicinaStavke NUMBER(10) NOT NULL,
  CijenaBezPopusta NUMBER(10) NOT NULL,
  CONSTRAINT StavkaRacunaID_pk PRIMARY KEY (StavkaRacunaID),
  CONSTRAINT RacunID_fk1 FOREIGN KEY (RacunID) REFERENCES Racun (RacunID),
  CONSTRAINT ProizvodID_fk2 FOREIGN KEY (ProizvodID) REFERENCES Proizvod (ProizvodID),
  CONSTRAINT PopustID_fk1 FOREIGN KEY (PopustID) REFERENCES Popust (PopustID)
);

CREATE TABLE Garancija (
  GarancijaID NUMBER(10) NOT NULL,
  StavkaRacunaID NUMBER(10) NOT NULL,
  DatumPocetka DATE NOT NULL,
  DatumIsteka DATE NOT NULL,
  CONSTRAINT GarancijaID_pk PRIMARY KEY (GarancijaID),
  CONSTRAINT StavkaRacunaID_fk1 FOREIGN KEY (StavkaRacunaID) REFERENCES StavkaRacuna (StavkaRacunaID)
);

CREATE TABLE kolicina_audit (
  KolicinaID NUMBER(10),
  SkladisteID NUMBER(10),
  ProizvodID NUMBER(10),
  KolicinaRobe NUMBER(10),
  Datum DATE,
  Username VARCHAR2(20)
);