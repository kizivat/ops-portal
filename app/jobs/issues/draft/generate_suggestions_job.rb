class Issues::Draft::GenerateSuggestionsJob < ApplicationJob
  queue_as :default

  def perform(draft)
    draft.suggestions = generate_suggestions(draft)
    draft.save!
  end

  private

  SYSTEM_PROMPT = <<-LLM
    Your task is to analyze a photo that was uploaded by a citizen reporting a problem in municipality.

    You should carefully look at the photo and suggest a title and description of distinct problems that will be approved by a human later.#{' '}
    Title should be descriptive and less than 100 characters, description must be concise a clear so a civil servant will understand it.

    Never suggest more than 3 problems, try to suggest 2 problems.
    Suggestions should not have duplicates.
    Do not suggest vague or ambiguous issues.
    If you are unsure about the problem in the photo say so.

    Return response in Slovak language in JSON array, where each suggestion is a map with keys `title`, `description`, `category`, `subcategory` and `subtype`.
    `category` and `subcategory` are mandatory, `subtype` is optional.
    Resulting array should be sorted from highest to lowest confidence.
    Return empty array `[]` and nothing else if there are no problems on the photo.

    Available categories, subcategories, and subtypes (make sure you return the exact same strings):
    | Category                   | Subcategory          | Subtype             |
    | -------------------------- | -------------------- | --------------------|
    | Zeleň a životné prostredie | neporiadok a odpadky | neodpratané lístie |
    | Zeleň a životné prostredie | neporiadok a odpadky | čierne skládky |
    | Zeleň a životné prostredie | neporiadok a odpadky | neporiadok vo verejnom priestranstve |
    | Zeleň a životné prostredie | iné | - |
    | Zeleň a životné prostredie | strom | suchý |
    | Zeleň a životné prostredie | strom | chýbajúci |
    | Zeleň a životné prostredie | strom | neorezaný |
    | Zeleň a životné prostredie | strom | zlomený konár |
    | Zeleň a životné prostredie | strom | napadnutý |
    | Zeleň a životné prostredie | strom | invazívna rastlina |
    | Zeleň a životné prostredie | strom | poškodená podpera |
    | Zeleň a životné prostredie | trávnatá plocha | nepokosená |
    | Zeleň a životné prostredie | trávnatá plocha | vyschnutá |
    | Zeleň a životné prostredie | trávnatá plocha | vyjazdené koľaje |
    | Zeleň a životné prostredie | krík | suchý |
    | Zeleň a životné prostredie | krík | neostrihaný |
    | Zeleň a životné prostredie | krík | chýbajúci |
    | Zeleň a životné prostredie | zviera | túlavé |
    | Zeleň a životné prostredie | zviera | uhynuté |
    | Zeleň a životné prostredie | zviera | deratizácia |
    | Zeleň a životné prostredie | znečisťovanie | ovzdušia |
    | Zeleň a životné prostredie | znečisťovanie | vody |
    | Zeleň a životné prostredie | znečisťovanie | pôdy |
    | Mestský mobiliár | lavička | chýbajúca |
    | Mestský mobiliár | lavička | poškodená |
    | Mestský mobiliár | lavička | znečistená |
    | Mestský mobiliár | socha, pamätník | znečistená |
    | Mestský mobiliár | socha, pamätník | poškodená |
    | Mestský mobiliár | zastávka MHD | poškodená |
    | Mestský mobiliár | zastávka MHD | chýbajúca |
    | Mestský mobiliár | zastávka MHD | znečistená |
    | Mestský mobiliár | kôš | poškodený |
    | Mestský mobiliár | kôš | preplnený |
    | Mestský mobiliár | kôš | chýbajúci |
    | Mestský mobiliár | kôš | nevhodne umiestnený |
    | Mestský mobiliár | kôš | chýbajúce sáčky |
    | Mestský mobiliár | detské ihrisko | poškodené |
    | Mestský mobiliár | detské ihrisko | chýbajúce |
    | Mestský mobiliár | detské ihrisko | potrebná údržba |
    | Mestský mobiliár | cyklostojan | chýbajúci |
    | Mestský mobiliár | cyklostojan | poškodený |
    | Mestský mobiliár | cyklostojan | zle umiestnený |
    | Mestský mobiliár | iné | - |
    | Mestský mobiliár | fontánka | nefunkčná |
    | Mestský mobiliár | fontánka | poškodená |
    | Mestský mobiliár | fontánka | znečistená |
    | Mestský mobiliár | informačná tabuľa | poškodená |
    | Mestský mobiliár | informačná tabuľa | zle otočená |
    | Mestský mobiliár | informačná tabuľa | zle umiestnená |
    | Mestský mobiliár | informačná tabuľa | chýbajúca |
    | Mestský mobiliár | kvetináč | poškodený |
    | Mestský mobiliár | kvetináč | posunutý |
    | Mestský mobiliár | kvetináč | zanedbaný |
    | Mestský mobiliár | kvetináč | chýbajúci |
    | Verejné služby | iné | - |
    | Verejné služby | MHD | technické problémy |
    | Verejné služby | MHD | meškanie spojov |
    | Verejné služby | MHD | poškodené vozidlo |
    | Verejné služby | MHD | zlé nastavenie cestovného poriadku |
    | Verejné služby | kanalizácia | upchatá |
    | Verejné služby | kanalizácia | chýbajúci kanalizačný poklop |
    | Verejné služby | kanalizácia | havária kanalizačného potrubia |
    | Verejné služby | kanalizácia | poškodený kanalizačný poklop |
    | Verejné služby | osvetlenie | nefunkčné |
    | Verejné služby | osvetlenie | poškodené stĺpy |
    | Verejné služby | osvetlenie | chýbajúce/nedostatočné |
    | Verejné služby | osvetlenie | nevhodné (silné a pod.) |
    | Verejné služby | webová stránka mesta | chýbajúce informácie |
    | Verejné služby | webová stránka mesta | neaktuálne informácie |
    | Verejné služby | webová stránka mesta | nesprávne informácie |
    | Verejné služby | webová stránka mesta | nefunkčná stránka |
    | Verejné služby | rozvodné siete | poškodená rozvodná skriňa |
    | Verejné služby | rozvodné siete | nebezpečný kábel |
    | Verejné služby | zdieľaná mobilita | nevhodne zaparkovaný dopravný prostriedok |
    | Verejné služby | zdieľaná mobilita | nevhodne umiestnené parkovisko |
    | Verejné služby | zdieľaná mobilita | obmedzenie rýchlosti v zóne |
    | Verejné služby | zdieľaná mobilita | iné |
    | Cesty a chodníky | schody | poškodené |
    | Cesty a chodníky | schody | neodhrnuté |
    | Cesty a chodníky | schody | neposypané |
    | Cesty a chodníky | schody | znečistené |
    | Cesty a chodníky | cesta | výtlk |
    | Cesty a chodníky | cesta | rozbitá (väčší úsek) |
    | Cesty a chodníky | cesta | znečistená |
    | Cesty a chodníky | cesta | neodhrnutá |
    | Cesty a chodníky | cesta | neposypaná |
    | Cesty a chodníky | cesta | rozkopaná |
    | Cesty a chodníky | cesta | poškodená dlažba |
    | Cesty a chodníky | chodník | výtlk |
    | Cesty a chodníky | chodník | znečistený |
    | Cesty a chodníky | chodník | neodhrnutý |
    | Cesty a chodníky | chodník | neposypaný |
    | Cesty a chodníky | chodník | bariérový |
    | Cesty a chodníky | chodník | rozkopaný |
    | Cesty a chodníky | chodník | chýbajúci |
    | Cesty a chodníky | chodník | poškodená dlažba |
    | Cesty a chodníky | chodník | bariéra na chodníku |
    | Cesty a chodníky | cyklotrasa | poškodená |
    | Cesty a chodníky | cyklotrasa | chýbajúca |
    | Cesty a chodníky | cyklotrasa | neoznačená |
    | Cesty a chodníky | cyklotrasa | znečistená |
    | Cesty a chodníky | cyklotrasa | neodhrnutá |
    | Cesty a chodníky | cyklotrasa | neposypaná |
    | Cesty a chodníky | zábradlie | chýbajúce |
    | Cesty a chodníky | zábradlie | poškodené |
    | Cesty a chodníky | zábradlie | zhrdzavené |
    | Cesty a chodníky | oplotenie | chýbajúce |
    | Cesty a chodníky | oplotenie | poškodené |
    | Cesty a chodníky | oplotenie | zhrdzavené |
    | Cesty a chodníky | iné | - |
    | Verejný poriadok | stavby a budovy | neohlásené stavebné úpravy |
    | Verejný poriadok | stavby a budovy | prekračovanie limitov hluku |
    | Verejný poriadok | stavby a budovy | prekračovanie limitov prašnosti |
    | Verejný poriadok | stavby a budovy | opustená budova |
    | Verejný poriadok | stavby a budovy | zlý stav budovy |
    | Verejný poriadok | vandalizmus | graffiti |
    | Verejný poriadok | vandalizmus | rušenie nočného pokoja |
    | Verejný poriadok | vandalizmus | pitie alkoholu na verejnosti |
    | Verejný poriadok | reklama | vizuálny smog |
    | Verejný poriadok | reklama | nevhodne umiestnená (na chodníku a pod.) |
    | Verejný poriadok | reklama | vylepené plagáty |
    | Verejný poriadok | reklama | nebezpečná (na spadnutie a pod.) |
    | Verejný poriadok | iné | - |
    | Dopravné značenie | priechod pre chodcov | chýbajúci |
    | Dopravné značenie | priechod pre chodcov | zle viditeľný |
    | Dopravné značenie | semafor | nefunkčný |
    | Dopravné značenie | semafor | zle nastavený |
    | Dopravné značenie | semafor | chýbajúci |
    | Dopravné značenie | dopravné zrkadlo | chýbajúce |
    | Dopravné značenie | dopravné zrkadlo | zle natočené |
    | Dopravné značenie | dopravné zrkadlo | poškodené |
    | Dopravné značenie | vodorovná značka | chýbajúca |
    | Dopravné značenie | vodorovná značka | neaktuálna |
    | Dopravné značenie | vodorovná značka | zle viditeľná |
    | Dopravné značenie | riešenie dopravnej situácie | nebezpečné |
    | Dopravné značenie | riešenie dopravnej situácie | dopravu spomaľujúce |
    | Dopravné značenie | riešenie dopravnej situácie | nedodržiavanie dopravných predpisov |
    | Dopravné značenie | iné | - |
    | Dopravné značenie | zvislá značka | poškodená |
    | Dopravné značenie | zvislá značka | neaktuálna |
    | Dopravné značenie | zvislá značka | chýbajúca |
    | Dopravné značenie | zvislá značka | vyblednutá |
    | Dopravné značenie | zvislá značka | zle otočená |
    | Dopravné značenie | spomaľovač | chýbajúci |
    | Dopravné značenie | spomaľovač | poškodený |
    | Dopravné značenie | betónová zábrana (biskupský klobúk) | chýbajúca |
    | Dopravné značenie | betónová zábrana (biskupský klobúk) | posunutá |
    | Dopravné značenie | betónová zábrana (biskupský klobúk) | poškodená |
    | Dopravné značenie | stĺpik | chýbajúci |
    | Dopravné značenie | stĺpik | poškodený |
    | Dopravné značenie | stĺpik | nadbytočný |
    | Automobily | dlhodobo odstavené vozidlá | vozidlo s EČV, s platnou TK a EK |
    | Automobily | dlhodobo odstavené vozidlá | vozidlo bez EČV,  s platnou TK a EK |
    | Automobily | dlhodobo odstavené vozidlá | vozidlo bez EČV, bez platnej TK a EK |
    | Automobily | dlhodobo odstavené vozidlá | vozidlo s EČV, bez platnej TK a EK |
    | Automobily | dlhodobo odstavené vozidlá | nezistené EČV a TK a EK |
    | Automobily | dlhodobo odstavené vozidlá | zahraničné vozidlo |
    | Automobily | parkovanie | problémové |
    | Automobily | parkovanie | chýbajúce miesta |
    | Automobily | parkovanie | nevyznačené miesta |
    | Automobily | iné | - |

  LLM

  def generate_suggestions(draft)
    Gemini.generate(
      messages: [ "" ] + draft.photos,
      system_prompt: SYSTEM_PROMPT,
    )
  end
end
