/*	Facts	*/
discontiguous male/1.
discontiguous female/1.
discontiguous parent/2.

parent(giorgos_al,vasilis_al).
parent(ntina_an,vasilis_al).
parent(mitsos_an,ntina_an).
parent(mitsos_an,roula_an).
parent(anthoula_bo,ntina_an).
parent(anthoula_bo,roula_an).
parent(vasilis_al_s,giorgos_al).
parent(vasilis_al_s,lola_al).
parent(vasilis_al_s,anna_al).
parent(loukia_ka,giorgos_al).
parent(loukia_ka,lola_al).
parent(loukia_ka,anna_al).
parent(kostas_kal,stratos_kal).
parent(kostas_kal,sotiris_kal).
parent(lola_al,stratos_kal).
parent(lola_al,sotiris_kal).
parent(roula_an,anthi_kaf).
parent(vasilis_kaf,anthi_kaf).
parent(roula_an,eleftheria_kaf).
parent(vasilis_kaf,eleftheria_kaf).
parent(stavroula_bal,mitsos_an).
parent(giorgos_an_s,mitsos_an).
parent(stavroula_bal,tasos_an_s).
parent(giorgos_an_s,tasos_an_s).
parent(stavroula_bal,lakis_an).
parent(giorgos_an_s,lakis_an).
parent(lakis_an,tasos_an).
parent(lakis_an,giorgos_an).
parent(eirini_bo,tasos_an).
parent(eirini_bo,giorgos_an).
female(ntina_an).
female(anthoula_bo).
female(roula_an).
female(loukia_ka).
female(lola_al).
female(anna_al).
female(anthi_kaf).
female(eleftheria_kaf).
female(stavroula_bal).
female(eirini_bo).
male(giorgos_al).
male(vasilis_al).
male(mitsos_an).
male(vasilis_al_s).
male(kostas_kal).
male(sotiris_kal).
male(stratos_kal).
male(vasilis_kaf).
male(giorgos_an).
male(giorgos_an_s).
male(tasos_an_s).
male(tasos_an).
male(lakis_an).



/*	Relationships	*/

%Siblings(X,Y)
siblings(X,Y):-parent(P,X),parent(P,Y),X\=Y.


% Τα sib2-5 είναι ο τρόπος που είχαμε συζητήσει στην τάξη για να αποφεύγονται διπλές
% απαντήσεις. Τα 3 πρώτα δεν μου άρεσαν και το τελευταίο ήταν αρκετά πολύπλοκο οπότε δεν το άφησα.
/**/

sib2(X,Y) :- parent(P,X), parent(P,Y), (\+X=Y), !.
sib3(X,Y) :- setof((X,Y), P^(parent(P,X),parent(P,Y), \+X=Y), Sibs),
             member((X,Y), Sibs).
sib4(X,Y) :- setof((X,Y), P^(parent(P,X),parent(P,Y), X@<Y), Sibs),
             member((X,Y), Sibs).
sib5(X,Y) :- setof((X,Y),P^(parent(P,X),parent(P,Y), \+X=Y), Sibs),member((X,Y), Sibs),\+ (Y@<X, member((Y,X), Sibs)).

%Father(F,C)
father(Father,Child):-parent(Father,Child),male(Father).

%Mother(M,C)
mother(Mother,Child):-parent(Mother,Child),female(Mother).

%grandfather(gf,c)
grandfather(GF,C):-father(GF,P),parent(P,C).
%grandmother(gm,gc)
grandmother(GM,C):-mother(GM,P),parent(P,C).
%all_kids(kids,father) kids lista
all_kids(P, Ks):-findall(K,parent(P,K),Ks).
all_kids_F(F, Ks):-findall(K,father(F,K),Ks).
all_kids_M(M, Ks):-findall(K,mother(M,K),Ks).
%first cousins(X,Y)
first_cousins(X,Y):-parent(P,X), parent(Q,Y), siblings(P,Q).
%second_cousins(x,y)
second_cousins(X,Y):-parent(P,X),parent(Q,Y),first_cousins(P,Q).
%uncle(u,x)
uncle(U,X):-siblings(U,P),parent(P,X),male(U).
%aunt(a,x)
aunt(A,X):-siblings(A,P),parent(P,X),female(A).




