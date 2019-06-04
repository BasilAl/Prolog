%sumlist(List,S) athroism
sumlist([],0).
sumlist([X],X):- integer(X).
sumlist([X|Xs],S):- sumlist(Xs,P), S is P+X.

%multlist(List,M) Ginomeno
multlist([],0).
multlist([X],S):- S is X,integer(X).
multlist([X|Xs],S):- multlist(Xs,P), S is P*X.
%listlength(List,L) mikos
listlength([],0).
listlength([_|Xs],L):- listlength(Xs,P), L is P+1.
%first_element(List, F)
first_element([],[]).
first_element([X|_],X).
%last_element(List,L)
last_element(X,L):- reverse(X,Y),first_element(Y,L).
%nth_element(List,N,E)

nth_element([X|_],1,X).
nth_element([_|Xs],N,E):-nth_element(Xs,M,E), N is M+1.
%element_position(List,E,N) epistrefei thesi
element_position(List,E,N):-nth_element(List,N,E).
%my_member(X,List) x member of list
my_member(X,[X|_]).
my_member(X,[_|Xs]):-my_member(X,Xs).
%my_select(X,List,Rest) X stoixeio tis listas, rest i ypoloipi lista
my_select(X,[X|Xs],Xs).
my_select(X,[Y|Ys],[Y|Zs]):-my_select(X,Ys,Zs).
%my_append(L1,L2,R). to R einai to apotelesma tis enwsis twn L1, L2.
my_append([],L,L).
my_append([X|Rest],L,[X|R]):- my_append(Rest,L,R).