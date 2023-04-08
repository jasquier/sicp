# 1. Building Abstractions with Procedures

## Table of Contents

## Introduction

> The acts of the mind, wherein it exerts its power over simple ideas are
> chiefly these three: 1. Combining several simple ideas into one compound one,
> and thus all complex ideas are made. 2. The second is bringing two ideas,
> whether simple or complex, together, and setting them by one another, so as to
> take a view of them at once, without uniting them into one, by which it gets
> all its ideas of relations. 3. The third is separating them from all other
> ideas that accompany them in their real existence: this is called abstraction
> and thus all its general ideas are made. -- John Locke, _An Essay Concerning
> Human Understanding_ (1690)

A **_computational process_** is an abstract being that inhabits a computer. It
manipulates other abstract things called **_data_**.

A process is directed by a set of rules called a **_program_**. We will create
programs! We use **_programming languages_** composed of symbolic expressions to
describe the task our processes will perform.

We must learn to anticipate the effects of our programs in order to avoid
**_bugs_**. Bugs can sometimes have complex and unintended consequences.

We will learn to develop our programs in a modular manner. This allows us to
construct, debug, and perhaps replace the pieces separately.

## Programming in Lisp

We use a programming language called Lisp. Just as we use English to express our
everyday thoughts and mathematical notations to describe quantitative
phenomenon, we use Lisp to express our procedural thoughts.

Lisp was created in the 1950s as a formalism for reasoning about certain logical
expressions called **_recursion equations_** as a model for computing. It was
invented by John McCarthy and is based on his paper “Recursive Functions of
Symbolic Expressions and Their Computation by Machine”.

A Lisp **_interpreter_** is a machine that carries out processes described in
Lisp. The first Lisp interpreter was implemented by McCarthy and others at MIT.

Lisp stands for List Processing and was originally designed to provide symbol
manipulating capabilities for attacking programming problems such as the
symbolic differentiation and integration of algebraic expressions.

It included new data objects called atoms and lists which strikingly set it
apart from all other languages of the period.

Lisp evolved informally and has resisted rigid standards. This has allowed it to
continually adapt. We use a dialect of Lisp called Scheme.

Lisp was at first very inefficient for numerical computations, at least in
comparison with FORTRAN. Over the years Lisp interpreters have gotten faster and
can create more efficient machine code. This along with its use in applications
where speed is not a priority have allowed Lisp to remain a niche but thriving
language.

Wait, if Lisp isn't mainstream why are we learning and using it!? We use Lisp
because the language possesses some unique features that make it an excellent
teaching medium. These features allow us to study important programming
constructs and data structures, and to relate them (the constructs and
structures) to the linguistic features that support them.

The most significant of these features is the ability to represent and
manipulate procedures as data. Keep in mind that a **_procedure_** is a
description of a process. This 'procedures are data' functionality is important
because there are powerful program design techniques that rely on this blurring
between **_passive_** data and **_active_** processes. Lisp's ability to treat
procedures as data also makes writing programs that manipulate other programs
easier. Lastly Lisp is fun.

## 1.1 The Elements of Programming

A programming language is more than a set of instructions that we use to direct
a computer. A programming language is a framework within which we organize our
ideas about processes. When learning a language pay special attention to three
things:

- The **primitive expressions**.
- The **means of combination** or the way you combine simple ideas into complex
  ones.
- The **means of abstraction** or the way compound elements can be named and
  manipulated as units.

We'll deal with two kinds of elements: procedures and data. Later on we shall
see that the two are not as distinct as they may first appear. Data is "stuff"
and procedures are the rules we for manipulating the "stuff."

We being by using only numerical data in the rest of chapter one so that we can
focus on building procedures.

### 1.1.1 Expressions

When interacting with a LISP interpreter you will type _expressions_ and the
interpreter will respond by displaying the result of _evaluating_ that
expression. Simple right? One basic expression is a number. Enter a number

```lisp
486
```

The interpreter will respond by printing the number.

```lisp
486
```

Numbers can also be combined using primitive procedures to form compound
expressions. For example

```lisp
(+ 137 349)
```

Results in

```lisp
486
```

And

```lisp
(+ 2.7 10)
```

Results in the floating point value

```lisp
12.7
```

This notation of a list of expressions delimited within parentheses are called
**_combinations_**. The leftmost element in the list is called the
**_operator_** and the other elements are called the **_operands_**.

The **_value of a combination_** is obtained by applying the **_procedure_**
specified by the operator to the **_arguments_** that are the values of the
operands.

The placing of the operator to the left of the operands is known as **_prefix
notation_** and may seem unusual at first as it departs significantly from
customary mathematical convention. It does, however, allow us to accommodate
procedures with an arbitrary number of arguments, for one.

```lisp
(+ 21 35 12 7)
```

Results in

```lisp
75
```

We can also use prefix notation to cleanly nest combinations

```lisp
(+ (* 3 5) (- 10 6))
```

And the resulting value

```lisp
19
```

You'll often see expressions displayed in a convention known as
**_pretty-printing_** where each operator has its operands vertically aligned.
Regardless of the means of displaying the value of the input expression note
that the value is always displayed. This is commonly known as a
**_read-eval-print loop_** where the input you enter is read, evaluated, and the
result printed until you exit the LISP interpreter.

### 1.1.2 Naming and the Environment

In any programming language it is important to be able to name and later refer
to computational stuff. We say that the name identifies a **_variable_** whose
**_value_** is the object (or stuff). In Scheme we name things using `define`.

Entering

```lisp
(define size 2)
```

Results in the interpreter associating the value 2 with the name size. We can
then refer to the value by name:

```lisp
size
```

Prints

```lisp
2
```

And

```lisp
(* 5 size)
```

Displays

```lisp
10
```

Demonstrating a few simple ways that variables can be used in expressions.

**define** is Lisp's simplest means of abstraction, allowing us to use names to
refer to the results of compound operations. By building computational objects
of increasing complexity we can eventually make useful programs.

The "saving" of information using **define** should make clear that the
interpreter maintains a kind of memory in order to track our variable name-value
pairs. This memory is called the **_environment_**, in this case the **_global
environment_** since we will see later that a computation may involve a number
of different environments.

### 1.1.3 Evaluating Combinations

To begin thinking about issues procedurally let us consider that **_to evaluate
a combination_** the interpreter is itself following a procedure.

1. Evaluate the sub-expressions of of the combination
2. Apply the procedure that is the value of the operator to the arguments that
   are the values of the operands.

These simple steps are deceptively easy. Note that the first step in evaluating
a combination requires us to evaluate every element some of which themselves
might be combinations. Thus the evaluation rule for combinations is
**_recursive_** in nature, that is, it includes as one of its steps the need to
invoke itself. Note that right now we are only familiar with the operators
representing primitive procedures and thus it doesn't really make sense to
evaluate those operators. Later we'll work with combinations whose operators are
themselves compound expressions.

We can think of combinations as nodes in a tree in order to better examine the
recursive nature of combination evaluation. Each combination has branches
corresponding to the operators and the operands stemming from a node. The
terminal nodes are either operators or numbers and values "percolate upwards" as
we combine numbers using operators. This concept of values percolating upwards
is known as **_tree accumulation_**. If you notice during this tree accumulation
we eventually end up at a point we no longer need to evaluate combinations but
are dealing with only primitive operators and numbers or other names. We take
care of primitive cases with the following rules:

- the values of numerals are the numbers that they represent.
- the values of built in operators are the machine instruction sequences that
  carry out those operations.
- the values of other names are the objects associated with those names in the
  environment.

The second rule can be regarded as a special case of the third if we stipulate
that the operators \*, +, etc are included in the global environment and whose
values are the aforementioned machine instructions. The key point is to notice
the role of the environment in determining the meaning of symbols in
expressions. In a language such as LISP it means nothing to speak of the value
of the expression

```lisp
(+ x 1)
```

Without specifying any information about the environment that would provide a
meaning for the symbol

```lisp
x
```

Or even

```lisp
+
```

But wait! Our evaluation rule doesn't handle definitions using **define**. For
example, evaluating

```lisp
(define x 3)
```

