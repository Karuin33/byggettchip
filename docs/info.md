<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The game starts by setting inputs knapp_comb to "11" which starts the high frequency clock that "randomizes" a 6 bit sequens of 0 and 1. The user then use combinations of knapp_comb to recreate the high/low sequence. If all is correct the output correct_out is set to '1'.

## How to test

Check how the guess and counter values changes for each clock cycle. 

## External hardware

Suggestions: 2 buttons or switches for knapp_comb, and a row of diodes to simulate correct guess and a randomized pattern. 