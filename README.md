# Softonica Database

**Wersja specyfikacji:** 1.1

Struktura bazy danych dla systemu Softonica.

## Podział na domeny

- **Common** - Wspólna domena dla wszystkich.
- **Economy** - Domena ekonomi, zawierająca obiekty dotyczące konta aktywów, transakcji i wszystko powiązane z nimi.
- **Profilling** - Domena zawierająca obiekty związane z profilem użytkownika.
- **Projects** - Domena zawierająca obiekty projektów wykonywanych w ramach systemu.
- **Social** - Domena społecznościowa. Zawiera obiekty takie jak forum, oceny czy komentarze.
- **System** - Domena systemowa. Zawiera obiekty niezbędne do obsługi systemowej użytkownika.

## Tabele

- **accounts** - Konta aktywów na których znajdują się wirtualne pieniądze każdego użytkownika uczestniczącego w grze.
- **assignedtags** - Informacja o przypisanym tagu. Składa się z tagu oraz celu. Celem może być projekt usługa, produkt cyfrowy lub zespół.
- **badges** - Odznaczenia jakie mogą być zdobywane przez użytkowników po osiągnięciu pewnego progu konta aktywów lub wykonania zadania.
- **collaborations** - Zawiera informacje o systemie odpowiedzialnym za organizację pracy projektu.
- **comments** - Komentarze do projektu, produktu cyfrowego lub usługi.
- **contributors** - Informacje o współtwórcach danego projektu.
- **experiences** - Doświadczenie użytkownika. Zawiera informacje o umiejętności oraz spędzonym czasie nad technologią lub daną czynnością.
- **forums** - Forum dyskusyjne tworzone przez użytkowników.
- **marketplaces** - Wirtualny sklep, w którym wystawiane są produkty cyfrowe lub usługi przez innych uczestników, tworzone w ramach projektów.
- **members** - Członkowie danego zespołu.
- **notifications** - Powiadomienia kierowane do danego użytkownika oraz ich status.
- **posts** - Posty zamieszczane na forum dyskusyjnym.
- **products** - Produkty cyfrowe dodawane do wirtualnego sklepu. Tworzone w ramach projektów.
- **profiles** - Profil użytkownika. Do niego przypisane jest konto aktywów oraz wszelka aktywność w ramach Softonica. Profilem użytkownik reprezentuje się w systemie.
- **projectcategories** - Kategorie projektów w celu ich klasyfikacji.
- **projects** - Projekty tworzone w ramach Softonica, na których inni uczestnicy zarabiają wirtualne pieniądze. Produkty będący wynikiem projektu mogą być wystawiane w wirtualnym sklepie. Projekty to główny cel w całym systemie Softonica.
- **projecttypes** - Typ projektu służący do ich klasyfikacji.
- **pucharses** - Informacje o zakupie produktów cyfrowych lub usług z danego sklepu. Prowadzonego przez innego uczestnika.
- **ratings** - Informacje o dodanej ocenie. Oceniane mogą być projekty, produkty cyfrowe lub usługi.
- **releases** - Wydanie gotowego produktu tworzonego w ramach projektów. Może być automatycznie wystawiany w wirtualnym sklepie.
- **repositories** - Repozytoria kodu, w którym zamieszcany jest kod źródłowy tworzonych projektów. Mogą być to usługi zarówno zewnętrzne jak i wewnętrzne.
- **resetpasswords** - Żądania o zresetowanie hasła. Każde żądanie wygasa po odpowiednim czasie. Użytkownik w tym czasie musi kliknąć na odpowiedni link w celu potwierdzenia i zmiany hasła.
- **services** - Usługi świadczone przez użytkowników, do których można uzyskać dostęp po ich odpowiednim wykupieniu w wirtualnym sklepie.
- **skills** - Definicje umiejętności posiadanych przez uczestników.
- **skilltypes** - Typ umiejętności jakie są poszukiwane.
- **subscriptions** - Informacja o subksrypcji danej usługi. Na podstawie tej informacje obciążane jest wirtualne konto użytkownika.
- **tags** - Tagi tworzone przez użytkowników.
- **teams** - Zespoły, pozwalające uczestnikom łączyć się w grupy.
- **transactioncategories** - Kategorie transkacji w celu uproszczonej klasyfikacji.
- **transactions** - Transakcje związane z wirtualną walutą, obciążający lub doładowujący konto aktywów uczestnika.
- **users** - Konto użytkownika przeznaczone do funkcji systemowych.
- **verifications** - Informacje o weryfikacji konta użytkownika. W celu jego założenia wymagane jest potwierdzenie, które ma swoją ważność.