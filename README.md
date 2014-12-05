ECS140-Prolog-Scheduling
Written by: Helen Chac
========================

Only wrote in Sched.pl
Contained 5 different parts.
Part1: Basic queries
-Given queries that are in the form course(name,title,insts), we want to list all the courses that are XX or list all the courses that have X instructors... etc.

Part2: Basic Lists
-wrote a sortappend predicate that does both sot and append

Part3: List Maniuplation
Wrote a function Distribute

Part4: CrossProduct
Given a myfor prediate, implement the cross of the two lists.

Part5: Meeting Scheduling
In this part, it consists of 4 different parts, each leading up to each other.
Given the list [[Name,[Meetings]]|Tail]
a- getallmeetings gets all the meetings from the list that we're given. 
b- participants makes a list of all the participants that are in certain meetings
c- osched creates a list of all the possible combinations of the meetings
d- xsched uses osched but picks out the ones that work (meaning no one person can be in 2 meeting at the same time)


Scheduling Meetingg Times written in Prolog