Does **not** apply the **define** procedure to the two arguments. In other
words, the above expression is not a combination. Such exceptions to the general
evaluation rule are called **_special forms_**. **define** is the first special
form we've seen so far. Each special form has its own evaluation rule.

### 1.1.4 Compound Procedures

We have already seen one means of abstraction, that is, that use of **define**
to name computational objects. The next and far more powerful technique is
called **_procedure definitions_**. This is the way a compound operation can be
given a name and then referred to as a unit.

To start, let's look at the mathematical concept of squaring. That is, to square
something, multiply it by itself. Or in LISP

```lisp
(define (square x) (* x x))
```

Evaluating that line of LISP creates a **_compound procedure_** named square.
The general form of a procedure definition is

```lisp
(define (name formal parameters) (body))
```

The name we use becomes associated with the procedure definition in the
environment. The formal parameters are the names used within the body of the
procedure to refer to the corresponding arguments of the procedure. The body is
an expression that will yield the value of the procedure application when the
formal parameters are replaced by the arguments when the procedure is applied.

Now we can use `square` by itself or combine it to make more complex procedures.

```lisp
(square 21)
441
```

```lisp
(square (square 3))
81
```

```lisp
(define (sum-of-squares x y)
  (+ (square x) (sqaure y)))

(sum-of-squares 3 4)
25
```

```lisp
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)
136
```

Compound procedures are used the same way as primitive procedures like `+` or
`*`.

### 1.1.5 The Substitution Model for Procedure Application

How does the interpreter evaluate a combination whose operator is a compound
procedure?

The method the interpreter uses is similar to how it evaluates primitive
procedures. First, evaluate the elements of the combination and then apply the
procedure to the arguments.

How does the interpreter apply a procedure to arguments?

- To apply a compound procedure to arguments, evaluate the body of the procedure
  with each formal parameter replaced by the corresponding argument.

To illustrate let's evaluate the combination `(f 5)`. We begin by retrieving the
body of `f`:

```lisp
(sum-of-squares (+ a 1) (* a 2))
```

The we replace the formal parameter `a` with the argument 5.

```lisp
(sum-of-squares (+ 5 1) (* 5 2))
```

After further evaluating the arguments we can reduce `(+ 5 1)` to 6 and
`(* 5 2)` to 10. If we then replace the formal parameters of `sum-of-squares` we
end up with:

```lisp
(+ (square 6) (square 10))
```

Using the definition of `square` we can continue to reduce:

```lisp
(+ (* 6 6) (* 10 10))
```

Reducing the multiplication:

```lisp
(+ 36 100)
```

And finally:

```lisp
136
```

The process we just outlined is called the _substitution model_ of procedure
application. There are two caveats that should be stressed:

- The purpose of the substitution model is to help us think about procedure
  application, not to describe how the interpreter actually works.
- We will continue to refine our mental model of procedure application until we
  build a working interpreter in chapter 5. Like most learning, as our knowledge
  deepens our initial models fail to capture the true complexity of the system
  and better model must be created.

According to the description of evaluation given above, the interpreter first
evaluates the operator and operands and then applies the resulting procedure to
the resulting arguments. However, there is another way to perform evaluation.
One could instead not evaluate the operands until their values are needed. This
model would substitute operands for parameters until it obtained a combination
involving only primitive expressions.

Using this method an evaluation would proceed:

```lisp
(f 5)

(sum-of-squares (+ 5 1) (* 5 2))

(+ (sqaure (+ 5 1)) (sqaure (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

(+ (* 6 6) (* 10 10))

(+ 36 100)

136
```

Notice how the answer is the same but the process is different. In particular,
the evaluations of `(+ 5 1)` and `(* 5 2)` are both performed twice.

This alternative 'fully expand and then reduce' model is known as
**_normal-order evaluation_** in contrast to the 'evaluate the arguments and
then apply' model which is called **_applicative-order evaluation_**. For the
procedure applications we will see in the first two chapters of this book, the
two models will yield the same values.

LISP uses applicative-order evaluation partly for efficiency reasons.
Additionally, normal-order evaluation becomes much more complicated when we
leave the realm of procedures that can modeled using substitution.

### 1.1.6 Conditional Expressions and Predicates

At this point our expressive power is very limited. We have no way of making
tests and then performing different actions as a result. For example, we can not
define a procedure that computes a number's absolute value.

We introduce a new special form called `cond` that is used as follows:

```lisp
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
```

With the general form of `cond` being:

```lisp
(cond (<p1> <e1>)
      (<p2> <e2>)
      ...
      (<pn> <en>))
```

The expression consists of the symbol `cond` followed by parenthesized pairs of
expressions `(<p> <e>)` called **_clauses_**. The first expression in each
clause is a **_predicate_** or an expression whose value is interpreted as
either true or false.

Evaluating a conditional expression is quite simple. First, evaluate the
predicate p1. If its value is false then p2 is evaluated. This process continues
until a predicate is found whose value is true. At that point the interpreter
returns the value of the corresponding **_consequent expression_** e. If none of
the predicates a true the value of the conditional is undefined.

The word **_predicate_** simply means a combination that evaluates to true or
false. That could be a procedure that returns those values or an expression that
evaluates to true or false.

Another way of writing our `abs` procedure is:

```lisp
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))
```

Notice the use of the special `else` symbol that can be used in place of the
final predicate in a `cond`. This causes the `cond` to return the value
specified by the `else` only if no other predicates return true.

Here is yet another way of writing `abs`:

```lisp
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

That version of `abs` uses a new special form `if`, a restricted typed of
conditional that can be used where there are only two branches. The general form
of `if` expressions is:

```lisp
(if <predicate> <consequent> <alternative>)
```

To evaluate an `if` expression the interpreter begins by evaluating the
predicate. If the predicate evaluates to true then the interpreter evaluates the
consequent and returns its value. Otherwise, it evaluates the alternative and
returns its value.

In addition to the already seen `<` `=` `>` operators, there are also logical
the following logical composition operators:

- `(and <e1> ... <en>)` The interpreter evaluates the expressions one at a time,
  left to right. If any expression evaluates to false then the value of the
  `and` is false and the rest of the expressions are not evaluated. If all
  expressions evaluate to true then the value of the `and` is the value of the
  last expression.
- `(or <e1> ... <en>)` The interpreter evaluates the expressions one at a time,
  left to right. If any expression evaluates to true then that value is returned
  as the value of the `or` expression and the rest of the expressions are not
  evaluate and the rest of the expressions are not evaluated. If all the
  expressions evaluate to false then the value of the `or` is false.
- `(not <e>)` The value of the `not` expression is true when the expression e
  evaluates to false, otherwise the `not` is false.

Notice that `and` and `or` are special forms, not procedures, because the
sub-expressions are not necessarily all evaluated. `not` is an ordinary
procedure.

Here is an example use of the above procedures:

```lisp
(define (>=1 x y)
  (or (> x y) (= x y)))

(define (>=2 x y)
  (not (< x y)))
```

#### Exercise 1.1

Below is a sequence of expressions. What is the result printed by the
interpreter in response to each expression. Assume that the sequence is to be
evaluated in the order in which it is presented.

```lisp
10
```

Results in:

```lisp
10
```

```lisp
(+ 5 3 4)
```

Results in:

```lisp
12
```

```lisp
(- 9 1)
```

Results in:

```lisp
8
```

```lisp
(/ 6 2)
```

Results in:

```lisp
3
```

```lisp
(+ (* 2 4) (- 4 6))
```

Results in:

```lisp
6
```

```lisp
(define a 3)
```

Results in:

```lisp
a
```

```lisp
(define b (+ a 1))
```

Results in:

```lisp
b
```

```lisp
(+ a b (* a b))
```

Results in:

```lisp
19
```

```lisp
(- a b)
```

Results in:

```lisp
-1
```

```lisp
(if (and (> b a) (< b (* a b)))
    b
    a)
