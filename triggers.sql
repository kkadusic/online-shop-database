--Triger 1
CREATE TRIGGER promjena_plate
BEFORE UPDATE ON Uposlenik
FOR EACH ROW
WHEN (new.UposlenikID > 0)
DECLARE
    plata_razlika NUMBER;
BEGIN
    plata_razlika  := :new.Plata  - :old.Plata;
    dbms_output.put('Stara plata: ' || :old.Plata);
    dbms_output.put('  Nova plata: ' || :new.Plata);
    dbms_output.put('  UposlenikID: ' || :old.UposlenikID);
    dbms_output.put_line('  Razlika: ' || plata_razlika);
END;
/

--Triger 2
CREATE OR REPLACE TRIGGER osiguraj_popust
BEFORE INSERT OR UPDATE OR DELETE ON Popust
BEGIN
IF (TO_CHAR (sysdate,'DY') IN ('SAT','SUN')) OR (TO_CHAR(sysdate,'HH24') NOT BETWEEN '08' AND '18')
THEN RAISE_APPLICATION_ERROR (-20500,'Mozete vrsiti promjene nad tabelom Popust samo tokom radnih dana');
END IF;
END;
/

--Triger 3
CREATE OR REPLACE TRIGGER trig_kolicina
AFTER INSERT OR UPDATE OR DELETE
ON Kolicina
FOR EACH ROW
DECLARE
   v_username varchar2(10);
BEGIN
   -- Nadji username osobe
   SELECT USER INTO v_username
   FROM dual;
   -- Sacuvaj podatke u audit tabelu
   INSERT INTO kolicina_audit
   ( KolicinaID,
     SkladisteID,
     ProizvodID,
     KolicinaRobe,
     Datum,
     Username )
   VALUES
   ( :new.KolicinaID,
     :new.SkladisteID,
     :new.ProizvodID,
     :new.KolicinaRobe,
     SYSDATE,
     v_username );
END;     
/