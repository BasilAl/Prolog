%712 
nomismata1(Poso,[A100,A50,A20,A10,A5,A2,A1]) :-
	member(A100,[0,1,2,3]),
	member(A50,[0,1,2]),
	member(A20,[0,1,2,3,4,5,6,7,8]),
	member(A10,[0,1,2,3,4,5,6,7,8,9,10,11,12]),
	member(A5, [0,1,2,3]),
	member(A2, [0,1,2,3,4,5,6]),
	member(A1, [0,1,2,3,4,5]),
Poso is A100*100+A50*50+A20*20+A10*10+A5*5+A2*2+A1*1.


nomismata2(Poso,[A100,A50,A20,A10,A5,A2,A1]) :-
	member(A1, [0,1,2,3,4,5]),
	member(A2, [0,1,2,3,4,5,6]),
	member(A5, [0,1,2,3]),
	member(A10,[0,1,2,3,4,5,6,7,8,9,10,11,12]),
	member(A20,[0,1,2,3,4,5,6,7,8]),
	member(A50,[0,1,2]),
	member(A100,[0,1,2,3]),
Poso is A100*100+A50*50+A20*20+A10*10+A5*5+A2*2+A1*1.


nomismata3(Poso,[A100,A50,A20,A10,A5,A2,A1]) :-
	member(A1, [0,1,2,3,4,5]),
	member(A5, [0,1,2,3]),
	member(A20,[0,1,2,3,4,5,6,7,8]),
	member(A100,[0,1,2,3]),
	member(A10,[0,1,2,3,4,5,6,7,8,9,10,11,12]),
	member(A2, [0,1,2,3,4,5,6]),
	member(A50,[0,1,2]),
Poso is A100*100+A50*50+A20*20+A10*10+A5*5+A2*2+A1*1.

/*

Στο πρόγραμμα διαθέτουμε νομίσματα κάποιου νομίσματος, έστω c.
Διαθέτουμε 3 νομίσματα των 100c,
		   2 νομίσματα των 50c,
		   8 νομίσματα των 20c,
		  12 νομίσματα των 10c,
		   3 νομίσματα των 5c,
		   6 νομίσματα των 2c και
		   5 νομίσματα του 1c
τα οποία μπορούν να μας δώσουν μέχρι 712c σύνολο.

Οι κανόνες μας δίνουν τους τρόπους που μπορεί να εκφραστεί ένα ποσό μέχρι
712c με τα διαθέσιμα νομίσματα, ή τα πιθανά ποσά που μπορούν να μας δώσουν τα 
διαθέσιμα νομίσματα με επαναλήψεις ή τι ποσό μας δίνει ένας συνδυασμός νομισμάτων.

Η διαφορά ανάμεσα στους 2 κανόνες είναι ότι στον πρώτο το backtracking θα 
ξεκινήσει από μικρά ποσά και θα βρει πιο γρήγορα απαντήσεις σε μικρά 
ζητούμενα ποσά, ενώ ο δεύτερος θα ξεκινήσει το backtracking από μεγαλύτερα
νομίσματα και πχ θα βρει μεγαλύτερα ποσά πιο γρήγορα.

Πχ: Για την πρώτη απάντηση για το τι συνδυασμό νομισμάτων χρειαζόμαστε για να
συνθέσουμε ένα ποσό των 5c το πρώτο κατηγόρημα θα ταιριάξει όλες τις τιμές των
Αι με το πρώτο στοιχείο των λιστών(0) και μετά θα ξεκινήσει αναζήτηση με backtracking στο
Α1 οπότε με 5 δοκιμές θα βρει την πρώτη απάντηση([0,0,0,0,0,0,5]).
Ο δεύτερος κανόνας θα ξεκινήσει το backtracking από το Α100, θα δοκιμάσει
τις τιμές για 0,100,200,300c, θα συνεχίσει ένα επίπεδο πάνω στο Α50 και θα ξανα-
πέσει κάτω στο Α100 και πάει λέγοντας(ή, στην προκειμένη, συγκρίνοντας) μέχρι να 
κάνει όλες τις δοκιμές  για Α5=0 όπου και θα δοκιμάσει το Α5=1 για να 
δώσει [0,0,0,0,1,0,0]. 

*/