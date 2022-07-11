.mode ascii
.separator "^" "\n"
.headers on
.import input.txt bat
.mode csv
.headers on
.output data.csv
SELECT
  trim(tbnr) AS Tatbestandsnummer,
  trim(tdb1 || " " || tdb2 || " " || tdb3 || " " || tdb4 || " " || tdb5) AS Tatbestand_Datenbank,
  trim(pdb1 || " " || pdb2) AS Paragraphen_Datenbank,
  trim(fap) AS FaP,
  trim(p) AS P,
  cast(euro || "." || cent as float) AS Euro,
  trim(klt1) AS Klammer_A,
  trim(klt2) AS Klammer_B,
  trim(klt3) AS Klammer_C,
  trim(bis) AS Gueltig_bis,
  trim(von) AS Gueltig_von,
  trim(fv) AS FV,
  trim(kr) AS Konkretisierung,
  trim(kl) AS Klassifizierung,
  trim(tab) AS Tabelle,
  trim(unter) AS Untergrenze,
  trim(ober) AS Obergrenze,
  trim(tdr1 || char(10) || tdr2 || char(10) || tdr3 || char(10) || tdr4 || char(10) || tdr5, " " || char(10)) AS Tatbestand_Druckdatei,
  trim(pdr1 || " " || pdr2) AS Paragraphen_Druckdatei
FROM bat;
