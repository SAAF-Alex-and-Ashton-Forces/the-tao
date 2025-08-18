#lang pollen

◊; Annotated version here:
◊; https://users.cs.utah.edu/~elb/folklore/mel-annotated/node1.html#SECTION00010000000000000000
◊title{The Story of Mel, A Real Programmer}
◊author{Story by Ed Nather, Annotated by Erik Brunvand}

◊verse{
This was first posted to Usenet on May 21, 1983. ◊mel-ref{1}
}

◊verse{
A recent article devoted to the macho side of programming
made the bald and unvarnished statement:
}

◊verse{
Real Programmers write in FORTRAN. ◊mel-ref{2}
}

◊verse{
Maybe they do now,
in this decadent era of
Lite beer, hand calculators, and "user-friendly" software ◊mel-ref{3}
but back in the Good Old Days,
when the term "software" sounded funny
and Real Computers were made out of drums and vacuum tubes, ◊mel-ref{4}
Real Programmers wrote in machine code. ◊mel-ref{5}
Not FORTRAN. Not RATFOR. Not, even, assembly language ◊mel-ref{6}◊mel-ref{7}◊mel-ref{8}.
Machine Code.
Raw, unadorned, inscrutable hexadecimal numbers. ◊mel-ref{9}
Directly. ◊mel-ref{10}
}

◊verse{
Lest a whole new generation of programmers
grow up in ignorance of this glorious past,
I feel duty-bound to describe,
as best I can through the generation gap,
how a Real Programmer wrote code. ◊mel-ref{11}
I'll call him Mel,
because that was his name.
}

◊verse{
I first met Mel when I went to work for Royal McBee Computer Corp., ◊mel-ref{12}
a now-defunct subsidiary of the typewriter company.
The firm manufactured the LGP-30, ◊mel-ref{13}
a small, cheap (by the standards of the day) ◊mel-ref{14}
drum-memory computer, ◊mel-ref{15}
and had just started to manufacture
the RPC-4000, a much-improved, ◊mel-ref{16}
bigger, better, faster—drum-memory computer.
Cores cost too much, ◊mel-ref{17}
and weren't here to stay, anyway.
(That's why you haven't heard of the company,
or the computer.) ◊mel-ref{18}
}

◊verse{
I had been hired to write a FORTRAN compiler ◊mel-ref{19}
for this new marvel and Mel was my guide to its wonders.
Mel didn't approve of compilers.
}

◊verse{
"If a program can't rewrite its own code", ◊mel-ref{20}
he asked, "what good is it?"
}

◊verse{
Mel had written,
in hexadecimal,
the most popular computer program the company owned.
It ran on the LGP-30
and played blackjack with potential customers
at computer shows. ◊mel-ref{21}
Its effect was always dramatic.
The LGP-30 booth was packed at every show, ◊mel-ref{22}
and the IBM salesmen stood around
talking to each other.
Whether or not this actually sold computers
was a question we never discussed.
}

◊verse{
Mel's job was to re-write
the blackjack program for the RPC-4000.
(Port? What does that mean?) ◊mel-ref{23}
The new computer had a one-plus-one
addressing scheme, ◊mel-ref{24}
in which each machine instruction,
in addition to the operation code
and the address of the needed operand,
had a second address that indicated where, on the revolving drum,
the next instruction was located. ◊mel-ref{25}
}

◊verse{
In modern parlance,
every single instruction was followed by a GO TO! ◊mel-ref{26}
Put that in Pascal's pipe and smoke it. ◊mel-ref{27}
}

◊verse{
Mel loved the RPC-4000
because he could optimize his code: ◊mel-ref{28}
that is, locate instructions on the drum
so that just as one finished its job,
the next would be just arriving at the "read head" ◊mel-ref{29}
and available for immediate execution.
There was a program to do that job,
an "optimizing assembler", ◊mel-ref{30}
but Mel refused to use it.
}

◊verse{
"You never know where it's going to put things", ◊mel-ref{31}
he explained, "so you'd have to use separate constants." ◊mel-ref{32}
}

◊verse{
It was a long time before I understood that remark.
Since Mel knew the numerical value
of every operation code, ◊mel-ref{33}
and assigned his own drum addresses,
every instruction he wrote could also be considered
a numerical constant. ◊mel-ref{34}
He could pick up an earlier "add" instruction, say,
and multiply by it,
if it had the right numeric value. ◊mel-ref{35}
His code was not easy for someone else to modify. ◊mel-ref{36}
}

◊verse{
I compared Mel's hand-optimized programs ◊mel-ref{37}
with the same code massaged by the optimizing assembler program, ◊mel-ref{38}
and Mel's always ran faster.
That was because the "top-down" method of program design
hadn't been invented yet, ◊mel-ref{39}
and Mel wouldn't have used it anyway.
He wrote the innermost parts of his program loops first, ◊mel-ref{40}
so they would get first choice
of the optimum address locations on the drum. ◊mel-ref{41}
The optimizing assembler wasn't smart enough to do it that way. ◊mel-ref{42}
}