```

Results in:

```lisp
4
```

```lisp
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
```

Results in:

```lisp
16
```

```lisp
(+ 2 (if (> b a) b a))
```

Results in:

```lisp
6
```

```lisp
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
```

Results in:

```lisp
16
```

#### Exercise 1.2

Translate the following expression into prefix form. NB: I didn't include the
image.

Answer:

```lisp
(/ (+ 5
      (/ 1 5)
      (- 2 (- 3 (+ (/ 4 5) 6))))
   (* 3
      (- 6 2)
      (- 2 7)))
```

#### Exercise 1.3

Define a procedure that takes three numbers as arguments and returns the sum of
the squares of the two larger numbers.

Answer:

```lisp
(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-squares-of-larger-2 a b c)
  (if (> a b)
      (if (> b c)
          (sum-of-squares a b)
          (sum-of-squares a c))
      (if (> a c)
          (sum-of-squares b a)
          (sum-of-squares b c))))
```

#### Exercise 1.4

Observe that our model of evaluation allows for combinations whose operators are
compound expressions. Use this observation to describe the behavior of the
following procedure:

```lisp
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

Description:

The procedure examines if b is greater than zero if so then the value of the
`if` expression is the `+` operator, otherwise the value is the `-` operator. In
the case where the `if` expression evaluates to `-` we know that b is negative
so subtracting the value from a would be the same as adding the absolute value
of b.

#### Exercise 1.5

Ben Bitdiddle has invented a test to determine whether the interpreter he is
faced with is using applicative-order evaluation or normal-order evaluation. He
defines the following two procedures:

```lisp
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
```

The he evaluates the expression:

```lisp
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order
evaluation? What behavior will he observe with an interpreter that uses
normal-order evaluation? Explain your answer. (Assume that the evaluation rule
for the special form `if` is the same whether the interpreter is using normal or
applicative order: The predicate expression is evaluated first, and the result
determines whether to evaluate the consequent or the alternative expression.)

Answer:

Recall that in applicative-order evaluation the operator as well as all the
arguments are evaluated before the procedure is applied. If the interpreter used
this form of evaluation then you would be stuck in an infinite loop as soon as
p's evaluation is attempted. This would occur before test is applied. If
normal-order evaluation were used then x would be equal to 0 in the body of test
and so the alternative expression would never be evaluated, meaning we never
enter the infinite loop caused by evaluating p. The interpreter will return 0.

### 1.1.7 Example: Square Roots by Newton's Method

Procedures are a lot like mathematical functions, but there is at least one key
difference. A function can be declarative but a procedure must be imperative.
For example, in mathematics, the square root of a number is x is the number y
such that y \* y = x and y is greater than or equal to 0.

That mathematical function does not tell us how to compute the square root of
pi. We need an imperative, or "how to" procedure rather than a declarative
mathematical description. OK, so how does one compute the square root of a
number x? We will use Newton's method of successive approximations which says
that to improve a guess square root y you can average that with x / y to get a
more accurate approximation of the square root of x.

At this point we can begin to define our implementation:

```lisp
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
```

A guess is improved by averaging it with x / guess:

```lisp
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
```

We also have to specify by what we mean by "good enough." The following will do
for now but is not really a good test:

```lisp
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```

Lastly we need a user interface:

```lisp
(define (sqrt x)
  (sqrt-iter 1.0 x))
```

#### Exercise 1.6

Alyssa P. Hacker doesn't see why `if` needs to be provided as a special form.
"Why can't I just define it as an ordinary procedure in terms of `cond`?" she
asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she
defines a new version of `if`:

```lisp
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```lisp
(new-if (= 2 3) 0 5)
```

Results in:

```lisp
5
```

And:

```lisp
(new-if (= 1 1) 0 5)
```

Results in:

```lisp
0
```

Delighted, Alyssa uses `new-if` to rewrite the square-root program:

```lisp
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
```

What happens when Alyssa attempts to use this to compute square roots? Explain.

Answer:

Recall that `new-if` is a procedure and not a special form. To evaluate a
procedure we use the substitution method (for now). Recall that to evaluate a
combination we must evaluate the operator to get the procedure and we must
evaluate all the arguments to get their values. This is not how an `if` special
form behaves. The special form will only evaluate one of its to options, not
both like a procedure. Therefore, we will evaluate both branches of `new-if` and
enter an infinite loop, the evaluation of `sqrt-iter` will never end.

#### Exercise 1.7

The `good-enough?` test used in computing square roots will not be very
effective for finding the square roots of very small numbers. Also, in real
computers, arithmetic operations are almost always performed with limited
precision. This makes our test inadequate for very large numbers. Explain these
statements, with examples showing how the test fails for small and large
numbers. An alternative strategy for implementing `good-enough?` is to watch how
`guess` changes from one iteration to the next and to stop when the change is a
very small fraction of the guess. Design a square-root procedure that uses this
kind of end test. Does this work better for small and large numbers?

Answer:

For very small numbers let us trace the example of `(sqrt 0.0001)`, recall that
the answer is 0.01.

| Guess               | Improved Guess      | (abs (- (square new-guess) x)) | good-enough? |
| ------------------- | ------------------- | ------------------------------ | ------------ |
| 1.0                 | 0.50005             | 0.249950025                    | false        |
| 0.5005              | 0.2501249900009999  | 0.062462510623003              | false        |
| 0.2501249900009999  | 0.12526239505846617 | 0.015590667615783252           | false        |
| 0.12526239505846617 | 0.06303035962394365 | 0.003872826234323667           | false        |
| 0.06303035962394365 | 0.03230844833048122 | 0.0009438358335233747          | true         |

As you can see, for small numbers, our absolute distance check has too low of a
threshold (0.001) for us to accurately calculate the square root of small
numbers.

For large numbers, the tolerance is not scaled up and due to limited precision,
the error will always be greater than the tolerance creating an infinite loop.

Here is our new `good-enough?`

```lisp
(define (good-enough-2? guess x)
  (define tolerance (* (expt 2 -52) x))
  (define next-guess (improve guess x))
  (or (= guess 0) (< (abs (- guess next-guess)) tolerance)))
```

#### Exercise 1.8

Newton's method for cube roots is based on the fact that if y is an
approximation to the cube root of x, then a better approximation is given by the
value:

```lisp
(/ (+ (/ x (square y)) (* 2 y)) 3)
```

Use this formula to implement a cube-root procedure analogous to the square-root
procedure.

Answer:

```lisp
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (define tolerance (* (expt 2 -52) x))
  (define next-guess (improve guess x))
  (or (= guess 0) (< (abs (- guess next-guess)) tolerance)))

(define (cbrt x)
  (cbrt-iter 1.0 x))
```

### 1.1.8 Procedures as Black-Box Abstractions

Note that our `sqrt-iter` procedure refers to itself in its definition. The
procedure is **_recursive_**. This may seem confusing at first but we will
explore this further.

Observe that the problem of computing square roots breaks up easily into a
number of smaller sub-problems. Each sub-problem is accomplished in its own
procedure and the entire problem can be thought of as a cluster of procedures.

When decomposing problems it is important that each piece accomplish an
identifiable and reusable task. This allows us to "not care" about smaller
pieces when building larger ones. Once the pieces work we can re-use them. One
of the key features of procedures is we can use them to suppress detail. Once we
can compute a square root does the next user really care how it is being done?

In fact, a user **should not** need to know how a procedure is implemented in
order to use it.

#### Local names

The formal parameters of procedures have special roles in that it doesn't matter
what name the formal parameter has. In other words, the meaning of a procedure
definition is unchanged if a bound variable is consistently renamed throughout
the definition. That changeable name is called a **_bound variable_** and if a
variable is not bound then it is **_free_**.

The set of expression for which a binding defines a name is called the
**_scope_** of that name.

In a procedure definition, the bound variables declared as the formal parameters
of the procedure have the body of the procedure as their scope.

For example, in `good-enough` above, `guess` and `x` are bound while `<`, `-`,
`abs`, and `square` are free.

#### Internal Definitions and Block Structure

We have only one kind of name isolation available to us so far: The formal
parameters of a procedure are local to the body of the procedure.

Note when defining `sqrt` the other procedures we defined clutter up the global
namespace. No other user may define a procedure called `improve` without
conflicting with mine. This is not ideal.

To facilitate this style of information hiding we allow procedures to have
internal procedure definitions as follows:

