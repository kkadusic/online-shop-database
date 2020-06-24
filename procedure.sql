--Nepotpuno kreiranje procedure 5.1.
CREATE OR REPLACE PROCEDURE proc_obrisi_starije_fakt
       ( datum  IN Racun.DatumZakljucenja%TYPE )
IS
BEGIN
      DELETE Racun
      WHERE  DatumZakljucenja < datum;
      COMMIT;
END;