:- use_module(library(pairs)).
probelm(N,X):- number_chars(X,Y), print(Y), number_chars(801234567,Z), print(Z),print(N).

manhattan_distances([],_, Size,Num,Results):- Results is Num.
manhattan_distances([N|NT],[X|XT],Size,Num,Results):-manhattan(N,X,Size,Ham),Over is Ham+Num ,manhattan_distances(NT,XT,Size,Over,Results).
manhattan(S,G,Size,Ham):- x_axis(S,Size,SumX1), x_axis(G,Size,SumX2), yx(S,Size,SumY1), yx(G,Size,SumY2), Ham is (abs(SumX1 - SumX2)+abs(SumY1-SumY2)).

sum([],Sum):-print( Sum).
sum([X|Xs],Sum):-Over is X+Sum, sum(Xs,Over).

manhattan_one_distances([],[], Size,Num):-print(Num).
manhattan_one_distances([N|NT],[X|XT],Size,Num):-manhattan_one(N,X,Size,Ham),manhattan_one_distances(NT,XT,Size,(Num+Ham)).
manhattan_one(S,G,Size,Ham):- x_axis(S,Size,SumX1), x_axis(G,Size,SumX2), yx(S,Size,SumY1), yx(G,Size,SumY2), Ham is (abs(SumX1 - SumX2)+abs(SumY1-SumY2)-1).


miss_place_distances([],[], Size,Num):-print(Num).
miss_place_distances([N|NT],[X|XT],Size,Num):-miss_place(N,X,Ham),miss_place_distances(NT,XT,Size,(Num+Ham)).
miss_place(S,G,Num):- S=:=G -> Num is 0; Num is 1.

x_axis(X,Size,Sum):- ((mod(X+1,Size) =:=0) -> Sum is (Size) ; Sum is ((X+1) mod Size)).
yx(Y,Size,Sum):- ((mod(Y+1,Size) =:= 0)) -> yxx(Y,Size,Sum); Sum is ((div(Y+1,Size)+1)).
yxx(Y,Size,Sum) :- (div(Y+1,Size) =:= Size) -> Sum is (Size);  Sum is (div(Y+1,Size)).

feeder(X,Goal,Size,Results):-collection(X,Size,Product),looping(Product,Goal,Size,[],Results).
looping([],Goal,Size,ResultsAcc,Results):-print(ResultsAcc), append([],ResultsAcc,Results).
looping([X|Xs],Goal,Size,ResultsAcc,Results):-print(X),manhattan_distances(X,Goal,Size,0,R),
                                              print("Then"),
                                              key_parse(R,X,Product),
                                              append(Product,ResultsAcc,ResultList),
                                              looping(Xs,Goal,Size,ResultList,Results).
key_parse(Key,Value,Product):-append([],[Key-Value],Product).


collection(X,Size,List):- findall(Product, move(X,Size,Product), List).
move(X,Size,Product):- moveLeft(X,Size,Product);moveRight(X,Size,Product);moveUp(X,Size,Product);moveDown(X,Size,Product).

moveLeft(X,Size,Product):- nth0(0,X,IndeXx),x_axis(IndeXx, Size, XPosition),XPosition > 1, Switch is (IndeXx)-1, nth0(IndeXy,X,Switch), swapped(X,IndeXy,0,Product).
moveRight(X,Size,Product):- nth0(0,X,IndeXx),x_axis(IndeXx, Size, XPosition),XPosition < Size, Switch is (IndeXx)+1, nth0(IndeXy,X,Switch), swapped(X,IndeXy,0,Product).
moveUp(X,Size,Product):- nth0(0,X,IndeXx),x_axis(IndeXx, Size, XPosition), XPosition > 1, Switch is (IndeXx)-Size, nth0(IndeXy,X,Switch), swapped(X,IndeXy,0,Product).
moveDown(X,Size,Product):- nth0(0,X,IndeXx),x_axis(IndeXx, Size, XPosition), XPosition < Size, Switch is (IndeXx)+Size, nth0(IndeXy,X,Switch) , swapped(X,IndeXy,0,Product).

swapped(As,I,J,Cs) :-
   same_length(As,Cs),
   append(BeforeI,[AtI|PastI],As),
   append(BeforeI,[AtJ|PastI],Bs),
   append(BeforeJ,[AtJ|PastJ],Bs),
   append(BeforeJ,[AtI|PastJ],Cs),
   length(BeforeI,I),
   length(BeforeJ,J).

a_
