
male(namihei).
male(masuo).
male(katsuo).
male(tara).

female(fune).
female(sazae).
female(wakame).

parent(namihei, sazae).
parent(namihei, katsuo).
parent(namihei, wakame).
parent(fune, sazae).
parent(fune, katsuo).
parent(fune, wakame).
parent(masuo, tara).
parent(sazae, tara).

married(X, Y) :- parent(X, Child), parent(Y, Child).
father(Parent, Child) :- parent(Parent, Child), male(Parent).
mother(Parent, Child) :- parent(Parent, Child), female(Parent).
child(Child, Parent) :- parent(Parent, Child).

