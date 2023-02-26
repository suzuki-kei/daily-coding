
main :-
    write_ln('Books:'),
    books(Books),
    write_elements(Books),
    nl,

    write_ln('Execute following query:'),
    write_ln('recommend(Book).'),
    nl.

write_elements([]) :-
    true.

write_elements([X|Xs]) :-
    write_ln(X),
    write_elements(Xs).

recommend(Book) :-
    books(Books),
    filter_books(Book, Books, 'ja', 0, 10000).

filter_books(_, [], _, _, _) :-
    true.

filter_books(Book, [Book|_], Language, MinPrice, MaxPrice) :-
    language(BookLanguage, Book),
    BookLanguage == Language,
    price(BookPrice, Book),
    MinPrice =< BookPrice,
    BookPrice =< MaxPrice.

filter_books(Book, [_|Books], Language, MinPrice, MaxPrice) :-
    filter_books(Book, Books, Language, MinPrice, MaxPrice).

