`define BUF_WIDTH 3
`define BUF_SIZE (1<<`BUF_WIDTH)

module fifo_m(rst, clk, datain, dataout, wr, rd, empty, full, counter, rdptr, wdptr);

input rst, clk, rd, wr;
input [7:0] datain;

output [7:0] dataout;
output empty, full;
output [`BUF_WIDTH:0] counter;

reg [7:0] dataout;
reg empty = 1, full = 0;
reg [`BUF_WIDTH:0] counter = 0;

output reg [`BUF_WIDTH-1:0] rdptr = 0, wdptr = 0;

reg [7:0] buf_mem[`BUF_SIZE-1:0];

always @(*) begin
  empty = (counter == 0);
  full  = (counter == `BUF_SIZE);
end

always @(posedge clk or posedge rst) begin
  if(rst)
    counter <= 0;
  else if((!full && wr) && (!empty && rd))
    counter <= counter;
  else if(!full && wr)
    counter <= counter + 1;
  else if(!empty && rd)
    counter <= counter - 1;
end

always @(posedge clk or posedge rst) begin
  if(rst)
    dataout <= 0;
  else if(rd && !empty)
    dataout <= buf_mem[rdptr];
end

always @(posedge clk) begin
  if(wr && !full)
    buf_mem[wdptr] <= datain;
end

always @(posedge clk or posedge rst) begin
  if(rst) begin
    wdptr <= 0;
    rdptr <= 0;
  end
  else begin
    if(wr && !full)
      wdptr <= wdptr + 1;
    if(rd && !empty)
      rdptr <= rdptr + 1;
  end
end

endmodule