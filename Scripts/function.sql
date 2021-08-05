/* Napisati funkciju koja ce za zadatu vrijednost u procentima ( +/ – 0 – 99%)
izracunati novu cijenu za sve proizvode koji pripadaju odredenoj kategoriji
i azurirati vrijednost u tabeli Proizvod, koloni cijena. Funkcija prima dva
parametra, kategorija id i promjena procenat. */

CREATE OR REPLACE FUNCTION prom_cijena (kategorijaid IN
Proizvod.KategorijaID%TYPE, promjena_procenat NUMBER)
RETURN VARCHAR2
IS
poruka VARCHAR2(40) := 'Funkcija uspjesno izvrsena!';
BEGIN
IF promjena_procenat < 0 OR promjena_procenat > 99
THEN poruka := 'Greska, procenat nije izmedju 0 i 99.';
ELSE
UPDATE Proizvod p
SET p.Cijena = (promjena_procenat/100) * p.Cijena
WHERE p.KategorijaID = KategorijaID;
END IF;
RETURN poruka;
END prom_cijena;
/