```lisp
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))
```

Such nesting is called **_block structure_**. It allows us to not only
internalize the definitions but also to simplify them. Notice how `x` is already
bound by `sqrt`? The procedures `good-enough?`, `improve`, and `sqrt-iter` which
are defined internally to `sqrt` are in the scope of `x`. Thus, we do not need
to pass `x` explicitly to each procedure. Instead, we allow `x` to be a free
variable in the internal definitions as seen here:

```lisp
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

This discipline is called **_lexical scoping_**.

## 1.2 Procedures and the Processes They Generate

**NB: Keep in mind the difference between a recursive procedure and a recursive
process.**

We should ask ourselves, at this point, do we know how to program? We know the
primitive arithmetic operations, we know how to combine these operations, and we
know how to abstract these combinations by defining procedures. We are in a
similar position to a person who knows how to move all the pieces in a game of
chess but does not know any of the openings, the tactics, or the strategies. We
lack the knowledge to know which moves are worth making. We lack the experience
to predict the consequences of moving a piece. Like an expert photographer we
need to learn how to look at a scene and know how the printed picture will look
based on lighting, exposure, and filters.

To become expert programmers we must learn to visualize the processes generated
by various types of procedures. To start we will try to describe some typical
patterns of process evolution. In other words we will look at the "shapes" of
processes generated by simple procedures. We will also investigate the rates at
which these procedures consume important computational resources including time
and space.

### 1.2.1 Linear Recursion and Iteration

Let us begin by recalling one way to define a factorial procedure

```lisp
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

We can then use the substitution model to observe this procedure in action
computing 6!:

```lisp
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720
```

Next let's take a different approach to computing factorials. We can describe a
rule for computing n! by specifying that we first multiply 1 by 2, then multiply
the result by 3, then by 4, and so on until we reach n. More formally, we
maintain a running product, together with a counter from 1 to n. We describe the
computation by saying that the counter and the product simultaneously change
from one step to the next according to the following rules:

- product <- counter \* product
- counter <- counter + 1

And stipulating that n! is the value of the product when the counter exceeds n.
Let's define that procedure:

```lisp
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

Then we use the substitution model to visualize the process of computing 6!:

```lisp
(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720
```

Compare these two processes. They both computer the same answer, and each
requires a number of steps proportional to n to compute n!. On the other hand,
when we consider the "shapes" of the two processes, we find that they evolve
quite differently.

Note how the substitution model reveals an expansion followed by a contraction.
The expansion is due to the build of _deferred operations_. This type of
process, characterized by a chain of deferred operations, is called a _recursive
process_. Carrying out this type of process requires the interpreter keep track
of operations to be performed during the contraction. The number of deferred
operations, in this case, grows linearly with n. Such is called a _linear
recursive process_.

On the other hand, the second process does not grow and shrink. At each step we
are keeping track of all the relevant information, there are no deferred
operations. We call this an _iterative process_, and in general, an iterative
process is one whose state can be represented by a number of state variables.
Such process is called a _linear iterative process_.

Remember not to confuse recursive procedures with recursive processes. A
recursive procedure can produce an iterative process.

Note also that Scheme can execute an iterative process in constant space. An
implementation with this property is called _tail recursive_.

#### Exercise 1.9

Each of the following two procedures defines a method for adding two positive
integers in terms of the procedures `inc`, which increments its argument by 1,
and `dec`, which decrements its argument by 1.

```lisp
(define (+a a b)
  (if (= a 0)
      b
      (inc (+a (dec a) b))))

(define (+b a b)
  (if (= a 0)
      b
      (+b (dec a) (inc b))))
```

Using the substitution model, illustrate the process generated by each procedure
in evaluating (+ 4 5). Are these process iterative or recursive?

Answer:

First, let us examine `(+a 4 5)`:

```lisp
(+a 4 5)
(inc (+a 3 5))
(inc (inc (+a 2 5)))
(inc (inc (inc (+a 1 5))))
(inc (inc (inc (inc (+a 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
```

This is a recursive process, note the deferred `inc` operations.

Next, let us examine `(+b 4 5)`:

```lisp
(+b 4 5)
(+b 3 6)
(+b 2 7)
(+b 1 8)
(+b 0 9)
9
```

This is an iterative process, there are no deferred operations.

#### Exercise 1.10

The following procedure computes a mathematical function called Ackermann's
function.

```lisp
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y)
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (-y 1)))))))
```

What are the values of the following expressions?

```lisp
(A 1 10)

(A 2 4)

(A 3 3)
```

Consider the following procedures, where `A` is defined above:

```lisp
(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))

