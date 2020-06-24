--Pogled na osnovu rezultata upita 1.1.
CREATE VIEW pravno_fiz_adr ("Pravno lice") AS
SELECT p.Ime
FROM PravnoLice p, FizickoLice f, Grad g
WHERE f.GradID = g.GradID AND g.GradID = p.GradID AND f.Adresa = p.Adresa;

--Pogled na osnovu rezultata upita 3.1.
CREATE VIEW proiz_veci_avg ("Proizvod") AS
SELECT p.Naziv
FROM Proizvod p, Proizvodjac pr
WHERE p.ProizvodjacID = pr.ProizvodjacID AND  p.Cijena > (SELECT Avg(p.Cijena)
                                                          FROM Proizvod p);

--Pogled na osnovu rezultata upita 5.2.
CREATE VIEW proiz_max ("Proizvod", "Cijena") AS
SELECT p.Naziv, p.Cijena
FROM Proizvod p, Kategorija k
WHERE p.ProizvodID = k.KategorijaID AND p.Cijena > (SELECT AVG (MAX (p.Cijena))
                                                    FROM  Proizvod p, Kategorija k
                                                    WHERE p.ProizvodID = k.KategorijaID
                                                    GROUP BY p.Cijena);
