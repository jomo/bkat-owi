# BKAT-OWI

**tl;dr**: Download [data.csv](data.csv).

---

Tools for converting German traffic code offense data ("Bundeseinheitlicher Tatbestandskatalog" / "BT-KAT-OWI") to CSV.

The current version (2020-05-18) of [`data.txt`](data.txt) has been taken from [FOIA request #189544](https://fragdenstaat.de/a/189544).  
Additional documents are available at [FOIA request #216685](https://fragdenstaat.de/a/216685).

## File format

The txt file is similar to CSV, but uses a caret (`^`) as a separator. Other characters (such as `"` `,` `;`) are included unescaped. The file uses Windows-1252 encoding.

Some of the data fields span multiple columns.

The changelog (Änderungsverzeichnis on page 177, see #216685) mentions the format of the txt file as follows:

> Tatbestandsnummer, Tatbestand_Datenbank, Paragraphen_Datenbank, FaP, P, Euro, Gültig_bis, Gültig_von, Konkretisierung, Klassifizierung, Tatbestand_Druckdatei, Paragraphen_Druckdatei

This is not 100% accurate, but the script in this repository tries to refer to these column names where possible.

### Validity dates

The data purposely includes data that is no longer valid.  
`Gültig_von` gives the first day of validity (at `00:00`) while `Gültig_bis` gives the last day of validity (at `24:00`).  
Data valid for the foreseeable future is given as `Gültig_bis = 2099-12-31`.

## Converting to CSV

Running `convert.sh` will parse `data.txt` and output the [RFC 4180](https://tools.ietf.org/html/rfc4180) formatted, UTF-8 encoded [`data.csv`](data.csv) file.

The script requires `iconv`, `dos2unix`, and `sqlite3`.

The two separate columns for euros and cents are combined and converted to float. Other than that there is no data conversion, only basic concatenation and trimming. For details see [convert.sql](convert.sql).

## Preview


| Tatbestandsnummer | Tatbestand_Datenbank                                                                                                                                                                                                                                                                  | Paragraphen_Datenbank                                              | FaP  | P    | Euro | Klassifizierung_Text     | Gueltig_bis | Gueltig_von | Konkretisierung1 | Konkretisierung2 | Klassifizierung1 | Klassifizierung2 | Klassifizierung3 | Klassifizierung4 | Tatbestand_Druckdatei                                                                                                                                                                                                                                                                                                                                                      | Paragraphen_Druckdatei                                             |
| :---              | :---                                                                                                                                                                                                                                                                                  | :---                                                               | :--- | :--- | ---: | :---                     | :---        | :---        | :---             | :---             | :---             | :---             | :---             | :---             | :---                                                                                                                                                                                                                                                                                                                                                                       | :---                                                               |
| 101000            | Sie kamen von der Fahrbahn ab und verursachten Sachschaden.                                                                                                                                                                                                                           | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          | B    | 1    | 35.0 |                          | 2014-04-30  | 2002-01-01  |                  |                  | 4                |                  |                  |                  | <pre><code>Sie kamen von der Fahrbahn ab und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                        | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          |
| 101000            | Sie kamen von der Fahrbahn ab und verursachten Sachschaden.                                                                                                                                                                                                                           | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          |      | 0    | 35.0 |                          | 2099-12-31  | 2014-05-01  |                  |                  | 4                |                  |                  |                  | <pre><code>Sie kamen von der Fahrbahn ab und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                        | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          |
| 101006            | Sie gerieten ins Schleudern und verursachten Sachschaden.                                                                                                                                                                                                                             | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          | B    | 1    | 35.0 |                          | 2014-04-30  | 2002-01-01  |                  |                  | 4                |                  |                  |                  | <pre><code>Sie gerieten ins Schleudern und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                          | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                          |
| 103637            | Sie überschritten die zulässige Höchstgeschwindigkeit innerhalb geschlossener Ortschaften bei einer Sichtweite von weniger als 50 m durch Nebel, Schneefall oder Regen um #D# km/h. Zulässige Geschwindigkeit: 50 km/h. Festgestellte Geschwindigkeit (nach Toleranzabzug): #G# km/h. | § 3 Abs. 1, § 49 StVO; § 24, § 25 StVG; 9.1 BKat; § 4 Abs. 1 BKatV | A    | 1    | 95.0 | (Lkw usw.)  Tab.: 703000 | 2099-12-31  | 2020-04-28  | 1 M              |                  | 6                | 703000           | 000021           | 000025           | <pre><code>Sie überschritten die zulässige Höchstgeschwindigkeit innerhalb↵<div></div>geschlossener Ortschaften bei einer Sichtweite von weniger als 50 m↵<div></div>durch Nebel, Schneefall oder Regen um ... (von 21 - 25) km/h.↵<div></div>Zulässige Geschwindigkeit: 50 km/h.↵<div></div>Festgestellte Geschwindigkeit (nach Toleranzabzug): \*)... km/h.</pre></code> | § 3 Abs. 1, § 49 StVO; § 24, § 25 StVG; 9.1 BKat; § 4 Abs. 1 BKatV |


## License

Traffic code offense data (Tatbestandskatalog) is in the public domain according to [§ 5 UrhG](https://www.gesetze-im-internet.de/urhg/__5.html).

The rest of the repository is released under the WTFPL.
