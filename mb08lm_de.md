# Live-Medium "Transparenzsoftware" des S.A.F.E. e.V.

Anforderungen und getroffene Maßnahmen gemäß [Merkblatt MB08][1].

## Dokumenthistorie

Version | Datum | Autor, Firma
---|---|---
v1.0.0 | 16.10.2020 | Marcel Jovic, Weidmüller Mobility Concepts GmbH

## Zusammenfassung

Dieses Dokument listet die Anforderungen des [Merkblatts MB08][1] der PTP sowie die getroffenen Maßnahmen des S.A.F.E. e.V. um diese Anforderungen zu erfüllen.

## Anforderungen und Maßnahmen

> **1. Eigenschaften der Hardware**
>
> Beim Einlegen eines Live-Mediums in einen Rechner wird das gesamte Betriebssystem mit der rechtlich relevanten Software in den Arbeitsspeicher (RAM) des Host-Rechners geladen. Es sind keine speziellen Absicherungsmaßnahmen auf dem Host-Rechner zum Betrieb des Live-Mediums notwendig.
> 1. Das Live-Medium muss dauerhaft schreibgeschützt sein. 

Das Live-Medium wird als ISO-Datei und zugehörigem Hash-Wert einer kryptografisch sicheren Streuwertfunktion (SHA256) angeboten, um beispielsweise von einem externen USB-Datenspeicher oder einer DVD als startbares Live-System eingesetzt zu werden.

Während es technisch möglich ist eine ISO-Datei nachträglich zu verändern, ist dies kein üblicher Gebrauch einer solchen Datei. Eine solche Veränderung der Datei wäre vor Gebrauch über den Hash-Wert erkennbar.

Das Live-Medium stellt ein reines Live-System bereit. Teile des Live-Systems laufen im Betrieb weiterhin von dem Live-Medium. Von dem Host-System wird lediglich der Arbeitsspeicher als Datenspeicher genutzt. Eine Installation ist nicht möglich. Das Live-Medium wird auch im Betrieb nicht verändert.

> **2. Bootvorgang und Laden der rechtlich relevanten Software**
>
> Die Eigenschaft der Reproduzierbarkeit des Live-Systems auf einem anderen Host-Rechner ersetzt den Vertrauensanker von dauerhaft installierten Betriebssystemen.
> 1. Der Bootloader des Live-Mediums muss so konfiguriert sein, dass am Ende des Bootvorgangs nur das Betriebssystem mit der rechtlich relevanten Software in den Arbeitsspeicher des Host-Rechners geladen wird. 

Grundsätzlich wurde eine minimale Auswahl an Softwarepaketen getroffen.

Der Bootloader ist ein Hybrid aus `syslinux` und `systemd-boot`, um das Starten des Live-Mediums sowohl von BIOS-Systemen über MBR als auch von UEFI-Systemen über GPT zu unterstützen, um eine möglichst große Kompatibilität zu den potentiell eingesetzten Host-System zu erreichen.

In beiden Fällen werden als erstes die RAM-Disk-Images der Microcode-Updates von Intel und AMD geladen. Anschließend wird die RAM-Disk des Linux-Kernels geladen und der weitere Startvorgang von Linux selbst fortgeführt.

Das Linux-System nimmt die Hardware des Host-Systems in Betrieb, aktiviert Netzwerkfunktionalitäten (sofern verfügbar) und startet mit einem nicht-privilegierten Standardbenutzer in die Desktop-Umgebung. Die Transparenzsoftware wird anschließend ebenfalls gestartet.

Das Live-Medium startet ausschließlich von dem eingesetzten tatsächlichen Medium und verändert sich selbst und das Host-System nicht. Dadurch ist die Reproduzierbarkeit auf dem eingesetzten, sowie anderen Host-Systemen, gewährleistet. 

Bootloader, Microcode-Updates, Linux-Kernel und Firmware (für ggf. spezifische eingesetzte Hardware auf dem Host-System) werden zwingend benötigt, um das Starten des Live-Systems überhaupt zu ermöglichen.

Die Transparenzsoftware ist eine Java-Anwendung mit grafischer Benutzerschnittstelle. Daher wird für den bestimmungsgemäßen Gebrauch zusätzlich zur Transparenzsoftware eine minimale Desktop-Umgebung (XWayland, Mutter, GNOME-Shell) und eine Java-Laufzeitumgebung (JRE-OpenJDK) zur Verfügung gestellt. Um den Anwender den Zugang zu den zu verifizierenden Daten zu ermöglichen sind ebenfalls ein Web-Browser (Firefox), minimale Netzwerkfunktionalitäten (NetworkManager) und ein Datei-Browser (Nautilus) sowie gängige Dateisystemunterstützung für externe Speichermedien (FAT, exFAT, NTFS) enthalten.

> **3. Schutz in Verwendung**
>
> 1. Das Nachladen oder Ausführen von Software aus weiteren Datenspeichern muss unterbunden
werden.
> 2. Nach dem Inverkehrbringen des Live-Mediums darf das System nicht mehr administrierbar
sein.

Externe Datenspeicher werden mit der Mount-Option `noexec` in das System eingehangen. Der im Live-System bereitgestellte Benutzer hat nicht die erforderlichen Rechte, um dies zu ändern.

Ein Root-Login ist nicht vorgesehen.

> **4. Prüfbarkeit und Nachweisbarkeit**
> 1. Über das Live-Medium als Datenträger muss ein kryptographischer Hash gebildet werden.
> 2. Der Hashwert muss für den Verwender überprüfbar sein.

Zur Verifizierung wird der Hash-Wert der Streuwertfunktion SHA256 über die ISO-Datei des Live-Mediums angeboten.

Programme, um einen solchen Hash-Wert zu errechnen, sind auf den gängigen Betriebssystemen vorhanden.

Windows:

```
certutil -hashfile transparenzsoftware.iso SHA256
```

macOS:

```
shasum -a 256 transparenzsoftware.iso
```

Linux:

```
sha256sum transparenzsoftware.iso
```

Letzteres ist Bestandteil der OpenSSL-Bibliothek und steht auch für andere Betriebssysteme bereit.

Der Dateiname _transparenzsoftware.iso_ ist bei Abweichung entsprechend anzupassen.

## Zusätzliche nennenswerte Maßnahmen

Die Transparenzsoftware kann zur Laufzeit über sich selbst einen SHA256-Hash-Wert bilden. Dies ist verfügbar über den _Über_-Dialog der Software.

Es wird ein [_gehärteter_ Linux-Kernel][2] eingesetzt. Mittels diversen Patch-Sets und Compiler-Optionen wird hier ein Fokus auf Sicherheit (auf Kosten der Performance) gesetzt.

Für Nachvollziehbarkeit und Transparenz sind [die benötigten Daten und Schritte zur Erstellung des Live-Mediums auf GitHub][3] verfügbar. Dieses Dokument ist Bestandteil der dort zur Verfügung gestellten Daten.

[1]: https://www.ptb.de/cms/fileadmin/internet/fachabteilungen/abteilung_8/8.5_metrologische_informationstechnik/8.51/PTB-8.51-MB05-BS-DE-V07.pdf
[2]: https://github.com/anthraxx/linux-hardened
[3]: https://github.com/safe-ev/live-media
