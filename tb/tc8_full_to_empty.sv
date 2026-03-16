class tc8_full_to_empty extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC8: Full to Empty";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC8", "Filling FIFO until FULL");

    // Fill FIFO
    while(!vmon.full) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC8", "FIFO FULL detected, starting reads");

    // Read until FIFO becomes empty
    while(!vmon.empty) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 0;
      vdrv.cb.rd <= 1;
    end

    tb_logger::info("TC8", "FIFO EMPTY detected");

    // Stop read
    @(posedge vdrv.clk);
    vdrv.cb.rd <= 0;

  endtask

endclass
