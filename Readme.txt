V tomto repozitáři ukládám své vypracované domácí úkoly.

Úloha 1
========
  Tuto úlohu jsem již sice odevzdával, ale přesto jsem aspoň upravil její strukturu aby vyhovovala požadavkům
  z 8. přednášky. Zároveň jsem upravil způsob vstupu: Soubor se vstupními daty musí být uveden jako první parametr
  příkazové řádky.

Úloha 2
========
  Vstup není čten ze souboru ale zadává se interaktivně.

Úloha 4
========
  Pokud jsem správně pochopil zadání této úlohy, měla být výsledkem aplikace, která jakoukoliv vstupní zprávu dešifruje
  tak, že ASCII kód každého znaku sníží o konstantu 7 (to je klíč, který lze vypozorovat ze vzorového vstupu a   výstupu).
  
  Aplikaci jsem si dovolil trochu rozšířit. Je-li jako argument příkazové řádky zadána cesta k souboru se zašifrovanou
  zprávou, aplikace ji dešifruje monoalfabetickou substituční šifrou s klíčem 7 (splňuje vzorové zadání). Volitelně,
  pomocí přepínačů, však lze zadat jiný šifrovací klíč a aplikaci lze použít i k šifrování (nejen k dešifrování).
  Popis správného použití aplikace se zobrazí, je-li spuštěna z příkazové řádky bez parametrů nebo s přepínačem "-h".

Úloha 5
========
  Tato úloha vyžaduje jako první parametr příkazové řádky cestu k souboru se vstupními daty.

  Podle zadání úlohy jsem se domníval, že každý fragment je dán na řádce nejprve X-souřadnicí svého levého konce (Li)
  a poté X-souřadnicí svého pravého konce (Ri). Proto jsem do aplikace zahrnul kontrolu, aby levá X-souřadnice každého
  fragmentu byla menší nebo rovna pravé souřadnici téhož fragmentu (připouští se tak i fragment nulové délky).
  
  Ve vzorovém zadání jsem však narazil na řádek na němž je zadán fragment "5 3" (levá souřadnice je větší než
  pravá). V tomto bodě předpokládám, že jde o překlep a že to mělo být asi "-5 3" nebo "3 5" a v zadání jsem si tento
  řádek opravil - doufám, že to nebude problém při hodnocení.