◊verse{
Mel never wrote time-delay loops, either, ◊mel-ref{43}
even when the balky Flexowriter ◊mel-ref{44}
required a delay between output characters to work right. ◊mel-ref{45}
He just located instructions on the drum
so each successive one was just past the read head
when it was needed; ◊mel-ref{46}
the drum had to execute another complete revolution
to find the next instruction.
He coined an unforgettable term for this procedure.
Although "optimum" is an absolute term,
like "unique", it became common verbal practice
to make it relative:
"not quite optimum" or "less optimum"
or "not very optimum".
Mel called the maximum time-delay locations
the "most pessimum".
}

◊verse{
After he finished the blackjack program
and got it to run
("Even the initializer is optimized", ◊mel-ref{47}
he said proudly),
he got a Change Request from the sales department. ◊mel-ref{48}
The program used an elegant (optimized) ◊mel-ref{49}
random number generator ◊mel-ref{50}
to shuffle the "cards" and deal from the "deck",
and some of the salesmen felt it was too fair,
since sometimes the customers lost.
They wanted Mel to modify the program
so, at the setting of a sense switch on the console, ◊mel-ref{51}
they could change the odds and let the customer win.
}

◊verse{
Mel balked.
He felt this was patently dishonest,
which it was,
and that it impinged on his personal integrity as a programmer,
which it did, ◊mel-ref{52}
so he refused to do it.
The Head Salesman talked to Mel,
as did the Big Boss and, at the boss's urging,
a few Fellow Programmers. ◊mel-ref{53}
Mel finally gave in and wrote the code,
but he got the test backwards, ◊mel-ref{54}
and, when the sense switch was turned on,
the program would cheat, winning every time.
Mel was delighted with this,
claiming his subconscious was uncontrollably ethical,
and adamantly refused to fix it.
}

◊verse{
After Mel had left the company for greener pa$ture$,
the Big Boss asked me to look at the code
and see if I could find the test and reverse it.
Somewhat reluctantly, I agreed to look.
Tracking Mel's code was a real adventure. ◊mel-ref{55}
}

◊verse{
I have often felt that programming is an art form,
whose real value can only be appreciated
by another versed in the same arcane art; ◊mel-ref{56}
there are lovely gems and brilliant coups
hidden from human view and admiration, sometimes forever,
by the very nature of the process.
You can learn a lot about an individual
just by reading through his code,
even in hexadecimal.
Mel was, I think, an unsung genius.
}

◊verse{
Perhaps my greatest shock came
when I found an innocent loop that had no test in it.
No test. None. ◊mel-ref{57}
Common sense said it had to be a closed loop,
where the program would circle, forever, endlessly. ◊mel-ref{58}
Program control passed right through it, however,
and safely out the other side. ◊mel-ref{59}
It took me two weeks to figure it out.
}

◊verse{
The RPC-4000 computer had a really modern facility
called an index register. ◊mel-ref{60}
It allowed the programmer to write a program loop
that used an indexed instruction inside;
each time through,
the number in the index register
was added to the address of that instruction,
so it would refer
to the next datum in a series. ◊mel-ref{61}◊mel-ref{62}
He had only to increment the index register
each time through.
Mel never used it.
}

◊verse{
Instead, he would pull the instruction into a machine register, ◊mel-ref{63}
add one to its address,
and store it back. ◊mel-ref{64}
He would then execute the modified instruction
right from the register. ◊mel-ref{65}
The loop was written so this additional execution time
was taken into account—
just as this instruction finished,
the next one was right under the drum's read head,
ready to go.
But the loop had no test in it. ◊mel-ref{66}
}

◊verse{
The vital clue came when I noticed
the index register bit, ◊mel-ref{67}
the bit that lay between the address
and the operation code in the instruction word, ◊mel-ref{68}
was turned on—◊mel-ref{69}
yet Mel never used the index register,
leaving it zero all the time. ◊mel-ref{70}
When the light went on it nearly blinded me.
}

◊verse{
He had located the data he was working on
near the top of memory—◊mel-ref{71}
the largest locations the instructions could address—
so, after the last datum was handled,
incrementing the instruction address
would make it overflow. ◊mel-ref{72}
The carry would add one to the
operation code, changing it to the next one in the instruction set:◊mel-ref{73}
a jump instruction. ◊mel-ref{74}
Sure enough, the next program instruction was
in address location zero, ◊mel-ref{75}
and the program went happily on its way.
}

◊verse{
I haven't kept in touch with Mel,
so I don't know if he ever gave in to the flood of
change that has washed over programming techniques
since those long-gone days.
I like to think he didn't.
In any event,
I was impressed enough that I quit looking for the
offending test,
telling the Big Boss I couldn't find it.
He didn't seem surprised.
}

◊verse{
When I left the company,
the blackjack program would still cheat
if you turned on the right sense switch,
and I think that's how it should be.
I didn't feel comfortable
hacking up the code of a Real Programmer. 
}
