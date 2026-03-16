class tc6_read_until_empty extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC6: Read until empty";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC6", "Filling FIFO before starting read test");


    while(!vmon.full) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC6", "FIFO FULL detected, starting reads");

   
    while(!vmon.empty) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 0;
      vdrv.cb.rd <= 1;
    end

    tb_logger::info("TC6", "FIFO EMPTY detected (empty = 1)");

    // Stop read
    @(posedge vdrv.clk);
    vdrv.cb.rd <= 0;

  endtask

endclass
