%% Helen Chac


%PART 1 ONE ------------
c_numbers(N):-
  course(N, _, _).
/* Lists all the courses, "_" means that it's not necessary to have a
 *variable there since you're not going to be using it. */

c_pl(N):-
  course(N, programming_languages, _).
/* Lists all the programming languages courses, we want to get the N and match
 * it with "programming_languages". */

c_notpl(N):-
  course(N, X, _),
  X \= programming_languages.
/*NOT programming_languages*/

c_inst60(L):-
  course(60, _, L).
/*Print out only ecs60 instructors*/


c_inst60_sorted(L):-
  course(60, data_structures,L),
   sort(L).
  /* Take the list and you want to sort it */

c_inst20(L):-
  course(20, _, L).
  /*Print out only the 20 professors*/

c_inst20_sorted(L):-
  course(20, _, L), sort(L).
  /*Sort the professors */

c_inst_sorted(N,L):-
  course(N, _, L),
  sort(L).
  /*Sort all the professors */

c_single_inst(N):-
  course(N, _, X),
  X = [_].
  /*Make the list only one instructor. */

c_multi_inst(N):-
  course(N, _, X),
  X = [_,_|_].
  /* As long as there is more than one instructor */

c_exclusive(I,N):-
  course(N, _, L),
  member(I, L),
  L = [_].
  /*I is the professors name and we want to search for the courses
 * where he/she is the only profesor */

c_12_inst_1or(N):-
  (course(N, _, [_])); (course(N, _, [_,_])).
  /*Either two professors or one.*/

c_12_inst_2wo(N):-
  course(N, _, [_]).
c_12_inst_2wo(N):-
  course(N, _, [_,_]).
/* 2 rules for c_12_inst_2wo*/

%PART2

%delete_question(delete(X,X,Answer)).
delete_question("gprolog's delete behavior is from page 157, 5th edition.").

%You want to append the list together beofre you sort it
sortappend(L1, L2, Z):-
  append(L1, L2, Z),
  sort(Z).

%PART3
%i.e. if W is a, X is [1 ,2, 3], then Z = [[a,1], [a,2], [a,3]].
distribute(_,[],[]).
distribute(W,[H|T],Y):-
  distribute(W, T, Y1),
  Y = [[W,H]| Y1].

%PART4
/* Olsson gave us myfor on the handout, we were to use that to make a crossmyfor */
/* Crossmyfor is supposed to use myfor and also use distribute to do the cross.
 * We also used sortappend because we are not doing it in order.
 * Rather, we are doing it in reverse order,
 * since we already made a function that appends two lists togehter, and sort it
 * we use the function that we made that just sortappends ( ).
 * */

myfor(L,U,Result):-
  L=<U,
  L1 is L+1,
  myfor(L1,U,Res1),
  Result = [L|Res1].
myfor(L,U,[]):-
  L>U.

crossmyfor(0,_,[]).
crossmyfor(X, Y, Z):-
  X > 0,
  myfor(1, Y, L2),
  distribute(X, L2, Res),
  X1 is X - 1 ,
  crossmyfor(X1, Y, List),
  sortappend(List,Res,Z).

%Part5a.
/*Write the predicate getallmeetings(C,Z) */
% We know that a Head is a [name,meeting]
% and a meeting is a list of a list, we need to extract
% that out of a list, thus, we perform another [H|T].
getallmeetings([],[]).
getallmeetings([H|T], Z):-
  H = [_|T1],		%We dont need the first item in the head
  T1 = [Head|_],	%Extract out of the list :)
  getallmeetings(T, Z2),%Recurse
  sortappend(Head, Z2, Z).

%Part5b.
/*
participants([],[]).
participants([[H,[]]|_T],[]).
participants([H|T],Z):-
  H=[Name|Mtngs],
  Mtngs = [Head|_Tail],
  participants(T, Z2),
  sortappend(Head,Z2,Z).
participants([], []).
participants(List, Z):-
  List = [Head |Tail],
  Head = [Name, Meetings],
  Meetings = [Mtng|Othermeetings],
  check(Mtng, Tail, Result),
  participants([Head|Othermeetings], Z1),
  sortappend(Z1, Result, Z).

check(_, [], []).
check (Checker, List, Z):-
  List = [H|T],



check(Meeting, [[Name, Meets]|Tail],Result):-
  Names = [Name],
  check(Meeting, Tail, Res),
  (member(Meeting, Meets)->
    %want to check if result is empty
      ((var(Res)-> Result = Names);
      (sortappend(Names,Res,Result)))).
%  (sortappend(Res, [], Result)).
%  ((var(Res)-> Result = []);(Result = Res)).

check(Meeting, [[Name, Meets]|Tail],Result):-
  Name = [Name],
  check(Meeting, Tail, Res),
  (\+member(Meeting,Meets)->
    ((var(Res)->Result = []);(sortappend(Res, [], Result)))).
check(_,[],[]).

meet(_, [], []).
meet(List, [First|Next], Z):-
  check(First, List, Res1),
  meet(List, Next, Z2),
  Z = [[First,Res1]| Z2].

participants([],[]).
participants(List,Z):-
  getallmeetings(List,AllMeetings),
  meet(List, AllMeetings, Z).



%check([[Name, Meetings]], SingleMeeting, Names):-
%  (member(SingleMeeting, Meetings)-> Names=[Name]);
%  (Names = []).
% We are setting the condition of the check statements
%  (\+ member(SingleMeeting, Meetings) -> Names = NameFunctionResult).
%  ((var(NameFunctionResult)-> Names = []);
%    (Names = NameFunctionResult)).
%    (var(NameFunctionResult)-> Names = [Name]);(sortappend(NameFunctionResult,[Name], Names)));
%  sortappend(NameFunctionResult, [], Names).


check(_, [], []).
check(Meeting, [[Name,Meets]|Tail], Result):-
%  List = [Head|Tail],
%  Head = [_Name|Meets],
  Names = [Name],
  check(Meeting, Tail, Res),
  (member(Meeting, Meets)->sortappend(Names, Res, Result));
  (Result = []).
participants([],[]).
participants([[_,[]]],[]).
participants([[Name,Meetings]|Tail],Z):-
%  C = [Head|Tail],
%  Head = [Name,Meetings],
%  member(X, Meetings),
  Meetings = [H|T],
  participants([[Name,T]],Next),

  check(H, Tail, NewList),
%  NameList = [NewList, Name],
  SingleName = [Name],
  sortappend(NewList, SingleName, NameList),
  FinalList = [[H | [NameList]]],
  participants(Tail, Z1),
  sortappend(FinalList, Z1, Z2),
  sortappend(Z2,Next,Z).
*/

