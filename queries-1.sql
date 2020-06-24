--1.1.
SELECT p.Ime "Pravno lice"
FROM PravnoLice p, FizickoLice f, Grad g
WHERE f.GradID = g.GradID AND g.GradID = p.GradID AND f.Adresa = p.Adresa;

--1.2.
SELECT u.UgovorID "ID ugovora", u.BrojUgovora "Broj ugovora", u.DatumPotpisivanja "Datum potpisivanja ugovora", Max(g.DatumPocetka) "Najstarija izdata garancija"
FROM Ugovor u, Garancija g
GROUP BY u.UgovorID, u.BrojUgovora, u.DatumPotpisivanja
HAVING u.DatumPotpisivanja > (SELECT Max(g.DatumPocetka)
                              FROM Garancija g);

--2.1.
SELECT p.Naziv "Proizvod"
FROM Kolicina k, Proizvod p, Kategorija kat
WHERE k.ProizvodID = p.ProizvodID AND
      p.KategorijaID = kat.KategorijaID AND k.KolicinaRobe = (SELECT Max(k.KolicinaRobe)
                                                              FROM Proizvod p, Skladiste s, Kolicina k
                                                              WHERE s.SkladisteID = k.SkladisteID AND k.ProizvodID = p.ProizvodID);

--2.3.
SELECT s.Naziv "Skladiste", Max(max_proiz) "Najvise proizvoda"
FROM Skladiste s, Kolicina k, Proizvod p, Popust pop, (SELECT Count(p.ProizvodID) AS max_proiz FROM Proizvod p)
WHERE ROWNUM <= 200 AND s.SkladisteID = k.SkladisteID AND k.ProizvodID = p.ProizvodID
GROUP BY s.Naziv;

--3.1.
SELECT p.Naziv "Proizvod"
FROM Proizvod p, Proizvodjac pr
WHERE p.ProizvodjacID = pr.ProizvodjacID AND  p.Cijena > (SELECT Avg(p.Cijena)
                                                          FROM Proizvod p);

--3.4.
SELECT * FROM (SELECT pl.Ime "Kurirska Sluzba"
               FROM   KurirskaSluzba ks, Isporuka i, StavkaIsporuke si, Racun r, StavkaRacuna sr, Popust pop, PravnoLice pl
               WHERE  ks.KurirskaSluzbaID = i.KurirskaSluzbaID AND i.IsporukaID = si.IsporukaID AND si.RacunID = r.RacunID AND r.RacunID = sr.RacunID
                      AND sr.PopustID = pop.PopustID AND pop.Aktuelan = 1 AND pl.PravnoLiceID = ks.PravnoLiceID
               GROUP BY ks.KurirskaSluzbaID, pl.Ime
               ORDER BY COUNT (*) desc)
WHERE ROWNUM = 1;

--4.1.
SELECT f.ime || ' ' || f.prezime "Kupac", ((sr.CijenaBezPopusta + pop.ProcentualniPopust)-(sr.CijenaBezPopusta)) "Usteda"
FROM Racun r, Kupac k, Fizickolice f, Proizvod p, Popust pop, Stavkaracuna sr
WHERE f.FizickoLiceID = k.FizickoLiceID AND r.KupacID = k.KupacID AND sr.RacunID = r.RacunID AND
sr.ProizvodID = p.ProizvodID AND pop.ProizvodID = p.ProizvodID;


--4.4.
SELECT DISTINCT i.IsporukaID "ID isporuke"
FROM Isporuka i, StavkaIsporuke si, Racun r, StavkaRacuna sr, Popust p, Garancija g
WHERE i.IsporukaID = si.IsporukaID AND si.RacunID = r.RacunID AND r.RacunID = sr.RacunID AND sr.PopustID = p.PopustID
	  AND r.RacunID IN (SELECT c.RacunID
	                    FROM StavkaRacuna c, Racun x
						          WHERE p.Aktuelan = 1 AND c.RacunID = x.RacunID);

--5.2.
SELECT p.Naziv "Proizvod"
FROM Proizvod p, Kategorija k
WHERE p.ProizvodID = k.KategorijaID AND p.Cijena > (( SELECT AVG (MAX (p.Cijena))
                                                      FROM  Proizvod p, Kategorija k
                                                      WHERE p.ProizvodID = k.KategorijaID
                                                      GROUP BY p.Cijena));