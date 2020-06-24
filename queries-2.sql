--UPITI

--KATEGORIJA 1

--1.
SELECT d.Naziv "Drzava", p.Naziv "Proizvod", Sum(k.KolicinaRobe) "Ukupna kolicina proizvoda"
FROM Drzava d, Grad g, Proizvod p, Kolicina k, Skladiste s
WHERE p.ProizvodID = k.ProizvodID AND k.SkladisteID = s.SkladisteID AND s.GradID = g.GradID AND g.DrzavaID = d.DrzavaID
GROUP BY d.Naziv, p.Naziv;

--2.
SELECT p.Ime "Pravna lica"
FROM PravnoLice p, Ugovor u
WHERE p.PravnoLiceID = u.PravnoLiceID AND u.DatumPotpisivanja > To_Date('2015-12-31','yyyy-mm-dd');

--3.
SELECT d.Naziv "Drzava" , f.Ime ||' '|| f.Prezime "Sef skladista", Max(u.Plata) "Plata"
FROM Drzava d, Uposlenik u, Grad g, Skladiste s, FizickoLice f
WHERE d.DrzavaID = g.DrzavaID AND g.GradID = s.GradID AND s.OdgovornaOsobaID = u.UposlenikID AND u.FizickoLiceID = f.FizickoLiceID
GROUP BY d.Naziv, f.Ime ||' '|| f.Prezime;


--KATEGORIJA 2

--1.
SELECT DISTINCT p.Naziv "Proizvod"
FROM Proizvod p, Popust po, StavkaRacuna st, Garancija g
WHERE p.ProizvodID = po.ProizvodID AND st.PopustID = po.PopustID AND st.StavkaRacunaID = g.StavkaRacunaID AND p.MjeseciGarancije = 24;

--2.
SELECT p.Naziv "Proizvod", p.Cijena "Cijena",p.Cijena-(p.Cijena * pop.ProcentualniPopust/100) "Cijena sa popustom" ,s.Naziv "Skladiste"
FROM Proizvod p, Popust pop, Skladiste s, Kolicina k
WHERE ROWNUM <= 10 AND s.SkladisteID = k.SkladisteID AND k.ProizvodID = p.ProizvodID AND p.ProizvodID = pop.ProizvodID;

--3.
SELECT ProcentualniPopust - 5 "Smanjeni popust"
FROM Popust
WHERE ProcentualniPopust > 20;

--6.
SELECT g.Naziv "Grad", Count(*) "Broj pravnih lica"
FROM Grad g, PravnoLice p
WHERE g.GradID = p.GradID
GROUP BY g.Naziv
HAVING Count(*) = (SELECT Max(Count(p.PravnoLiceID)) FROM PravnoLice p GROUP BY p.PravnoLiceID);


--KATEGORIJA 3

--1.
SELECT pro.Naziv "Naziv proizvoda", pro.Cijena "Cijena Proizvoda", pop.ProcentualniPopust "Popust na proizvod"
FROM Proizvod pro, Popust pop
WHERE pro.ProizvodID = pop.ProizvodID;

--2.
SELECT k.Naziv "Kategorija", Decode( Nvl(k.NadkategorijaID,0), 0, 'Nema nadkategoriju', nk.Naziv) "Nadkategorija"
FROM Kategorija k, Kategorija nk
WHERE k.NadkategorijaID = nk.KategorijaID(+);


--KATEGORIJA 4

--1.
 SELECT f.Ime "Naziv", s.Adresa "Adresa", g.Naziv "Mjesto"
 FROM FizickoLice f, Grad g, Skladiste s
 WHERE f.GradID = g.GradID AND s.GradID = g.GradID
 UNION
 SELECT f.Ime, f.Adresa, g.Naziv
 FROM PravnoLice f, Grad g
 WHERE f.GradID = g.GradID;

--3.
SELECT f.Ime || ' ' || f.Prezime "Ime i prezime uposlenika", Decode(o.OdjelID, 1, 'Menadzer', 2, 'Skladistar', 3, 'Serviser','Uposlenik') "Titula"
FROM FizickoLice f, Uposlenik u, Odjel o
WHERE u.FizickoLiceID = f.FizickoLiceID AND u.OdjelID = o.OdjelID;


--KATEGORIJA 5

--1.
SELECT p.Naziv "Proizvod", pra.Ime "Proizvodac",Sum(sr.KolicinaStavke) "Ukupno prodanih"
FROM Proizvod p, PravnoLice pra, Proizvodjac pro, StavkaRacuna sr
WHERE pra.PravnoLiceID = pro.PravnoLiceID AND pro.ProizvodjacID = p.ProizvodjacID AND p.ProizvodID = sr.ProizvodID AND ROWNUM <= 10
GROUP BY p.Naziv, pra.Ime
ORDER BY 3, 2;

--2.
SELECT MIN(p.Cijena), MAX(p.Cijena)
FROM Proizvod p, Kategorija k
WHERE p.KategorijaID = k.KategorijaID
ORDER BY k.Naziv, (MIN(p.Cijena) + MAX(p.Cijena));