/*THIS PART OF THE CODE WORKS*/
check([], _, []). /* BASE CASE */
check([[_Name,Meetings]|Tail],SingleMeeting,Names):-
  \+member(SingleMeeting,Meetings),
    check(Tail,SingleMeeting,NameFunctionResult),
    Names = NameFunctionResult.
    /*This is for when there does not contain a member (our ) */
check([[Name,Meetings]|Tail], SingleMeeting, Names):-
  %check(Tail, SingleMeeting, NameFunctionResult),
  member(SingleMeeting, Meetings),
  check(Tail, SingleMeeting, NameFunctionResult),
     sortappend([Name], NameFunctionResult, Names).
     %Names = [Name|NameFunctionResult]).
     /* Only add the name when there is a match */
checkmeetings(_, [], []). %Result
checkmeetings(List, [Mtng1|MtngTail], Result):-
  check(List, Mtng1, Res1),
  checkmeetings(List, MtngTail, Res2),
  Result = [[Mtng1,Res1]|Res2].
  /*We want to do this for every meeting*/
participants([],[]).
participants(List, Participants):-
  List = [_|_],
  %sort(List), /*Since we don't sort append in the list, we want to sort it*/
  getallmeetings(List, Getallmeetings),
  checkmeetings(List, Getallmeetings, Participants).


%Part5C
/*We want to start scheduling the meetings*/
/* MR is the room number, MH is the number of hours that meeting can be held */
/* Meeting room, meeting hour*/
/* Z is in the form of [[R,H],M]*/
/*
allmeetings(_, [], _, []).
allmeetings(List, Meetings, _Participants, Combinations):-
  select(X, Meetings, LessMeetings),
  allmeetings(List, LessMeetings, _Participants, Answer),
  check(List, X, Names),
  Combinations = [ [X, [Names]]| Answer].
*/


/*
allmeetings([],[]).
allmeetings(Participants, Combinations):-
  select(X, Participants, OtherParticipants),
  allmeetings(OtherParticipants, Answer),
  sortappend([X], Answer, Combinations),!.
*/
%  Combinations = [X | Answer],!.

merge(_,[],[]).
merge(Times, Combs, Z):-
  select(H1, Times, T1),
%  Times = [H1|T1],
  Combs = [H2|T2],
%  select(H2, Combs, T2),
  merge(T1,T2,Z2),
  append([[H1,H2]],Z2,Z).
%  Z = [[H1,H2]|Z2].

/*
osched(MR,MH,C,[]):-
  getallmeetings(C, Meetings),
  TimeRoom is MH * MR,
  length(Meetings, Len),
  Len > TimeRoom.
*/ /* This is not necessary if we add the condition in the main osched*/
osched(_,_,[],[]).
osched(MR,MH,C,Z):-
  C = [_|_],
  getallmeetings(C, Meetings),
  TimeRoom is MH * MR,
  length(Meetings, Len),
  Len =< TimeRoom,
  crossmyfor(MR,MH,Cross1),
  participants(C, Participants),
  merge(Cross1, Participants, Z),
  sort(Z).

%  allmeetings(Participants, Cross2),
%osched(MR,MH,C,Z).



%PART5D.
/*From the list of schedules we got earlier we want to remove ones that have ther person in */
/* 2 meetings */

chkdup([],_,_).
chkdup(List, Person, Hr):-
  List = [[[_,Hour], _]|Tail],
  Hr \= Hour,
  chkdup(Tail, Person, Hr).
/*
chkdup(List, Person, Hr):-
  List = [[[_,Hr],[_Meeting, Participants]]|Tail],
  chkdup(Tail, Person, Hr),
  (member(Person,Participants)->!, fail). %Just want to return true or false
*/
chkdup(List, Person, Hr):-
  List = [[[_,Hr],[_Meeting, Participants]]|Tail],
  chkdup(Tail, Person, Hr),
  \+member(Person, Participants).


removing([]).
removing([Head|Tail]):-
  Head = [[Mr,Mh],[Meeting,[First|Next]]],
  chkdup(Tail, First, Mh),
  removing([[[Mr,Mh],[Meeting,Next]]|Tail]).
removing([[_,[_Meeting, []]]|T]):-
  removing(T).
/*This predicate takes the first name in the head and passes it to  chkdup */
/*To determine whether or not we want to accept or reject this */
/*Ultimately, it will return either Yes or no, which will determine whether or not we keep the Z.*/

xsched(_,_,[],[]).
xsched(MR,MH,C,Z):-
  C = [_|_],
  getallmeetings(C, Meetings),
  TimeRoom is MH * MR,
  length(Meetings, Len),
  Len =< TimeRoom,
  osched(MR,MH,C,Z),
  removing(Z).
