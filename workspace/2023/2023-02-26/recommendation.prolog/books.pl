
books(Books) :-
    Books = [
        book('プログラミング言語C', 'ja', 2800),
        book('C Programming Language', 'en', 2800),
        book('Scheme手習い', 'ja', 3000),
        book('The Little Schemer', 'en', 5800),
        book('Scheme修行', 'ja', 3000),
        book('The Seasoned Schemer, second edition', 'en', 2500)].

title(Title, book(Title, _, _)).
language(Language, book(_, Language, _)).
price(Price, book(_, _, Price)).

