# BKAT-OWI

**tl;dr**: Download [data.csv](data.csv).

---

Tools for converting German traffic code offense data ("Bundeseinheitlicher Tatbestandskatalog" / "BT-KAT-OWI") to CSV.

The current version (2022-07-01) of [`data.txt`](data.txt) has been taken from [the KBA website](https://www.kba.de/DE/Themen/ZentraleRegister/FAER/BT_KAT_OWI/btkat_node.html).  
Additional documents are available at [FOIA request #216685](https://fragdenstaat.de/a/216685).

## File format

The txt file is similar to CSV, but uses a caret (`^`) as a separator. Other characters (such as `"` `,` `;`) are included unescaped. The file uses Windows-1252 encoding.

Some of the data fields span multiple columns.

The changelog (Änderungsverzeichnis on page 177, see #216685) mentions the format of the txt file as follows:

> Tatbestandsnummer, Tatbestand_Datenbank, Paragraphen_Datenbank, FaP, P, Euro, Gültig_bis, Gültig_von, Konkretisierung, Klassifizierung, Tatbestand_Druckdatei, Paragraphen_Druckdatei

This is not 100% accurate as there are more columns than mentioned, but the script in this repository tries to refer to those column names where possible (additional columns in bold):

> Tatbestandsnummer, Tatbestand_Datenbank, Paragraphen_Datenbank, FaP, P, Euro, **Klammer_A**, **Klammer_B**, **Klammer_C**, Gueltig_bis, Gueltig_von, **FV**, Konkretisierung, Klassifizierung, **Tabelle**, **Untergrenze**, **Obergrenze**, Tatbestand_Druckdatei, Paragraphen_Druckdatei

- **FaP**: *"Kategorie zur Fahrerlaubnis auf Probe gemäß [Anlage 12 FeV](https://www.gesetze-im-internet.de/fev_2010/anlage_12.html)"*
- **P**: *"Punkte gemäß [Anlage 13 FeV](https://www.gesetze-im-internet.de/fev_2010/anlage_13.html)"*
- **FV**: *"Fahrverbot"* (usually suffixed with "M" for months)

### Validity dates

The data purposely includes data that is no longer valid.  
`Gültig_von` gives the first day of validity (at `00:00`) while `Gültig_bis` gives the last day of validity (at `24:00`).  
Data valid for the foreseeable future is given as `Gültig_bis = 2099-12-31`.

## Converting to CSV

Running `convert.sh` will parse `data.txt` and output the [RFC 4180](https://tools.ietf.org/html/rfc4180) formatted, UTF-8 encoded [`data.csv`](data.csv) file.

The script requires `iconv`, `dos2unix`, and `sqlite3`.

The two separate columns for euros and cents are combined and converted to float. Other than that there is no data conversion, only basic concatenation and trimming. For details see [convert.sql](convert.sql).

## Preview


| Tatbestandsnummer | Tatbestand_Datenbank                                                                                                                                                                                                                                                                  | Paragraphen_Datenbank                                      | FaP | P | Euro  | Klammer_A  | Klammer_B | Klammer_C    | Gueltig_bis | Gueltig_von | FV | Konkretisierung | Klassifizierung | Tabelle | Untergrenze | Obergrenze | Tatbestand_Druckdatei                                                                                                                                                                                                                                                                                                                                                     | Paragraphen_Druckdatei                                     |
|:------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------|:----|:--|:------|:-----------|:----------|:-------------|:------------|:------------|:---|:----------------|:----------------|:--------|:------------|:-----------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------|
| 101000            | Sie kamen von der Fahrbahn ab und verursachten Sachschaden.                                                                                                                                                                                                                           | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  |     | 0 | 35.0  |            |           |              | 2021-07-27  | 2014-05-01  |    |                 | 4               |         |             |            | <pre><code>Sie kamen von der Fahrbahn ab und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                       | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  |
| 101000            | Sie kamen von der Fahrbahn ab und verursachten Sachschaden.                                                                                                                                                                                                                           | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  | B   | 1 | 35.0  |            |           |              | 2014-04-30  | 2002-01-01  |    |                 | 4               |         |             |            | <pre><code>Sie kamen von der Fahrbahn ab und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                       | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  |
| 101006            | Sie gerieten ins Schleudern und verursachten Sachschaden.                                                                                                                                                                                                                             | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  | B   | 1 | 35.0  |            |           |              | 2014-04-30  | 2002-01-01  |    |                 | 4               |         |             |            | <pre><code>Sie gerieten ins Schleudern und verursachten Sachschaden.</pre></code>                                                                                                                                                                                                                                                                                         | § 1 Abs. 2, § 49 StVO; § 24 StVG; -- BKat                  |
| 103637            | Sie überschritten die zulässige Höchstgeschwindigkeit innerhalb geschlossener Ortschaften bei einer Sichtweite von weniger als 50 m durch Nebel, Schneefall oder Regen um #D# km/h. Zulässige Geschwindigkeit: 50 km/h. Festgestellte Geschwindigkeit (nach Toleranzabzug): #G# km/h. | § 3 Abs. 1, § 49 StVO; § 24 Abs. 1, 3 Nr. 5 StVG; 9.1 BKat | A   | 1 | 175.0 | (Lkw usw.) |           | Tab.: 703000 | 2099-12-31  | 2021-11-09  |    |                 | 6               | 703000  | 000021      | 000025     | <pre><code>Sie überschritten die zulässige Höchstgeschwindigkeit innerhalb↵<div></div>geschlossener Ortschaften bei einer Sichtweite von weniger als 50 m↵<div></div>durch Nebel, Schneefall oder Regen um ... (von 21 - 25) km/h.↵<div></div>Zulässige Geschwindigkeit: 50 km/h.↵<div></div>Festgestellte Geschwindigkeit (nach Toleranzabzug): *)... km/h.</pre></code> | § 3 Abs. 1, § 49 StVO; § 24 Abs. 1, 3 Nr. 5 StVG; 9.1 BKat |


## License

Traffic code offense data (Tatbestandskatalog) is in the public domain according to [§ 5 UrhG](https://www.gesetze-im-internet.de/urhg/__5.html).

The rest of the repository is released under the WTFPL.