(define (k n) (* 5 n n))
```

Give concise mathematical definitions for the functions computed by the
procedures `f`, `g`, and `h` for positive integer values of `n`. For example,
`(k n)` computes 5n^2.

Answer:

```lisp
(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 256))
(A 0 512)
1024

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16)
(A 0 (A 1 15))
(A 0 (A 0 (A 1 14)))
(A 0 (A 0 (A 0 (A 1 13))))
(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
(A 0 (A 0 (A 0 (A 0 4096))))
(A 0 (A 0 (A 0 8192)))
(A 0 (A 0 16384))
(A 0 32768)
65536

(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
(A 2 (A 1 (A 2 1)))
(A 2 (A 1 2))
(A 2 (A 0 (A 1 1)))
(A 2 (A 0 2))
(A 2 4)
65536
```

The procedure `f` is the same as 2y.

The procedure `g` is the same as 2^y.

The procedure `h` is the same as 2^(h (- n 1)) also known as tetration.

### 1.2.2 Tree Recursion

Consider computing the sequence of Fibonacci numbers, each number is the sum of
the preceding two. We can translate this into a recursive procedure:

```lisp
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

Consider this tree of computations that occurs to compute `(fib 5)`:

```lisp
(fib 5)
  (fib 4)
    (fib 3)
      (fib 2)
        (fib 1)
        (fib 0)
      (fib 1)
    (fib 2)
      (fib 1)
      (fib 0)
  (fib 3)
    (fib 2)
      (fib 1)
      (fib 0)
    (fib 1)
```

Notice all of the repeated computation, `(fib 3)` is computed two separate
times. At every step the process splits in two. This is a process that uses a
number of steps that grow exponentially with the input. On the other hand, the
space required only grows linearly with the input because we are only storing in
memory the nodes that are above the current node in the tree. All of the other
nodes that will be computed aren't in memory at that time. In general, the
number of steps required by a tree recursive process wil be proportional to the
number of nodes in the tree, wile the space required will be proportional to the
maximum depth of the tree.

We can also create an iterative process for this problem. We use a pair of
integers `a` and `b`, initialized to 1 and 0 and we use the following
simultaneous transformation steps:

- a <- a + b
- b <- a

After applying this transformation `n` times `a` and `b` will be equal to
`(fib (+ n 1))` and `(fib n)`. Here is that procedure:

```lisp
(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
```

This procedure also has the benefit of using a linear number of steps to
computer the same answer. This observation should not lead one to conclude that
tree recursive processes are useless. When we later introduce hierarchically
structured data we will find that tree recursion is a natural and powerful tool.
Tree recursive processes can also be easier to understand, the first fib
definition being also exactly the mathematical definition.

#### Example: Counting Change

How many different ways can we make change of $1.00 given half-dollars,
quarters, dimes, nickels, and pennies? Can we write a procedure that computes
the number of ways to change any given amount of money? Sure, the number of ways
to change amount `a` using `n` kinds of coins is:

- the number of ways to change amount `a` using all but the first kind of coin,
  plus
- the number of ways to change amount `a - d` using all `n` kinds of coins,
  where `d` is the denomination of the first kind of coin.
- if `a` is 0 we count that as 1 way to make change.
- if `a` is less that 0 we count that as 0 ways to make change.
- if `n` is 0 we count that as 0 ways to make change

Try applying theses rules to find the 3 ways to change 10 cents using nickels
and pennies.

Here is the procedure:

```lisp
(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
```

The `count-change` procedure generates a tree recursive process with a lot of
redundant calculations similar to our first implementation of `fib`. On the
other hand, is it obvious how to design an iterative process for this problem?

#### Exercise 1.11

A function **f** is defined by the rule that **f(n) = n** if **n < 3** and
**f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)** if **n >= 3**. Write a procedure
that computes **f** by means of a recursive process. Write a procedure that
computes **f** by means of an iterative process.

Answer:

The recursive procedure is easily written from the definition:

```lisp
(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1))
         (* 2 (f1 (- n 2)))
         (* 3 (f1 (- n 3))))))
```

Here is the iterative process:

```lisp
(define (f2 n)
  (f-iter 0 1 2 n))

(define (f-iter a b c count)
  (if (= count 0)
      a
      (f-iter b
              c
              (+ (* 3 a) (* 2 b) c)
              (- count 1))))
```

#### Exercise 1.12

The following pattern of numbers is called **Pascal's triangle**.

```text
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
```

The numbers at the edge of the triangle are all 1, and each number inside the
triangle is the sum of the two numbers above it. Write a procedure that computes
elements of Pascal's triangle by means of a recursive process.

Answer:

```lisp
(define (pascal row col)
  (if (is-edge? row col)
      1
      (+ (pascal (- row 1) col)
         (pascal (- row 1) (- col 1)))))

(define (is-edge? row col)
  (cond ((= col 0) #true)
        ((= col row) #true)
        (else #false)))
```

#### Exercise 1.13

Prove that **Fib(n)** is the closest integer to **theta^n/sqrt(5)**, where
**theta = (1 + sqrt(5)) / 2**. Hint let ?? = (1 - sqrt(5)) / 2. Use induction
and the definition of the Fibonacci numbers to prove that Fib(n) = (theta^n -
??^n) / sqrt(5).

Answer:

```lisp
(define (fib-close n)
  (/ (expt (/ (+ 1 (sqrt 5)) 2) n)
     (sqrt 5)))
```

Sorry no.

### 1.2.3 Order of Growth

We can use the notion of **_orders of growth_** to describe the rate at which a
process consumes computational resources. So far we have used n to represent the
number for which a given function is to be computed but n, could be the required
number of digits of accuracy or the number of rows in a matrix. We have seen
processes with constant, linear, and exponential growth.

#### Exercise 1.14

Draw the tree illustrating the process generated by the `count-change` procedure
of section 1.2.2 in making change for 11 cents. What are the orders of growth of
the space and number of steps used by this process as the amount to be change
increases.

```lisp
(count-change 11)
(cc 11 5)
  (cc 11 4)
    (cc 11 3)
      (cc 11 2)
        (cc 11 1)
          (cc 11 0)
          0
          (cc 10 1)
            (cc 10 0)
            0
            (cc 9 1)
              (cc 9 0)
              0
              (cc 8 1)
                (cc 8 0)
                0
                (cc 7 1)
                  (cc 7 0)
                  0
                  (cc 7 1)
                    (cc 6 0)
                    0
                    (cc 5 1)
                      (cc 5 0)
                      0
                      (cc 4 1)
                        (cc 4 0)
                        0
                        (cc 3 1)
                          (cc 3 0)
                          0
                          (cc 2 1)
                            (cc 2 0)
                            0
                            (cc 1 1)
                              (cc 1 0)
                              0
                              (cc 0 1)
                              1
        (cc 6 2)
          (cc 6 1)
            (cc 6 0)
            0
            (cc 5 1)
              (cc 5 0)
              0
              (cc 4 1)
                (cc 4 0)
                0
                (cc 3 1)
                  (cc 3 0)
                  0
                  (cc 2 1)
                    (cc 2 0)
                    0
                    (cc 1 1)
                      (cc 1 0)
                      0
                      (cc 0 1)
                      1
          (cc 1 2)
            (cc 1 1)
              (cc 1 0)
              0
              (cc 0 1)
              1
            (cc -4 2)
            0
      (cc 1 3)
        (cc 1 2)
          (cc 1 1)
            (cc 1 0)
            0
            (cc 0 1)
            1
          (cc -4 2)
          0
        (cc -9 3)
        0
    (cc -14 4)
    0
  (cc -39 5)
  0
```

The space used grows linearly with the depth of the tree so O(n) where n is the
maximum depth. The number of steps grows exponentially so O(2^n) where n is the
amount to be changed.

#### Exercise 1.15

The sine of an angle (specified in radians) can be computed by making use of the
approximation six x ~ x if x is sufficiently small, and the trigonometric
identity sin(x) = 3sin(x/3) - 4sin^3(x/3) to reduce the size of the argument of
sin. (For the purposes of this exercise an angle is considered "sufficiently
small" if its magnitude is not greater than 0.1 radians.) These ideas are
incorporated in the following procedures:

```lisp
(define (cube x) (* x x x))

(define (p x)
  (display "p")
  (newline)
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))
```

How many times is the procedure `p` applied when `(sine 12.15)` is evaluated?

Answer:

```lisp
(sine 12.15)
(p (sine 4.05))
(p (p (sine 1.35)))
(p (p (p (sine 0.45))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine 0.05))))))
(p (p (p (p (p 0.05)))))
```

5 times.

What is the order of growth in space and number of steps (as a function of `a`)
used by the process generated by the `sine` procedure when `(sine a)` is
evaluated?

Answer:

Growth in space is log(n), tripling x requires only one more deferred operation.
Growth in number of steps is is the same there are 4 steps for each `p` and
log(n) `p`'s.

### 1.2.4 Exponentiation

How do we compute the exponential of a given number? Here are two procedures,
one defines a linear recursive process requiring O(n) space and time and one an
iterative process requiring O(n) time and constant space.

```lisp
(define (expt-r b n)
  (if (= n 0)
      1
      (* b (expt-r b (- n 1)))))

(define (exprt-i b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b (- counter 1) (* b product))))
```

Observe we can compute even exponents like b^8 in two ways:

1. `b * (b * (b * (b * (b * (b * (b * b))))))`

2. b^2^2^2

We can express this faster method as follows:

```lisp
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))
```

The process grows logarithmically with n in both space and number of steps.
Computing b^2n requires only one more multiplication than computing b^n.

#### Exercise 1.16

Design a procedure that evolves an iterative exponentiation process that uses
successive squaring and uses a logarithmic number of steps, as does `fast-expt`.
(Hint: Using the observation that (b^n/2)^2 = (b^2)^n/2, keep, along with the
exponent n and the base b, an additional state variable a, and define the state
transformation in such a way that the product ab^n is unchanged from state to
state. At the beginning of the process a is taken to be 1, and the answer is
given by the value at the end of the process. In general, the technique of
defining an **_invariant quantity_** that remains unchanged from state to state
is a powerful way to think about the design of iterative algorithms.)

Answer:

```lisp
(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter base exponent acc)
  (cond ((= exponent 0) acc)
        ((even? exponent) (fast-expt-iter (* base base))
                                          (/ exponent 2)
                                          acc)
        (else (fast-expt-iter base
                              (- exponent 1)
                              (* base acc)))))
```

#### Exercise 1.17

The exponentiation algorithms in this section are based on performing
exponentiation by means of repeated multiplication. In a similar way, one can
perform integer multiplication by means of repeated addition. The following
procedure (in which it is assumed that out language can only add, not multiply)
is analogous to the `expt` procedure:

```lisp
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
```

This algorithm takes a number of steps that is linear in b. Now suppose we
include together with addition, operations `double` which doubles an integer,
and `halve`, which divines an even integer by 2. Using these, design a
multiplication procedure analogous to `fast-expt` that uses a logarithmic number
of steps.

Answer:

```lisp
(define (fast* a b)
  (cond ((= b 0) 0)
        ((even? b) (double (* a (halve b))))
        (else (+ a (fast* a (- b 1))))))

(define (double x) (+ x x))
(define (halve x) (/ x 2))
```

#### Exercise 1.18

Using the results of exercises 1.16 and 1.17, devise a procedure that generates
an iterative process for multiplying two integers in terms of adding, doubling,
and halving and uses a logarithmic numbers of steps.

Answer:

```lisp
(define (fast* a b)
  (fast*-iter a b 0))

(define (fast*-iter a b acc)
  (display "fast*-iter ")
  (display a)
  (display " ")
  (display b)
  (display " ")
  (display acc)
  (newline)
  (cond ((= b 0) acc)
        ((even? b) (fast*-iter (double a)
                               (halve b)
                               acc))
        (else (fast*-iter a
                          (- b 1)
                          (+ a acc)))))

(define (double x) (+ x x))
(define (halve x) (/ x 2))
```

#### Exercise 1.19

There is a clever algorithm for computing the Fibonacci numbers in a logarithmic
number of steps. Recall the transformation of the state variables `a` and `b` in
the `fib-iter` process of section 1.2.2:

- a <- a + b
- b <- a

Call this transformation T, and observe that applying T over and over again `n`
times, starting with 1 and 0, produces the pair Fib(n+ 1) and Fib(n). In other
words, the Fibonacci numbers are produced by applying T^n, the nth power of the
transformation T, starting with the pair (1,0). Now consider T to be the special
case of p = 0 and q = 1 in a family of transformations T sub pq, where T sub pq
transforms the pair (a, b) according to:

- a <- bq + aq + ap
- b <- bq + aq.

Show that if we apply such a transformation T sub pq twice, the effect is the
same as using a single transformation T sub p'q' of the same form, and compute
p' and q' in terms of p and q. This gives us an explicit way to square these
transformations, and thus we can compute T^n using successive squaring, as in
the `fast-expt` procedure. Put all this together to complete the following
procedure, which runs in a logarithmic number of steps:

```lisp
(define (fin b)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count) (fib-iter a
                                 b
                                 (+ (* p p) (* q q))
                                 (+ (* q q) (* 2 p q))
                                 (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
```

### 1.2.5 Greatest Common Divisors

The largest integer that divides both a and b is said to be the greatest common
divisor of a and b or GCD(a,b). For example, GCD(16,28) = 4. One way to find the
GCD of two integers is to factor both integers and then search for common facts,
but there is a famous algorithm that is much more efficient.

The idea is that if r is the remainder when a / b, then the common divisors of a
and b are the same as the common divisors of b and r, i.e. GCD(a,b) = GCD(b,r).
This allows us to reduce the problem to a smaller and smaller problem. Here is
the algorithm:

```lisp
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

#### Exercise 1.20

The process that a procedure generates is of course dependent on the rules used
by the interpreter. As an example, consider the iterative `gcd` procedure given
above. Suppose we were to interpret this procedure using normal-order
evaluation, as discussed in section 1.1.5. (The normal-order evaluation rule for
`if` is describe in exercise 1.5). Using the substitution method (for normal
order), illustrate the process generated in evaluating `(gcd 206 40)` and
indicate the `remainder` operations that are actually performed. How many
`remainder` operations are actually performed in the normal-order evaluation of
`(gcd 206 40)`? In the applicative-order evaluation?

Answer:

Here is the applicative-order process:

```lisp
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
2
```

Four `remainder` operations are performed.

Here is the normal-order process:

```lisp
(gcd 206
     40)
(gcd 40
     (% 206 40)) ; gets evaluated to determine the if predicate.
(gcd (% 206 40)
     (% 40 (% 206 40))) ; gets evaluated to determine the if predicate.
(gcd (% 40 (% 206 40))
     (% (% 206 40) (% 40 (% 206 40)))) ; gets evaluated to determine the if predicate.
(gcd (% (% 206 40) (% 40 (% 206 40))) ; gets evaluted to produce the final value, second.
     (% (% 40 (% 206 40))) (% (% 206 40) (% 40 (% 206 40)))) ; gets evaluated to determine the if predicate, first.

```

That results in four `remainder` operations being performed to produce the value
as well as fourteen `remainder` checks being done to test the `if` predicate for
eighteen in total.

### 1.2.6 Example: Testing for Primality

We will next go over two methods for checking if an integer is a prime number,
one O(sqrt(n)) and the other a probabilistic algorithm with order of growth
O(log(n)).

#### Searching for Divisors

One way to test if a number is prime is to find the number's divisors. Here is a
program that finds the smallest positive integer divisor (greater than 1) of a
given number n. It does this by testing n for divisibility by successive
integers starting with 2.

```lisp
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))
```

Then we test if a number is prime by checking if the smallest divisor of n is n.

```lisp
(define (prime? n)
  (= n (smallest-divisor n))
```

Note that we only test divisors less that the square root of n.

#### The Fermat Test

We can check if a number is prime using a probabilistic O(log(n)) test know
based on Fermat's Little Theorem:

If **n** is a prime number and **a** is any positive integer less that **n**,
then **a** raised to the **n**th power is congruent to **a** modulo **n**. (Two
numbers are said to be **congruent modulo n** if they both have the same
remainder when divided by **n**. The remainder of a number **a** when divided by
**n** is also referred to as the **remainder of a modulo n**, or simply as **a
modulo n**.)

Basically, if **n** is not prime, then, in general, most of then numbers **a**
where **a**<**n** will _not_ satisfy the above relation. We check if a number
**n** is prime by picking a number **a** where **a**<**n** and compute the
remainder of **a^n** modulo **n**. If the result is not equal to **a**, then
**n** is certainly not prime. If the result is **a** then chances are good that
**n** is prime! Now pick another number for **a** and test it using the same
method. If it also satisfies the equation, then we can be even more sure that
**n** is prime! By trying more and more values of **a** we can increase of
confidence in the result.

Here is a procedure that computes (base^exp) % m:

```lisp
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m))
                          m))))
