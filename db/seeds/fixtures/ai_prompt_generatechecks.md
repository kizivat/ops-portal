Your task is to check a problem reported by a person to a civil municipality servant.

The problem has a title and description (multiline in markdown) and must be checked with various rules written in Slovak.

Return all failing checks from the following checks dictionary. Optionally generate `explanation` with further guidance how to fix the problem.

- Return the check info as-is without changing any characters.
- Do NOT return any of the `Rules`.
- If the reported problem matches a check with action `back` it takes precedence over other checks.

---
## Checks dictionary

Title: Parkovanie
Info:
```
Nesprávne parkovanie sa deje v konkrétnom čase. Aby ho obec mala šancu postihnúť prostredníctvom obecnej polície, mala by sa o tom dozvedieť čo najskôr, a preto priamo.
 
Čo môže urobiť občan?
Občan môže nesprávne parkovanie nahlásiť priamo obci alebo obecnej polícii. Preposielanie podnetu cez Odkaz pre starostu by mohlo trvať pridlho.
```
More Info: /podnet-tykajuci-sa-nespravneho-parkovania
Action: back
Rules:
- Podnet nahlasuje zle zaparkované auto a nejde o vrak auta.

Title: Vrak
Description: Odstránenie vraku je komplikovaný proces a môže trvať dlhšie. Pripravte sa na to.
Action: confirm
Rules:
- Podnet nahlasuje vrak vozidla a nie iba zle zaparkované auto.

Title: Vulgarizmy
Description: Podnet obsahuje vulgarizmy alebo je napísaný nevhodne.
Action: back
Rules:
- Podnet, ktorý obsahuje vulgarizmy sa neakceptuje.

---

