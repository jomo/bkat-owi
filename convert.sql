.mode ascii
.separator "^" "\n"
.headers on
.import input.txt bat
.mode csv
.headers on
.output data.csv
SELECT
  tbnr AS Tatbestandsnummer,
  trim(tdb1 || " " || tdb2 || " " || tdb3 || " " || tdb4 || " " || tdb5) AS Tatbestand_Datenbank,
  trim(pdb1 || " " || pdb2) AS Paragraphen_Datenbank,
  fap AS FaP,
  p AS P,
  cast(euro || "." || cent as float) AS Euro,
  klt1 || " " || klt2 || " " || klt3 AS Klassifizierung_Text,
  von AS Gueltig_bis,
  bis AS Gueltig_bis,
  kr1 AS Konkretisierung1,
  kr2 AS Konkretisierung2,
  kl1 AS Klassifizierung1,
  kl2 AS Klassifizierung2,
  kl3 AS Klassifizierung3,
  kl4 AS Klassifizierung4,
  trim(tdr1 || char(10) || tdr2 || char(10) || tdr3 || char(10) || tdr4 || char(10) || tdr5, " " || char(10)) AS Tatbestand_Druckdatei,
  trim(pdr1 || " " || pdr2) AS Paragraphen_Druckdatei
FROM bat;
