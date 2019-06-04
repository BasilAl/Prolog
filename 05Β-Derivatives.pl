differentiate(F, SDF) :- diff(F, DF), simpl(DF, SDF).

diff(C, 0) :- integer(C).                                       /* 1 */
diff(x, 1).                                                     /* 2 */
diff(F+G, DF+DG) :- diff(F, DF), diff(G, DG).                   /* 3 */
diff(-F, -DF) :- diff(F, DF).                                   /* 4 */
diff(F-G, DF-DG) :- diff(F, DF), diff(G, DG).                   /* 5 */
diff(C*F, C*DF) :- integer(C), !, diff(F, DF).                  /* 6 */
diff(F*G, F*DG+G*DF) :- diff(F, DF), diff(G, DG).               /* 7 */
diff(F/G, (G*DF-F*DG)/G^2) :- diff(F, DF), diff(G, DG).         /* 8 */
diff(F^C, C*F^(C-1)*DF) :- integer(C), diff(F, DF).             /* 9 */
diff(sin(F), cos(F)*DF) :- diff(F, DF).                        /* 10 */
diff(cos(F), -sin(F)*DF) :- diff(F, DF).                       /* 11 */
diff(log(F), (1/F)*DF) :- diff(F, DF).                         /* 12 */
diff(exp(F), exp(F)*DF) :- diff(F, DF).                        /* 13 */


simpl(F, SF2) :- simplify(F, SF1),!,  simpl(SF1, SF2).
simpl(F, F).

simplify(A+B, C) :- integer(A), integer(B), !, C is A+B.
simplify(A-B, C) :- integer(A), integer(B), !, C is A-B.
simplify(A*B, C) :- integer(A), integer(B), !, C is A*B.
simplify(0+F, F) :- !.
simplify(F+0, F) :- !.
simplify(1*F, F) :- !.
simplify(F*1, F) :- !.
simplify(0*_, 0) :- !.
simplify(_*0, 0) :- !.
simplify(-F, -SF) :- simplify(F, SF).
simplify(F+G, F+SG) :- simplify(G, SG).
simplify(F+G, SF+G) :- simplify(F, SF).
simplify(F-G, F-SG) :- simplify(G, SG).
simplify(F-G, SF-G) :- simplify(F, SF).
simplify(F*G, F*SG) :- simplify(G, SG).
simplify(F*G, SF*G) :- simplify(F, SF).
simplify(F/G, F/SG) :- simplify(G, SG).
simplify(F/G, SF/G) :- simplify(F, SF).
simplify(F^G, F^SG) :- simplify(G, SG).
simplify(F^G, SF^G) :- simplify(F, SF).
simplify(F*(G*H), (F*G)*H).


/*

Τα diff ορίζουν τους βασικούς κανόνες παραγώγισης(με κάποιους 
περιορισμούς πχ ως προς τους σταθερούς όρους και συντελεστές(αν δεν είναι ακέραιοι, τότε
εφαρμόζονται σε αυτούς οι κανόνες παραγώγισης σαν να ήταν συναρτήσεις και έχουμε περίεργα
αποτελέσματα του είδους d((5/8)*χ^2)/dχ = 5/8*2*x+x^2*(0/8^2) ) ως προς τις μεταβλητές 
παραγώγισης κλπ). 
Τα simplify ορίζουν επίσης κάποιους βασικούς κανόνες απλοποίησης παραστάσεων και το 
simpl διατρέχει μια μεγαλύτερη παράσταση και κάνει επί μέρους απλοποιήσεις μέχρι να 
τερματίσει σε μια απλοποιημένη μορφή.
Ο συνδυασμός του cut με την τερματική συνθήκη στο τέλος σιγουρεύει πως θα υπάρχει μοναδικό 
αποτέλεσμα της simpl. Αν το simplify επιτύχει, τότε δοκιμάζει περιταίρω απλοποίηση της
παράστασης, αλλιώς εάν αποτύχει(δεν είναι σε μορφή απλοποιήσιμη με βάση τους κανόνες),
το αφήνει ως έχει.
Εαν δεν υπήρχε το cut, τότε θα έκανε backtrack και θα έψαχνε και για άλλη λύση, και 
έτσι δεν θα είχαμε μονοσήμαντο στην απλοποιημένη μορφή. Ομοίως με την τερματική συνθήκη
στην αρχή, εαν την είχαμε με cut τότε δεν θα απλοποιούνταν τίποτα, ενώ ως έχει αν ήταν πάνω
από την επαναληπτική μορφή, τότε θα ήτανε πάλι αληθής και έτσι σε μια παράσταση θα παίρναμε
μια αληθή απλοποιημένη μορφή ταυτοτική και μετά θα έμπαινε στον δεύτερο κανόνα και θα 
προσπαθούσε να κάνει ταυτοποίηση με το simplify.

Η differentiate διαφορίζει μια παράσταση(χρησιμοποιόντας έναν από τους κανόνες) και μετά αν
επιτύχει, απλοποιεί το αποτέλεσμα, και ξαναδιαφορίζει μέχρι να αποτύχει ο κανόνας οπότε και 
θα βγει από το loop. 

Άσχετο:
Σήμερα ήρθα να τεστάρω μερικές περιπτώσεις ότι αυτά όντως συμβαίνουν, και είχα αποθηκεύσει την
άσκηση σαν 5Α-derivatives και 5B-Derivatives και ενώ έκανα αλλαγές στο 5Β πάντα φόρτωνα το 
5Α και ποτέ δεν έβλεπα αποτέλεσμα και έχασα 3 ώρες μην καταλαβαίνοντας γιατί οι αλλαγές που 
κάνω δεν οδηγούν σε αποτέλεσμα! 

*/