```

Note the similarities to other procedures we have written this chapter that use
O(log(n)) steps.

To perform the Fermat test we pick a random number **a** between 1 and **n** - 1
inclusive and checking whether **a**^**n** % **n** = **a**.

Note that `random` returns an non-negative integer less that its integer input.

```lisp
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

Lastly, we run the test a given number of times. We say the test it true if it
succeeds every time.

```lisp
(define (fast-prime? n times)
  (cond ((= time 0) true)
        ((fermat-test n) (fast-rime? n (- times 1)))
        (else false)))
```

#### Probabilistic Methods

The `fast-prime?` method is weird. It does not guarantee that its answer is
correct, only that it is probably correct. We know if **n** ever fails the
Fermat test then we can be certain it is not prime. However, **n** passing the
test is not a guarantee that **n** is prime, just a strong indicator. If we
perform the test enough times and **n** always passes the test then the
probability of error in our test can be made as small as we like.

The Fermat test does have one fatal flaw. There are numbers that can fool the
test, numbers **n** that are not prime yet have, for all **a**<**n** the
property that **a^n** % **n** = **n**. The good news is there are variations of
the Fermat test that cannot be fooled.

These types of algorithms that only say the answer is probably correct are
called **_probabilistic algorithms_**.

##### Exercise 1.21

Use the `smallest-divisor` procedure to find the smallest divisor of each of the
following numbers: 199, 1999, 19999.

Answer:

```lisp
(smallest-divisor 199)
199
(smallest-divisor 1999)
1999
(smallest-divisor 19999)
7
```

##### Exercise 1.22

Most Lisp implementations include a primitive called `runtime` that returns an
integer that specifies the amount of time the system has been running (measured,
for example, in microseconds). The following `timed-prime-test` procedure, when
called with an integer **n**, prints **n** and checks to see if **n** is prime.
If **n** is prime, the procedure prints three asterisks followed by the amount
of time used in performing the test.

```lisp
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-time elapsed-time)
  (display " *** ")
  (display elapsed-time))
```

Using this procedure, write a procedure `search-for-primes` that checks the
primality of consecutive odd integers in a specified range.

Answer:

```lisp
(define (search-for-primes start end)
  (cond ((> start end) false)
        (else (timed-prime-test (first-odd-after start))
              (search-for-primes (+ (first-odd-after start) 2) end))))

(define (first-odd-after x)
  (if (even? x)
      (+ x 1)
      x))

(define (even? x)
  (= (remainder x 2) 0))
```

Use your procedure to find the three smallest primes:

- larger than 1000. Answer: 1009, 1013, 1019.
- larger than 10,000. Answer: 10,007, 10,009, 10,037.
- larger than 100,000. Answer: 100,003, 100,019, 100,043.
- larger than 1,000,000. Answer: 1,000,003, 1,000,033, 1,000,037.

