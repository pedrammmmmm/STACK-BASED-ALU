# STACK-BASED-ALU
My project is a STACK BASED ALU that does some operations on the top elements of the stack.
## Tools
In this project you can use modelsim or vivado tools to compile and simulate the project files to see the result.
## Implementation Details
In this project we have one signed integer as an input with length n and we have these 5 opcodes that you can do operations on inputs with them:
+ Opcode '100': Addition
+ Opcode '101': Multiply
+ Opcode '110': PUSH
+ Opcode '111': POP
+ Opcode '0xx': No Operation (the term ‘x’ means 0 or 1)

here we see stack as a memmory that you can have signed integers in that too and use a stack pointer to see where we are.
in addition and multiplication we just do these operations on two top element of our stack with using stack pointer and put them in output.
in other operations like Push or Pop we put input data in top element of the stack or pop the top element of the stack and put in output data.

Also in addition and multiplication we check for the overflow and if it happends set the overflow flag to one.

More explanation for how does it work exactly is in the code and in STACK_BASED_ALU module you can see the comments to make sure that which section belongs to whick opcode.

## How to Run
One way to run this project is:
1. install modelsim.
2. create a new project.
3. move this files in Code folder to that project.
4. compile all files.
5. press simulation button and simulate the project and see the result.
## Result
As a result i try to solve this expression with the STACK_BASED_ALU module:

2 * 3 + (10 + 4 + 3) * -20 + (6 + 5)

the full guide for the steps that i pass through is in the report in Document folder and you can see but in the picture below i wanna show you the final result:

![result](https://github.com/pedrammmmmm/STACK-BASED-ALU/assets/122311109/66b25955-9d37-47f5-99dd-c4da7352d41b)

As you see the final result is -323, as expected.
you can see other tests and their result on STACK_BASED_ALU in in report pdf in Document folder.
