module tb_top;

  bit clk;
  bit rst;

  // clock
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    #20 rst = 0;
  end

  // interface
  fifo_if intf(clk, rst);

  // DUT
  fifo_m dut(
    .clk(clk),
    .rst(rst),
    .wr(intf.wr),
    .rd(intf.rd),
    .datain(intf.datain),
    .dataout(intf.dataout),
    .empty(intf.empty),
    .full(intf.full),
    .counter(intf.counter),
    .rdptr(intf.rdptr),
    .wdptr(intf.wdptr)
  );

  // test
  test t1(intf.DRV, intf.MON);

  initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0);
  end

endmodule