Note the time needed to test each prime. Since the test algorithm has order of
growth O(sqrt(n)), you should expect that testing for primes around 10,000
should take about sqrt(10) times as long as testing for primes around 1000.

- Does your timing data bear this out?
- How well does the data for 100,000 and 1,000,000 support the sqrt(n)
  prediction?
- Is your result compatible with the notion that programs on your machine run in
  time proportional to the numbers of steps required for the computation?

Answer:

All of theses scales are so fast that the time registers as 0.

##### Exercise 1.23

The `smallest-divisor` procedure shown at the start of this section does lots of
needless testing. After is checks to see if the numbers is divisible by 2 there
is no point in checking to see if it is divisible by any larger even numbers.
This suggests that the values used for `test-divisor` should not be 2, 3, 4, 5,
6..., but rather 2, 3, 5, 7, 9... To implement this change, define a procedure
`next` that returns 3 if its input is equal to 2 and otherwise returns its input
plus 2. Modify the `smallest-divisor` procedure to use `(next test-divisor)`
instead of `(= test-divisor 1)`.

Answer:

```lisp
(define (next x)
  (if (= next 2)
      3
      (+ x 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
```

With `timed-prime-test` incorporating this modified version of
`smallest-divisor`, run the test for each of the 12 primes found in exercise
1.22. Since this modification halves the number of test steps, you should expect
it to run about twice as fast. Is this expectation confirmed? If not, what is
the observed ratio of the speeds of the two algorithms, and how do you explain
the fact that it is different from 2?

Answer:

Read online for the timing related answers.

##### Exercise 1.24

Modify the `timed-prime-test` procedure of exercise 1.22 to use `fast-prime?`
(the Fermat method), and test each of the 12 primes you found in that exercise.
Since the Fermat test has O(log(n)) growth, how would you expect the time to
test primes near 1,000,000 to compare with the time needed to test primes near
1000? Do your data bear this out? Can you explain any discrepancy you find?

Answer:

```lisp
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
      (report-prime (- (runtime) start-time))))

(define (report-time elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (fast-prime? n times)
  (cond ((= time 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

##### Exercise 1.25

Alyssa P. Hacker complains that we went to a lot of extra work in writing
`expmod`. After all, she says, since we already know how to compute
exponentials, we could have simply written

```lisp
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for out fast prime tester?
Explain.

Answer:

No this procedure computes the entire exponent before using it as the first
argument to `remainder`. Our implementation computes partials, see footnote 46.

##### Exercise 1.26

@@@ TODO

Answer:

He's evaluating `(expmod base (/ exp 2) m)` twice instead of once if it was used
as an argument to `square`.

##### Exercise 1.27

@@@ TODO

##### Exercise 1.28

@@@ TODO

## 1.3 Formulating Abstractions with Higher-Order Procedures

Up until now, our procedures have only accepted numbers as arguments. What if we
could make a procedure whose argument(s) is a procedure. Or what if we could
write a procedure that returns a procedure? Procedures that manipulate
procedures are called **_higher-order procedures_**.

### 1.3.1 Procedures as arguments

Here are three procedures, one sums the integers from a through b, one sums the
cubes of those integers, and the third computes a sum which converges to pi / 8.

```lisp
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
```

These procedures clearly share the following pattern:

```lisp
(define (<name> a b)
  (if (> a b)
      0
      (+ (<term> a) (<name> (<next a) b))))
```

The presence of such a pattern is strong evidence that there is a useful
abstraction waiting to be brought to the surface. In this case the pattern is
called summation using sigma notation. We can do the same.

```lisp
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))
```

Next, if we define a simple procedure to increment its argument by one, we can
redefine `sum-cubes`:

```lisp
(define (inc n) (+ n 1))

(define (sum-cubes a b)
  (sum cube a inc b))
```

Using a handy procedure that returns its argument we can redefine
`sum-integers`:

```lisp
(define (identity x) x)

(define (sum-integers a b)
  (sum identity a inc b))
```

Lastly, we can redefine `pi-sum` using two helpers:

```lisp
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))
```

We can even use `sum` as a building block in other procedures. Here is a
procedure that calculates the definite integral of of function f between the
limits a and b.

```lisp
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
  dx))
```

#### Exercise 1.29

Simpson's rule is a more accurate method of numerical integration that the
method illustrated above. Using Simpson's rule, the integral of a function f
between a and b is approximated as (see textbook) where h = (b -a)/n, for some
even integer n, and y of k = f(a + kh). (Increasing n increases the accuracy of
the approximation.) Define a procedure that takes as arguments f, a, b, and n
and returns the value of the integral, computed using Simpson's rule. Use your
procedure to integrate `cube` between 0 and 1 (with n = 100 and n = 1000), and
compare the results to those of the `integral` procedure shown above.

Answer:

```lisp
(define (simpson f a b n)
  (define h (/ (- b a) n))

  (define (ahh-2h x) (+ x h h))

  (* (+ (f a)
        (* 2 (sum f a add-2h b))
        (* 4 (sum f (+ a h) add-2h b))
        (f b))
     (/ h 3)))
```

#### Exercise 1.30

The `sum` procedure above generates a linear recursion. The procedure can be
rewritten so that the sum is performed iterativly. Show how to do this by
filling in the missing expression in the following definition:

```lisp
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (identity x) x)

(define (inc x) (+ x 1))

(define (sum-integers a b)
  (sum identity a inc b))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))
```

#### Exercise 1.31

a. The `sum` procedure is only the simplest of a vast number of similar
abstractions that can be captured as higher-order procedures. Write an analogous
procedure called `product` that returns the product of the values of a function
at points over a given range. Show how to define `factorial` in terms of
`product`. Also use `product` to compute approximations to pi using the (see
textbook) formula.

Answer:

```lisp
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (inc n) (+ n 1))

(define (identity n) n)

(define (factorial n)
  (product identity 1 inc n))

(define (pi-term n)
  (/ (* n (+ n 2))
     (* (+ n 1) (+ n 1))))

(define (pi-next n) (+ n 2))

(define (pi-n n)
  (* (product pi-term 2.0 pi-next n) 4))
```

b. If your`product` procedure generates a recursive process, write one that
generates an iterative process. If it generates an iterative process, write one
that generates a recursive process.

Answer:

```lisp
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
```

#### Exercise 1.32

a. Show that `sum` and `product` (exercise 1.32) are both special cases of a
still more general notion called `accumulate` that combines a collection of
terms, using some general accumulation function:

```lisp
(accumulate combiner null-value term a next b)
```

`accumulate` takes as arguments the same term and range specifications as `sum`
and `product`, together with a `combiner` procedure (of two arguments) that
specifies how the current term is to be combined with the accumulation of the
preceding terms and a `null-value` that specifies what base value to use when
the terms run out. Write `accumulate` and show how `sum` and `product` can both
be defined as simple calls to `accumulate`.

Answer:

```lisp
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))
```

b. If your `accumulate` procedure generates a recursive process, write one that
generates an iterative process. If it generates an iterative process, write one
that generates a recursive process.

Answer:

```lisp
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))
```

#### Exercise 1.33

You can obtain an even more general version of `accumulate` (exercise 1.32) by
introducing the notion of a filter on the terms to be combined. That is, combine
only those terms derived from values in the range that satisfy a specified
condition. The resulting `filtered-accumulate` abstraction takes the same
arguments as accumulate, together with an additional predicate of one argument
that specifies the filter. Write `filtered-accumulate` as a procedure. Show how
to express the following using `filtered-accumulate`:

a. The sum of the squares of the prime numbers in the interval a to b (assuming
you have a `prime?` predicate already written).

b. The product of all the positive integers less than n that are relatively
prime to n (i.e. all positive integers i < n such that GCD(i, n) = 1).

Answer:

