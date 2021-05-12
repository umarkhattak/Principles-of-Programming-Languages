/* #1 DONE */
range(X,Y,Z) :- 
X =< Y, X =< Z, Z =< Y.

?- range(1,2,2).
?- not(range(1,2,3)).

/* #2 DONE */
help([], X, X).
help([Xs | Y], Z, [Xs | Ys]):- 
help(Y, Z, Ys).
reverseL([], []).
reverseL([X1 | Y1], Z1):-
reverseL(Y1, RevX), help(RevX, [X1], Z1).

?- reverseL([],X).
?- reverseL([1,2,3],X).
?- reverseL([a,b,c],X).

/* #3 DONE */
memberL(X, Y):- 
append(_, [X | _], Y).

?- not(memberL(1, [])).
?- memberL(1,[1,2,3]).
?- not(memberL(4,[1,2,3])).
?- memberL(X, [1,2,3]).

/* #4 DONE */
zip([], [], []).
zip([], [_ | _], []).
zip([_ | _], [], []).
zip([X | Xs], [Y | Ys], [X - Y | Z]):-
zip(Xs, Ys, Z).

?- zip([1,2],[a,b],Z).
?- zip([a,b,c,d], [1,X,y], Z).
?- zip([a,b,c],[1,X,y,z], Z).
?- length(A,2), length(B,2), zip(A, B, [1-a, 2-b]).

/* #5 DONE */
insert(X, [], [X]):- 
!.
insert(X, [Xs | Ys], [X, Xs | Ys]):- 
Xs > X , !.
insert(X, [Xs | Ys], [Xs | Zs]):- 
insert(X, Ys, Zs). 

?- insert(3, [2,4,5], L).
?- insert(3, [1,2,3], L).
?- not(insert(3, [1,2,4], [1,2,3])).
?- insert(3, L, [2,3,4,5]).
?- insert(9, L, [1,3,6,9]).
?- insert(3, L, [1,3,3,5]).

/* #6 DONE */
help(_, [], []):- 
!.
help(X, [X | Xs], Y):- 
!, help(X, Xs, Y).
help(X, [Ys | Xs], Y):- 
!, help(X, Xs, Z), append([Ys], Z, Y).
remove_duplicates([], []).
remove_duplicates([X | Y], Zs):- 
help(X, Y, L1), remove_duplicates(L1, L2), append([X], L2, Zs).

?- remove_duplicates([1,2,3,4,2,3],X).
?- remove_duplicates([1,4,5,4,2,7,5,1,3],X).
?- remove_duplicates([], X).

/* #7 DONE */
intersectionL([], _, []):- 
!.
intersectionL(_, [], []):- 
!.
intersectionL([X | L1], L2, [X | T3]):- 
member(X, L2), intersectionL(L1, L2, T3), !.
intersectionL([_ | L1], L2, L3):- 
intersectionL(L1, L2, L3).

?- intersectionL([1,2,3,4],[1,3,5,6],[1,3]).
?- intersectionL([1,2,3,4],[1,3,5,6],X).
?- intersectionL([1,2,3],[4,3],[3]).

/* #8 DONE */
prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).

partition([], [], []).
partition([X],[X],[]). 
partition(L, P, S):-
length(L, Y), Var is div(Y, 2), Var1 is Y - div(Y, 2), length(Ps, Var), length(Ss, Var1), prefix(Ps, L), suffix(Ss, L), P = Ps, S = Ss.

?- partition([a],[a],[]).
?- partition([1,2,3],[1],[2,3]).
?- partition([a,b,c,d],X,Y).

/* #9 DONE */
merge([], [], []):- 
!.
merge(X, [], X):- 
!. 
merge([], Y, Y):- 
!. 
merge([Xs|X], [Ys | Y], Zs):- 
Xs < Ys, merge(X, [Ys | Y], Z), append([Xs], Z, Zs), !.
merge(X, [Ys | Y], Zs):- 
merge(X, Y, Z), append([Ys], Z, Zs).

?- merge([],[1],[1]).
?- merge([1],[],[1]).
?- merge([1,3,5],[2,4,6],X).

/* #10 DONE */
mergesort([], []).
mergesort([X], [X]).
mergesort([X, Y | L], SL):-
split([X, Y | L], Ls, L1), mergesort(Ls, Xs), mergesort(L1, X1), merge(Xs, X1, SL).
split([], [], []).
split([X], [X], []).
split([X, Y | L], [X | Zs], [Y | Z1]):- 
split(L, Zs, Z1).
merge(X, [], X).
merge([], Y, Y).
merge([X | Zs], [Y | Z1], [X | A]):- 
X @=< Y, merge(Zs, [Y | Z1], A).
merge([X | Zs], [Y | Z1], [Y | A]):- 
X @> Y, merge([X | Zs], Z1, A).

?- mergesort([3,2,1],X).
?- mergesort([1,2,3],Y).
?- mergesort([],Z).