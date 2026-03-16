`define BUF_WIDTH 3
`define BUF_SIZE (1<<`BUF_WIDTH)

interface fifo_if(input logic clk, rst);

logic wr, rd;
logic [7:0] datain;
logic [7:0] dataout;

logic empty, full;
logic [`BUF_WIDTH:0] counter;
logic [`BUF_WIDTH-1:0] rdptr, wdptr;

clocking cb @(posedge clk);
  default input #1 output #1;
  output wr, rd, datain;
  input dataout, empty, full, counter, rdptr, wdptr;
endclocking

modport DRV (clocking cb, input rst, input clk);

modport MON (
input clk,rst,
input wr,rd,datain,dataout,
input empty,full,counter,rdptr,wdptr
);

endinterface