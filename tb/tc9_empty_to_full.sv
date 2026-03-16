class tc9_empty_to_full extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC9: Empty to Full";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC9", "Starting Empty to Full Test");

    // FIFO starts empty after reset
    tb_logger::info("TC9", "Writing until FIFO becomes FULL");

    while(!vmon.full) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC9", "FIFO FULL detected");

    @(posedge vdrv.clk);
    vdrv.cb.wr <= 0;

  endtask

endclass
