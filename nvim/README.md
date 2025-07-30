# 💤 NeoVim Setup with Lazy Vim

Below is my own configuration of what I want as an editing experience with Lazyvim.

## Nice to Know

1. Vim actually puts all your yanked values into register, you can see them by executing the command `reg`.
2. To use a value from say the 3 paste it from the register by first pressing double quote (") then the register number `3` (in this case) and `p` for paste, so: "3p.
3. We can also yank something to a register by first pressing double quote (") then the register number `3` (in this case) and `y` for paste, so: "3y.
4. There is a special register (*in osx, + in linux) that is the system clipboard, so that we can yank a value into the system clipboard with: "+y (linux) or "*y (for osx).
5. There is a special register called the '%' register, which holds the name of the current filename, so `"%p` will paste the name of the current file.
6. You can assign values into the registers via the commandline by doing e.g to put a value into the system clipboard ('+' in linux), issue command: `let @+=@%` which will copy the name of the file into the system clipboard.
7. When you use macros with `q` then value you provide after activating macro recording is actually a register you just informed vim to record your commands into, so `qa` stores your recordings into `a` register. :)
8. Remember to replay your macro (recording with `q`) just run the `@{name of register}` you recorded into, so `@a`. And we can even go further by using a number before the `@{register}` to replay the action across `{number}` lines.

## Links

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