```lisp
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (inc x) (+ x 1))

(define (identity x) x)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (prime? n)
  (= n (smallest-divisor n))

(define (relatively-prime? x y)
  (= 1 (gcd x y)))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (filtered-accumulate combiner null-value term a next b filter?)
  (cond ((> a b) null-value)
        ((filter? (term a)) (combiner (term a)
                                      (accumulate combiner null-value term (next a) next b filter?)))
        (else (accumulate combiner null-value term (next a) next b filter?))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (filter-sum term a next b filter?)
  (filtered-accumulate + 0 term a next b filter?))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (filter-product term a next b filter?)
  (filtered-accumulate * 1 term a next b filter?))

(define (answer-a a b)
  (filter-sum sqaure a inc b prime?))

(define (answer-b n)
  (filter-product identity 1 inc n relatively-prime?))
```

### 1.3.2 Constructing Procedures Using `lambda`

It has been a little awkward, so far, having to define procedures like `inc` and
`identity` just to use them as arguments. To simplify procedure definition we
introduce the special form `lambda`.

```lisp
(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))
```

The general form is:

```lisp
(lambda (<formal-parameters>) <body>)
```

The difference between `lambda` and previous procedure definition is that
procedures defined using `lambda` do not have a name. If fact, the following two
procedure definitions are identical:

```lisp
(define (plus4 x) (+ x 4))

(define plus4 (lambda (x) (+ x 4)))
```

You can also use `lambda` in a pattern now known as an immediately invoked
function expression or IIFE:

```lisp
((lambda (x y z) (+ x y (square z))) 1 2 3)
```

#### Using `let` to create local variables

Another use of `lambda` is in creating local variables. Let's say we wanted to
compute a function where computing a few intermediate values would make the rest
of the function more clear. We can already do this using auxiliary procedures:

```lisp
(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (f-helper (+ 1 (* x y))
            (- 1 y)))
```

This can be simplified using `lambda`:

```lisp
(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
  (+ 1 (* x y))
  (- 1 y)))
```

This construct is so useful that there is a special form called `let`:

```lisp
(define (f x y)
  (let ((a (+ 1 (* x y)))
       (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))
```

The general form is:

```lisp
(let ((<var1> <exp1>)
      (<var2> <exp2>)
      (<varn> <expn>))
  <body>)
```

Which is a rewritten form of `lambda` being used as an IIFE:

```lisp
((lambda (<var1> <var2> <varn>)
  <body>)
<exp1>
<exp2>
<expn>)
```

##### Exercise 1.34

Suppose we define the procedure:

```lisp
(define (f g)
  (g 2))
```

Then we have:

```lisp
(f sqaure)
4

(f (lambda (z) (* z (+ z 1))))
6
```

What happens if we (perversely) ask the interpreter to evaluate the combination
`(f f)`? Explain.

Answer:

Evaluating `(f f)` would cause the interpreter to try and evaluate `(f 2)` which
would then result in `(2 2)` and 2 is not a procedure so there would be an
error.

### 1.3.3 Procedures as General Methods

Were going to look at more procedures like `integral` that express general
concepts of computation.

#### Finding roots of equations by the half-interval method

We are going to use the half-interval method to find x where f(x) = 0 and f is a
continuous function. It's kind of like binary search but for zeros. Here is the
implementation:

```lisp
(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value) (search f neg-point midpoint))
                ((negative? test-value) (search f midpojnt pos-point))
                (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
```

However, `search` requires us to know which endpoint is the positive and
negative before using it. To simplify things we'll make a helpful wrapper
function:

```lisp
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value)) (search f a b))
          ((and (negative? b-value) (positive? a-value)) (search f b a))
          (else (error "Values are not of opposite sign" a b)))))
```

#### Finding fixed points of functions

A number x is called a fixed point of a function f if x satisfies the equation
f(x) = x. For some functions we can find the fixed point by repeatedly applying
the function to an initial guess until the output stops changing very much.

```lisp
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
```

We also learned about average damping.

#### Exercise 1.35

Answer:

```lisp
(fixed-point (lambda (y) (+ 1 (/ 1 y))) 1.0)
```

#### Exercise 1.36

Answer:

```lisp
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display "guess: ")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)
```

Average damping takes 9 steps while not using average damping takes more. I'm
not counting those lines.

#### Exercise 1.37

Answer:

```lisp
(define (cont-frac n d k)
  (define (cont-frac-helper i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i)
                    (cont-frac-helper (+ i 1))))))
  (cont-frac-helper 1))
```

K is somewhere between 10 and 100.

```lisp
(define (cont-frac n d k)
  (define (cont-frac-iter i acc)
    (if (= i 1)
        (/ (n i) (+ (d i) acc))
        (cont-frac-iter (- i 1) (/ (n i) (+ (d i) acc)))))
  (cont-frac-iter (- k 1) (/ (n k) (d k))))
```

#### Exercise 1.38

Answer:

```lisp
(cont-frac (lambda (i) 1.0)
           (lambda (i)
            (let ((rem (remainder i 3)))
              (if (or (= rem 0) (= rem 1))
                  1
                  (* (/ (+ i 1) 3) 2))))
           100)
```

#### Exercise 1.39

Answer:

```lisp
(define (tan-cf x k)
  (define (n i)
    (if (= 1 i)
        x
        (* x x)))
  (define (d i) (- (* 2 i) 1))
  (define (tan-cf-helper i)
    (if (= i k)
      (/ (n i) (d i))
      (/ (n i) (- (d i) (tan-cf-helper (+ i 1))))))
  (tan-cf-helper 1))
```

### 1.3.4 Procedures as Returned Values

We've already seen how we can pass procedures as arguments to other procedures
but now lets look at a new class of procedure, those that return procedures.
Recall average damping is the process of averaging a value x with f(x), we can
create a procedure that returns the "average-damped" version of the given
procedure:

```lisp
(define (average x y) (/ (+ x y) 2.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (square x) (* x x))

((average-damp square) 10)
```

We then review Newton's method and create a procedure that produces the
derivative of the given procedure:

```lisp
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))


(define (cube x) (* x x x))

((deriv cube) 5)

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))
```

#### Abstractions and First-class Procedures

Let's generalize the ways we've seen to compute square roots up until now, one
as a fixed-point search and one using Newton's method (which itself is a
fixed-point search).

```lisp
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (sqrt-1 x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))
(define (sqrt-2 x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))
```

As programmers, we should be alert to opportunities to identify and extract
abstractions in our programs but we must also be wary of becoming too abstract.
Higher-order procedures allow us to enhance our ability to express abstractions
by allowing us to represent other abstractions as elements in our programming
language so that they can me handled like other computational elements. In lisp,
unlike some other programming languages, functions are given first-class status
meaning they can be named by variables, passed as arguments, returned as the
result of procedures, and included in data structures (more to come on that).

#### Exercise 1.40

Answer:

```lisp
(define (cubic a b c)
  (lambda (x)
    (+ (* x x x)
       (* a x x)
       (* b x)
       c)))
```

#### Exercise 1.41

Answer:

```lisp
(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))

((double inc) 1)

(((double (double double)) inc) 5)
```

#### Exercise 1.42

Answer:

```lisp
(define (compose f g)
  (lambda (x) (f (g x))))

(define (sqaure x) (* x x))

(define (inc x) (+ x 1))

((compose square inc) 6)
```

#### Exercise 1.43

Answer:

```lisp
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (helper acc i)
    (if (= i 1)
        acc
        (helper (compose f acc) (- i 1))))
  (helper f n))

(define (square x) (* x x))

((repeated square 2) 5)
```

#### Exercise 1.44

Answer:

```lisp
(define (smooth f)
  (lambda (x) (average (f (- x dx))
                       (f x)
                       (f (+ x dx)))))

(define (n-fold-smooth f n)
  (repeated smooth n))
```

#### Exercise 1.45

Answer:

I don't feel like figuring it out so lets assume the number of average-damps
required is the ceiling of (n - 1) / 2 where n is the desired root.

```lisp
(define (num-damps n) (ceil (/ (- n 1) 2)))

(define (n-th-root n x)
  (fixed-point-of-transform (lambda (y) (/ x (exp y (- n 1))))
                            (repeated average-damp (num-damps n))
                            1.0))
```

#### Exercise 1.46

Answer:

```lisp
(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  (lambda (x) (try x)))
```
